/*
 * listen.c
 *
 * George Ferguson, ferguson@cs.rochester.edu, 30 Jul 1996
 * Time-stamp: <96/09/11 19:40:09 ferguson>
 */
#include <stdio.h>
#include "client.h"
#include "util/debug.h"

/*
 * Functions defined here:
 */
void clientListenToClient(Client *this, Client *client);
void clientListenToClass(Client *this, ClientClass *class);
void clientListenToAny(Client *this);
void clientUnlistenToClient(Client *this, Client *client);
void clientUnlistenToClass(Client *this, ClientClass *class);
void clientUnlistenToAny(Client *this);
static void addClientToListeners(Client *this, Client *client);
static void deleteClientFromListeners(Client *this, Client *client);
static void addClientToClassListeners(ClientClass *this, Client *client);
static void deleteClientFromClassListeners(ClientClass *this, Client *client);

/*	-	-	-	-	-	-	-	-	*/
/*
 * THIS listen to CLIENT => Add THIS to CLIENT'S listeners
 */
void
clientListenToClient(Client *this, Client *client)
{
    DEBUG2("this=%s, client=%s", this->name, client->name);
    addClientToListeners(client, this);
    DEBUG0("done");
}

void
clientListenToClass(Client *this, ClientClass *class)
{
    ClientListItem *p;
    ClientClassListItem *q;

    DEBUG2("this=%s, class=%s", this->name, class->name);
    /* Do all clients in this class */
    for (p=class->clients; p != NULL; p=p->next) {
	addClientToListeners(p->client, this);
    }
    /* Recurse to subclasses */
    for (q=class->subclasses; q != NULL; q=q->next) {
	clientListenToClass(this, q->class);
    }
    /* Store in class listeners */
    addClientToClassListeners(class, this);
    DEBUG0("done");
}

void
clientListenToAny(Client *this)
{
    DEBUG1("this=%s", this->name);
    clientListenToClass(this, AnyClass);
    DEBUG0("done");
}

/*
 * THIS unlisten to CLIENT => Remove THIS from CLIENT'S listeners
 */
void
clientUnlistenToClient(Client *this, Client *client)
{
    DEBUG2("this=%s, client=%s", this->name, client->name);
    deleteClientFromListeners(client, this);
    DEBUG0("done");
}

void
clientUnlistenToClass(Client *this, ClientClass *class)
{
    ClientListItem *p;
    ClientClassListItem *q;

    DEBUG2("this=%s, class=%s", this->name, class->name);
    /* Do all clients in this class */
    for (p=class->clients; p != NULL; p=p->next) {
	deleteClientFromListeners(p->client, this);
    }
    /* Recurse to subclasses */
    for (q=class->subclasses; q != NULL; q=q->next) {
	clientUnlistenToClass(this, q->class);
    }
    /* Update class listeners*/
    deleteClientFromClassListeners(class, this);
    DEBUG0("done");
}

void
clientUnlistenToAny(Client *this)
{
    DEBUG1("this=%s", this->name);
    clientUnlistenToClass(this, AnyClass);
    DEBUG0("done");
}

/*	-	-	-	-	-	-	-	-	*/

static void
addClientToListeners(Client *this, Client *client)
{
    DEBUG2("this=%s, client=%s", this->name, client->name);
    if (!findClientInList(client, this->listeners)) {
	DEBUG0("adding to listeners");
	addClientToList(client, &(this->listeners), NULL);
    }
    DEBUG0("done");
}

static void
deleteClientFromListeners(Client *this, Client *client)
{
    DEBUG2("this=%s, client=%s", this->name, client->name);
    deleteClientFromList(client, &(this->listeners));
    DEBUG0("done");
}

static void
addClientToClassListeners(ClientClass *this, Client *client)
{
    DEBUG2("this=%s, client=%s", this->name, client->name);
    if (!findClientInList(client, this->listeners)) {
	DEBUG0("adding to listeners");
	addClientToList(client, &(this->listeners), NULL);
    }
    DEBUG0("done");
}

static void
deleteClientFromClassListeners(ClientClass *this, Client *client)
{
    DEBUG2("this=%s, client=%s", this->name, client->name);
    deleteClientFromList(client, &(this->listeners));
    DEBUG0("done");
}
