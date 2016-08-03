/*
 * reply.c
 *
 * George Ferguson, ferguson@cs.rochester.edu, 30 Jan 1996
 * Time-stamp: <96/08/01 15:34:48 ferguson>
 */
#include <stdio.h>
#include "reply.h"
#include "client.h"
#include "send.h"
#include "util/error_codes.h"
#include "util/error.h"
#include "util/debug.h"

/*
 * Functions defined here:
 */
void errorReply(KQMLPerformative *perf, int code, char *comment);
void statusReplyClient(KQMLPerformative *perf, Client *c);
void statusReplyClass(KQMLPerformative *perf, ClientClass *class);

/*	-	-	-	-	-	-	-	-	*/

void
errorReply(KQMLPerformative *perf, int code, char *comment)
{
    KQMLPerformative *err;
    Client *sender;
    char *name;
    char num[8], text[256];

    DEBUG0("sending error reply");
    if ((name = KQMLGetParameter(perf, ":sender")) == NULL) {
        DEBUG0("no :sender in perf, can't send error reply");
	return;
    }
    if ((sender = findClientByName(name)) == NULL) {
        DEBUG1("no client named \"%s\", can't send error reply", name);
	return;
    }
    if ((err = KQMLNewPerformative("error")) == NULL) {
	ERROR0("couldn't create error performative");
	return;
    }
    KQMLSetParameter(err, ":sender", "IM");
    KQMLSetParameter(err, ":receiver", sender->name);
    KQMLSetParameter(err, ":in-reply-to",KQMLGetParameter(perf,":reply-with"));
    sprintf(num, "%d", code);
    KQMLSetParameter(err, ":code", num);
    sprintf(text, "\"%s: %s\"", errorCodeToString(code), comment);
    KQMLSetParameter(err, ":comment", text);
    sendPerformative(sender, err);
    KQMLFreePerformative(err);
    DEBUG0("done");
}

void
statusReplyClient(KQMLPerformative *perf, Client *c)
{
    KQMLPerformative *reply;
    Client *sender;
    char *name;
    char content[256];

    DEBUG0("sending status reply");
    if ((name = KQMLGetParameter(perf, ":sender")) == NULL) {
        DEBUG0("no :sender in perf, can't send status reply");
	return;
    }
    if ((sender = findClientByName(name)) == NULL) {
        DEBUG1("no client named \"%s\", can't send status reply", name);
	return;
    }
    if ((reply = KQMLNewPerformative("reply")) == NULL) {
	ERROR0("couldn't create reply performative");
	return;
    }
    KQMLSetParameter(reply, ":sender", "im");
    KQMLSetParameter(reply, ":receiver", sender->name);
    KQMLSetParameter(reply, ":in-reply-to",
		     KQMLGetParameter(perf,":reply-with"));
    sprintf(content, "(status %s %s)", c->name, clientStatusString(c));
    KQMLSetParameter(reply, ":content", content);
    sendPerformative(sender, reply);
    KQMLFreePerformative(reply);
    DEBUG0("done");
}

void
statusReplyClass(KQMLPerformative *perf, ClientClass *class)
{
    ClientListItem *l;

    for (l=class->clients; l != NULL; l=l->next) {
	statusReplyClient(perf, l->client);
    }
}
