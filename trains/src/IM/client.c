/*
 * client.c
 *
 * George Ferguson, ferguson@cs.rochester.edu,  9 Nov 1995
 * Time-stamp: <Wed Nov 13 16:13:54 EST 1996 ferguson>
 *
 * Note: If we get a second register for some client (ie., same name),
 * then the code in recv.c just closes the prior fd, whereas we really
 * should handle the change gracefully, including updating clientsByFd[].
 * So just don't do that, ok?
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>			/* FD_SETSIZE */
#include "client.h"
#include "listen.h"
#ifndef NO_DISPLAY
# include "display.h"
#endif
#include "util/streq.h"
#include "util/memory.h"
#include "util/error.h"
#include "util/debug.h"

/*
 * Functions defined here:
 */
Client *newClient(char *name, int fd);
void deleteClient(Client *this);
Client *findClientInList(Client *this, ClientListItem *list);
void addClientToList(Client *this, ClientListItem **list, char *client_data);
void deleteClientFromList(Client *this, ClientListItem **list);
static void freeClientList(ClientListItem *p);
static void freeClassList(ClientClassListItem *p);

ClientClass *newClientClass(char *name, ClientClass *super);
void addClientToClass(Client *this, ClientClass *class);
static void updateClassListenersRecursively(Client *this, ClientClass *class);
void deleteClientFromClass(Client *this, ClientClass *class);
void deleteClientFromClasses(Client *this);

Client *findClientByName(char *name);
Client *findOrCreateClient(char *name);
Client *findClientByFd(int fd);
void clientSetFd(Client *this, int fd);
ClientClass *findClientClassByName(char *name);

char *clientStatusString(Client *client);
void dumpClients(FILE *fp);

/*
 * Data defined here:
 */
Client *clientList;
static Client *lastClient;
static Client *clientsByFd[FD_SETSIZE];

static ClientClass anyClass = { "Any" };
ClientClass *AnyClass = &anyClass;
ClientClass *clientClassList = &anyClass;
static ClientClass *lastClientClass = &anyClass;

/*	-	-	-	-	-	-	-	-	*/

Client *
newClient(char *name, int fd)
{
    Client *this;

    DEBUG1("name = \"%s\"", name);
    if ((this=(Client*)malloc(sizeof(Client))) == NULL) {
	SYSERR0("couldn't malloc for new client");
	return NULL;
    }
    if (clientList == NULL) {
	/* First client in list */
	clientList = lastClient = this;
	this->next = this->prev = NULL;
	DEBUG1("lastClient now = 0x%lx", lastClient);
    } else {
	/* Add to end of list */
	lastClient->next = this;
	this->prev = lastClient;
	this->next = NULL;
	lastClient = this;
	DEBUG1("lastClient now = 0x%lx", lastClient);
    }
    /* Set components of client */
    this->name = gnewstr(name);
    this->state = IM_DEAD;
    this->listeners = this->monitors = NULL;
    this->classes = NULL;
    this->fd = -1;
    if (fd >= 0) {
	clientSetFd(this, fd);
    }
#ifndef NO_DISPLAY
    this->x = this->y = this->r = 0;
    this->recvCount = this->sendCount = 0;
#endif
    /* Return client */
    DEBUG0("done");
    return this;
}

void
deleteClient(Client *this)
{    
    DEBUG1("name = \"%s\"", this->name);
#ifdef undef /* I decided this needs to be decided elsewhere, eg. close.c */
    /* Remove from other listeners'/monitors' lists (if not done already) */
    if (this->state != IM_EOF) {
	clientUnlistenToClass(this, AnyClass);
	clientUnmonitorClass(this, AnyClass);
    }
#endif
    /* Remove client from class(es) */
    deleteClientFromClasses(this);
    /* Delete from global list of clients */
    if (this == clientList) {
	/* Deleting head of list */
	clientList = clientList->next;
	if (clientList != NULL) {
	    clientList->prev = NULL;
	}
    } else {
	/* Deleting in list */
	if (this->next != NULL) {
	    this->next->prev = this->prev;
	}
	if (this->prev != NULL) {
	    this->prev->next = this->next;
	}
    }
    /* Adjust end of list if needed */
    if (this == lastClient) {
	DEBUG1("lastClient now = 0x%lx", lastClient);
	lastClient = this->prev;
    }
    /* Free components of client */
    gfree(this->name);
    /* Free list of listeners (but not listening clients themselves) */
    freeClientList(this->listeners);
    freeClientList(this->monitors);
    freeClassList(this->classes);
    /* Finally, free client itself */
    free((char*)this);
#ifndef NO_DISPLAY
    displayDoLayout();
#endif
    /* Done */
    DEBUG0("done");
}

Client *
findClientInList(Client *this, ClientListItem *list)
{
    while (list) {
	if (list->client == this) {
	    return this;
	}
	list = list->next;
    }
    return NULL;
}

