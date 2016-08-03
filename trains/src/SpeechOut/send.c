/*
 * send.c
 *
 * George Ferguson, ferguson@cs.rochester.edu, 12 Jan 1996
 * Time-stamp: <96/03/21 10:27:50 ferguson>
 */
#include <stdio.h>
#include <stdlib.h>
#include "trlib/send.h"
#include "util/error.h"
#include "util/debug.h"
#include "send.h"

/*
 * Functions defined here:
 */
void sendMonitorMsg(void);
void sendOpenMsg(void);
void sendReadyMsg(void);
void sendDrainMsg(KQMLPerformative *perf);
void sendIndexReply(KQMLPerformative *perf, int value);
void sendDoneReply(KQMLPerformative *perf);

/*	-	-	-	-	-	-	-	-	*/

void
sendMonitorMsg(void)
{
    KQMLPerformative *perf;

    DEBUG0("");
    if ((perf = KQMLNewPerformative("monitor")) == NULL) {
	return;
    }
    KQMLSetParameter(perf, ":receiver", "IM");
    KQMLSetParameter(perf, ":content", "(status audio)");
    trlibSendPerformative(stdout, perf);
    KQMLFreePerformative(perf);
    DEBUG0("done");
}

void
sendOpenMsg(void)
{
    KQMLPerformative *perf;

    DEBUG0("");
    if ((perf = KQMLNewPerformative("request")) == NULL) {
	return;
    }
    KQMLSetParameter(perf, ":receiver", "audio");
    KQMLSetParameter(perf, ":content", "(open :name speech-out :rate 16000 :precision 16 :encoding linear :direction output)");
    trlibSendPerformative(stdout, perf);
    KQMLFreePerformative(perf);
    DEBUG0("done");
}

void
sendReadyMsg(void)
{
    KQMLPerformative *perf;

    DEBUG0("send ready to pm");
    if ((perf = KQMLNewPerformative("tell")) == NULL) {
	return;
    }
    KQMLSetParameter(perf, ":receiver", "IM");
    KQMLSetParameter(perf, ":content", "(ready)");
    trlibSendPerformative(stdout, perf);
    KQMLFreePerformative(perf);
    DEBUG0("done");
}

void
sendDrainMsg(KQMLPerformative *perf)
{
    static KQMLPerformative *req;
    char *sender, *oldtag, *newtag;

    DEBUG0("");
    if (req == NULL) {
	if ((req = KQMLNewPerformative("request")) == NULL) {
	    return;
	}
	KQMLSetParameter(req, ":receiver", "audio");
	KQMLSetParameter(req, ":content", "(drain speech-out)");
    }
    /* Make a reply-to tag that we can use later to send our own replies */
    if (perf &&  (sender = KQMLGetParameter(perf, ":sender")) != NULL) {
	DEBUG1("making reply tag for sender=%s", sender);
	/* Was there a reply-with on the original mesage? */
	if ((oldtag = KQMLGetParameter(perf, ":reply-with")) != NULL) {
	    /* Yes, so our tag will be (SENDER TAG) */
	    DEBUG1("original reply-with=%s", oldtag);
	    if ((newtag=malloc(strlen(sender) + strlen(oldtag) + 4)) == NULL) {
		SYSERR0("couldn't malloc for newtag");
		return;
	    }
	    sprintf(newtag, "(%s %s)", sender, oldtag);
	    KQMLSetParameter(req, ":reply-with", newtag);
	    free(newtag);
	} else {
	    /* No, so our tag will be simply the original SENDER */
	    DEBUG0("no original reply-with");
	    KQMLSetParameter(req, ":reply-with", sender);
	}
    }
    /* Ship it */
    trlibSendPerformative(stdout, req);
    DEBUG0("done");
}

void
sendIndexReply(KQMLPerformative *perf, int value)
{
    KQMLPerformative *reply;
    char content[32];

    DEBUG0("sending index reply");
    if ((reply = KQMLNewPerformative("reply")) == NULL) {
	return;
    }
    KQMLSetParameter(reply, ":receiver", KQMLGetParameter(perf, ":sender"));
    KQMLSetParameter(reply, ":in-reply-to",
		     KQMLGetParameter(perf,":reply-with"));
    sprintf(content, "(done %d)", value);
    KQMLSetParameter(reply, ":content", content);
    trlibSendPerformative(stdout, reply);
    KQMLFreePerformative(reply);
    DEBUG0("done");
}

void
sendDoneReply(KQMLPerformative *perf)
{
    static KQMLPerformative *reply;

    DEBUG0("sending done reply");
    if (reply == NULL) {
	if ((reply = KQMLNewPerformative("reply")) == NULL) {
	    return;
	}
    }
    KQMLSetParameter(reply, ":receiver", KQMLGetParameter(perf, ":sender"));
    KQMLSetParameter(reply, ":in-reply-to",
		     KQMLGetParameter(perf,":reply-with"));
    KQMLSetParameter(reply, ":content", "(done)");
    trlibSendPerformative(stdout, reply);
    DEBUG0("done");
}
