/*
 * im_broadcast.c: Broadcast messages from one client to listeners, v2.0
 *
 * George Ferguson, ferguson@cs.rochester.edu, 7 Nov 1995
 * Time-stamp: <Tue Nov 12 14:31:32 EST 1996 ferguson>
 *
 * NOTE: We set the :receiver paramater for each client receiving the
 * broadcast. This makes it easier for applications that "represent"
 * several clients (ie., share an IM connection). It means, however,
 * that the receiver can't tell that this was originally a broadcast.
 * If that distinction becomes necessary, we could change this, for
 * example to wrap the thing in a BROADCAST or FORWARD performative (blech).
 */
#include <stdio.h>
#include "bcast.h"
#include "send.h"
#include "util/error.h"
#include "util/debug.h"

/*
 * Functions defined here:
 */
void broadcastPerformative(Client *sender, KQMLPerformative *perf);
void broadcastPerformativeToListeners(Client *sender, KQMLPerformative *perf);

/*	-	-	-	-	-	-	-	-	*/

void
broadcastPerformative(Client *sender, KQMLPerformative *perf)
{
    Client *p;

    DEBUG0("");
    for (p=clientList; p != NULL; p=p->next) {
	if (p != sender) {
	    KQMLSetParameter(perf, ":receiver", p->name);
	    sendPerformative(p, perf);
	}
    }
    DEBUG0("done");
}

void
broadcastPerformativeToListeners(Client *sender, KQMLPerformative *perf)
{
    ClientListItem *l;

    DEBUG0("");
    for (l=sender->listeners; l != NULL; l=l->next) {
	KQMLSetParameter(perf, ":receiver", l->client->name);
	sendPerformative(l->client, perf);
    }
    DEBUG0("done");
}