void
addClientToList(Client *this, ClientListItem **list, char *client_data)
{
    ClientListItem *p;

    if ((p=(ClientListItem*)malloc(sizeof(ClientListItem))) == NULL){
	SYSERR0("couldn't malloc for new ClientListItem");
	return;
    }
    p->client = this;
    p->client_data = client_data;
    p->next = *list;
    *list = p;
    DEBUG0("done");
}

void
deleteClientFromList(Client *this, ClientListItem **list)
{
    ClientListItem *p, *lastp, *nextp;

    for (p=*list; p != NULL; lastp=p, p=nextp) {
	nextp = p->next;
	if (p->client == this) {
	    if (p == *list) {
		/* Deleting front of list */
		*list = p->next;
	    } else {
		/* Otherwise */
		lastp->next = p->next;
	    }
	    /* Free list item */
	    if (p->client_data) {
		free(p->client_data);
	    }
	    free(p);
	    break;
	}
    }
    DEBUG0("done");
}

static void
freeClientList(ClientListItem *p)
{
    ClientListItem *nextp;

    while (p != NULL) {
	nextp = p->next;
	free((char*)p);
	p = nextp;
    }
}

static void
freeClassList(ClientClassListItem *p)
{
    ClientClassListItem *nextp;

    while (p != NULL) {
	nextp = p->next;
	free((char*)p);
	p = nextp;
    }
}

/*	-	-	-	-	-	-	-	-	*/

ClientClass *
newClientClass(char *name, ClientClass *super)
{
    ClientClass *this;
    ClientClassListItem* p;

    DEBUG1("name=\"%s\"", name);
    if ((this=(ClientClass*)malloc(sizeof(ClientClass))) == NULL) {
	SYSERR0("couldn't malloc for new class");
	return NULL;
    }
    memset((char*)this, '\0', sizeof(ClientClass));
    if (clientClassList == NULL) {
	/* First class in list */
	clientClassList = lastClientClass = this;
	this->next = this->prev = NULL;
    } else {
	/* Add to end of list */
	lastClientClass->next = this;
	this->prev = lastClientClass;
	this->next = NULL;
	lastClientClass = this;
    }
    /* Set components of class */
    this->name = gnewstr(name);
    this->superclass = super;
    this->clients = this->listeners = this->monitors = NULL;
    this->subclasses = NULL;
    /* Add to superclass */
    if (super != NULL) {
	DEBUG1("adding to super=%s", super->name);
	if ((p=(ClientClassListItem*)malloc(sizeof(ClientClassListItem))) == NULL){
	    SYSERR0("couldn't malloc for new ClientClassListItem");
	    return(NULL);
	}
	/* Add to front */
	p->class = this;
	p->next = super->subclasses;
	super->subclasses = p;
    }
    /* Return class */
    DEBUG0("done");
    return this;
}

void
addClientToClass(Client *this, ClientClass *class)
{
    ClientClassListItem *cl;

    DEBUG2("this=%s, class=%s", this->name, class->name);
    /* Scan to see if already here */
    if (findClientInList(this, class->clients)) {
	DEBUG0("found in clients already");
	return;
    }
    /* Ok, add class to client's class list */
    DEBUG0("adding to class to client list");
    if ((cl=(ClientClassListItem*)malloc(sizeof(ClientClassListItem))) == NULL) {
	SYSERR0("couldn't malloc for ClientClassListItem");
	return;
    }
    cl->class = class;
    cl->next = this->classes;
    this->classes = cl;
    /* And add client to class' client list */
    addClientToList(this, &(class->clients), NULL);
    /* Now add client to listeners for each client listening to this class */
    DEBUG0("updating class listeners");
    updateClassListenersRecursively(this, class);
    DEBUG0("done");
}

static void
updateClassListenersRecursively(Client *this, ClientClass *class)
{
    ClientListItem *p;

    DEBUG2("this=%s, class=%s", this->name, class->name);
    for (p=class->listeners; p != NULL; p=p->next) {
	clientListenToClient(p->client, this);
    }
    /* Recurse up to class' parent */
    if (class->superclass != NULL) {
	updateClassListenersRecursively(this, class->superclass);
    }
    DEBUG0("done");
}

void
deleteClientFromClass(Client *this, ClientClass *class)
{
    DEBUG2("this=%s, class=%s", this->name, class->name);
    deleteClientFromList(this, &(class->clients));
    /*
     * Technically need to delete class from client's class list, but
     * since we only ever do this prior to destroying the client,
     * why bother?
     */
    DEBUG0("done");
}

void
deleteClientFromClasses(Client *this)
{
    ClientClassListItem *c, *nextc;

    DEBUG1("this=%s", this->name);
    for (c=this->classes; c != NULL; c=nextc) {
	nextc = c->next;
	deleteClientFromClass(this, c->class);
	free((char*)c);
    }
    this->classes = NULL;
    DEBUG0("done");
}

/*	-	-	-	-	-	-	-	-	*/

Client *
findClientByName(char *name)
{
    Client *c;

    for (c=clientList; c != NULL; c=c->next) {
	if (STREQ(c->name, name)) {
	    return c;
	}
    }
    return NULL;
}

Client *
findOrCreateClient(char *name)
{
    Client *c;

    if ((c = findClientByName(name)) != NULL) {
	return c;
    }
    return newClient(name, -1);
}

