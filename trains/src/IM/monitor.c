/*
 * monitor.c
 *
 * George Ferguson, ferguson@cs.rochester.edu, 30 Jul 1996
 * Time-stamp: <Tue Nov 12 18:50:39 EST 1996 ferguson>
 */
#include <stdio.h>
#include "client.h"
#include "util/memory.h"
#include "util/debug.h"

/*
 * Functions defined here:
 */
void clientMonitorClient(Client *this, Client *client, char *reply_with);
void clientMonitorClass(Client *this, ClientClass *class, char *reply_with);
void clientMonitorAny(Client *this, char *reply_with);
void clientUnmonitorClient(Client *this, Client *client);
void clientUnmonitorClass(Client *this, ClientClass *class);
void clientUnmonitorAny(Client *this);
static void addClientToMonitors(Client *this, Client *client, char *reply_with);
static void deleteClientFromMonitors(Client *this, Client *client);
static void addClientToClassMonitors(ClientClass *this, Client *client, char *reply_with);
static void deleteClientFromClassMonitors(ClientClass *this, Client *client);

/*	-	-	-	-	-	-	-	-	*/
/*
 * THIS monitor CLIENT => Add THIS to CLIENT'S monitors
 */
void
clientMonitorClient(Client *this, Client *client, char *reply_with)
{
    DEBUG2("this=%s, client=%s", this->name, client->name);
    addClientToMonitors(client, this, reply_with);
    DEBUG0("done");
}

void
clientMonitorClass(Client *this, ClientClass *class, char *reply_with)
{
    ClientListItem *p;
    ClientClassListItem *q;

    DEBUG2("this=%s, class=%s", this->name, class->name);
    /* Do all clients in this class */
    for (p=class->clients; p != NULL; p=p->next) {
	addClientToMonitors(p->client, this, reply_with);
    }
    /* Recurse to subclasses */
    for (q=class->subclasses; q != NULL; q=q->next) {
	clientMonitorClass(this, q->class, reply_with);
    }
    /* Store in monitoring */
    addClientToClassMonitors(class, this, reply_with);
    DEBUG0("done");
}

void
clientMonitorAny(Client *this, char *reply_with)
{
    DEBUG1("this=%s", this->name);
    clientMonitorClass(this, AnyClass, reply_with);
    DEBUG0("done");
}

/*
 * THIS unmonitor CLIENT => Remove THIS from CLIENT'S listeners
 */
void
clientUnmonitorClient(Client *this, Client *client)
{
    DEBUG2("this=%s, client=%s", this->name, client->name);
    deleteClientFromMonitors(client, this);
    DEBUG0("done");
}

void
clientUnmonitorClass(Client *this, ClientClass *class)
{
    ClientListItem *p;
    ClientClassListItem *q;

    DEBUG2("this=%s, class=%s", this->name, class->name);
    /* Do all clients in this class */
    for (p=class->clients; p != NULL; p=p->next) {
	deleteClientFromMonitors(p->client, this);
    }
    /* Recurse to subclasses */
    for (q=class->subclasses; q != NULL; q=q->next) {
	clientUnmonitorClass(this, q->class);
    }
    /* Update class monitoring */
    deleteClientFromClassMonitors(class, this);
    DEBUG0("done");
}

void
clientUnmonitorAny(Client *this)
{
    DEBUG1("this=%s", this->name);
    clientUnmonitorClass(this, AnyClass);
    DEBUG0("done");
}

/*	-	-	-	-	-	-	-	-	*/

static void
addClientToMonitors(Client *this, Client *client, char *reply_with)
{
    DEBUG2("this=%s, client=%s", this->name, client->name);
    if (!findClientInList(client, this->monitors)) {
	DEBUG0("adding to monitors");
	addClientToList(client, &(this->monitors), gnewstr(reply_with));
    }
    DEBUG0("done");
}

static void
deleteClientFromMonitors(Client *this, Client *client)
{
    DEBUG2("this=%s, client=%s", this->name, client->name);
    deleteClientFromList(client, &(this->monitors));
    DEBUG0("done");
}

static void
addClientToClassMonitors(ClientClass *this, Client *client, char *reply_with)
{
    DEBUG2("this=%s, client=%s", this->name, client->name);
    if (!findClientInList(client, this->monitors)) {
	DEBUG0("adding to monitors");
	addClientToList(client, &(this->monitors), gnewstr(reply_with));
    }
    DEBUG0("done");
}

static void
deleteClientFromClassMonitors(ClientClass *this, Client *client)
{
    DEBUG2("this=%s, client=%s", this->name, client->name);
    deleteClientFromList(client, &(this->monitors));
    DEBUG0("done");
}
