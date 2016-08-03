/*
 * status.c
 *
 * George Ferguson, ferguson@cs.rochester.edu, 23 Feb 1996
 * Time-stamp: <96/08/01 14:58:10 ferguson>
 */
#include <stdio.h>
#include "KQML/KQML.h"
#include "status.h"
#include "send.h"
#ifndef NO_DISPLAY
# include "display.h"
#endif
#include "util/error.h"
#include "util/debug.h"

/*
 * Functions defined here:
 */
void
clientSetStatus(Client *c, ClientState state);

/*	-	-	-	-	-	-	-	-	*/

void
clientSetStatus(Client *c, ClientState state)
{
    static KQMLPerformative *reply = NULL;
    char content[64];
    ClientListItem *l;

    DEBUG2("client=%s, state=%d", c->name, state);
    /* Set state */
    c->state = state;
#ifndef NO_DISPLAY
    displayStatus(c);
#endif
    /* And broadcast state change to all monitors */
    if (reply == NULL) {
	if ((reply = KQMLNewPerformative("reply")) == NULL) {
	    ERROR0("couldn't create reply performative");
	    return;
	}
	KQMLSetParameter(reply, ":sender", "im");
    }
    sprintf(content, "(status %s %s)", c->name, clientStatusString(c));
    KQMLSetParameter(reply, ":content", content);
    DEBUG0("broadcasting status message");
    for (l=c->monitors; l != NULL; l=l->next) {
	KQMLSetParameter(reply, ":receiver", l->client->name);
	if (l->client_data) {
	    KQMLSetParameter(reply, ":in-reply-to", l->client_data);
	}
	sendPerformative(l->client, reply);
    }
    DEBUG0("done");
}