/*
 * This uses a per-fd cache since it needs to be fast. See below.
 */
Client *
findClientByFd(int fd)
{
    return clientsByFd[fd];
}

/*
 * This is called from to set a client fd when we get a REGISTER
 * message (recv.c), and to clear the cached setting when we close an
 * fd (close.c).
 *   FD    THIS     Meaning
 *   -1    NULL     no-op
 *   -1    !NULL    find new repr. for this->fd
 *   >=0   NULL     erase repr. for fd
 *   >=0   !NULL    make this repr. if no repr. yet
 */
void
clientSetFd(Client *this, int fd)
{
    Client *c;

    DEBUG2("client=%s, fd=%d", this ? this->name : "<null>", fd);
    if (fd < 0) {
	/* If fd is invalid... */
	if (this == NULL || this->fd < 0) {
	    /* ...Then if client invalid, bag it */
	    DEBUG0("nothing to do");
	} else {
	    /* Otherwise we don't want to be repr. anymore */
	    if (this == clientsByFd[this->fd]) {
		DEBUG1("clearing repr. for fd=%d", this->fd);
		clientsByFd[this->fd] = NULL;
		for (c=clientList; c != NULL; c=c->next) {
		    if (c != this && c->fd == this->fd) {
			clientsByFd[this->fd] = c;
			DEBUG2("new repr. for fd=%d is %s", this->fd, c->name);
			break;
		    }
		}
	    DEBUG1("setting client %s fd=-1", this->name);
	    this->fd = -1;
	    }
	}
    } else {
	/* Else fd >= 0, so if client is NULL... */
	if (this == NULL) {
	    /* ...Just wipe out any repr. for this fd */
	    DEBUG1("erasing repr. at fd=%d", fd);
	    clientsByFd[fd] = NULL;
	} else {
	    /* Otherwise we have a client and an fd, so set this client's fd */
	    DEBUG2("setting client %s fd=%d", this->name, fd);
	    this->fd = fd;
	    /* And if we're the first registered client for this fd */
	    if (clientsByFd[fd] == NULL) {
		/* Then become the representative */
		DEBUG1("client is new repr. at fd=%d", fd);
		clientsByFd[fd] = this;
	    }
	}
    }
    DEBUG0("done");
}

ClientClass *
findClientClassByName(char *name)
{
    ClientClass *c;

    for (c=clientClassList; c != NULL; c=c->next) {
	if (STREQ(c->name, name)) {
	    return c;
	}
    }
    return NULL;
}

/*	-	-	-	-	-	-	-	-	*/

char *
clientStatusString(Client *client)
{
    char *s;

    switch (client->state) {
      case IM_DEAD: s = "dead"; break;
      case IM_LISTENING: s = "listening"; break;
      case IM_CONNECTED: s = "connected"; break;
      case IM_READY: s = "ready"; break;
      case IM_EOF: s = "eof"; break;
      default: s = "!unknown!";
    }
    return s;
}

void
dumpClients(FILE *fp)
{
    Client *p, *q;
    ClientListItem *l;
    ClientClass *c;
    ClientClassListItem *cl;
    char st;
    int n, k;

    if (fp == NULL) {
	return;
    }
    fprintf(fp, "#  Name              St Fd  Listeners+Monitors\n");
    for (n=0,p=clientList; p != NULL; n++,p=p->next) {
	/* Print information from client struct */
	st = *(clientStatusString(p));
	if (islower(st)) {
	    st = toupper(st);
	}
	fprintf(fp,"%2d %-16s  %c  %2d ", n, p->name, st, p->fd);
	/* Print client classes */
	for (cl=p->classes; cl != NULL; cl=cl->next) {
	    fprintf(fp, "%s ", cl->class->name);
	}
	/* Print listeners by process number (slow but who cares) */
	for (l=p->listeners; l != NULL; l=l->next) {
	    for (k=0,q=clientList; q != NULL; k++,q=q->next) {
		if (q == l->client) {
		    fprintf(fp,"%2d ", k);
		    break;
		}
	    }
	}
	/* Print monitors by process number (slow but who cares) */
	fprintf(fp, "+ ");
	for (l=p->monitors; l != NULL; l=l->next) {
	    for (k=0,q=clientList; q != NULL; k++,q=q->next) {
		if (q == l->client) {
		    fprintf(fp,"%2d ", k);
		    break;
		}
	    }
	}
	fprintf(fp,"\n");
    }
    for (c=clientClassList; c != NULL; c=c->next) {
	fprintf(fp, "%s: ", c->name);
	for (l=c->clients; l != NULL; l=l->next) {
	    fprintf(fp, "%s ", l->client->name);
	}
	/* Print listeners by process number (slow but who cares) */
	for (l=c->listeners; l != NULL; l=l->next) {
	    for (k=0,q=clientList; q != NULL; k++,q=q->next) {
		if (q == l->client) {
		    fprintf(fp,"%2d ", k);
		    break;
		}
	    }
	}
	fprintf(fp, "\n");
    }
	    
}
