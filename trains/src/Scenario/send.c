/*
 * send.c
 *
 * George Ferguson, ferguson@cs.rochester.edu, 23 May 1996
 * Time-stamp: <Wed Nov 13 16:09:35 EST 1996 ferguson>
 */
#include <stdio.h>
#include "KQML/KQML.h"
#include "trlib/send.h"
#include "util/error.h"
#include "util/debug.h"
#include "send.h"

/*
 * Functions defined here:
 */
void sendReadyMsg(void);
void sendUnmonitorMsg(void);
void sendRequestToDM(char *content);

/*	-	-	-	-	-	-	-	-	*/

void
sendReadyMsg(void)
{
    KQMLPerformative *perf;

    /* Monitor status at outset to know when to send initial scenario */
    DEBUG0("sending (MONITOR (STATUS DM)) to IM");
    if ((perf = KQMLNewPerformative("monitor")) == NULL) {
	return;
    }
    KQMLSetParameter(perf, ":receiver", "IM");
    KQMLSetParameter(perf, ":content", "(status DM)");
    trlibSendPerformative(stdout, perf);
    KQMLFreePerformative(perf);
    DEBUG0("sending ready to IM");
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
sendUnmonitorMsg(void)
{
    KQMLPerformative *perf;

    /* Stop monitoring status */
    DEBUG0("sending (UNMONITOR (STATUS DM)) to IM");
    if ((perf = KQMLNewPerformative("unmonitor")) == NULL) {
	return;
    }
    KQMLSetParameter(perf, ":receiver", "IM");
    KQMLSetParameter(perf, ":content", "(status DM)");
    trlibSendPerformative(stdout, perf);
    KQMLFreePerformative(perf);
}

void
sendRequestToDM(char *content)
{
    static KQMLPerformative *perf = NULL;

    DEBUG1("sending %s to DM", content);
    if (perf == NULL) {    
	if ((perf = KQMLNewPerformative("request")) == NULL) {
	    return;
	}
	KQMLSetParameter(perf, ":receiver", "DM");
    }
    KQMLSetParameter(perf, ":content", content);
    trlibSendPerformative(stdout, perf);
    DEBUG0("done");
}
