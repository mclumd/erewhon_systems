/*
 * send.c
 *
 * George Ferguson, ferguson@cs.rochester.edu, 12 Jan 1996
 * Time-stamp: <96/09/04 15:04:05 ferguson>
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
void sendReadyMsg(void);
void sendDoneReply(KQMLPerformative *perf);

/*	-	-	-	-	-	-	-	-	*/

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
