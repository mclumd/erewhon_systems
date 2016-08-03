/*
 * send.c
 *
 * George Ferguson, ferguson@cs.rochester.edu, 13 Jan 1996
 * Time-stamp: <Tue Nov 12 13:43:31 EST 1996 ferguson>
 */
#include <stdio.h>
#include "KQML/KQML.h"
#include "trlib/send.h"
#include "util/debug.h"
#include "send.h"
#include "display.h"		/* listenTo, sendTo */

/*
 * Functions defined here:
 */
void sendReadyMsg(void);
void sendStartMsg(void);
void sendStopMsg(void);
void sendOfflineMsg(int state);

/*	-	-	-	-	-	-	-	-	*/

void
sendReadyMsg(void)
{
    KQMLPerformative *perf;
    char buf[64];

    /* Listen */
    DEBUG0("sending listens to IM");
    if ((perf = KQMLNewPerformative("request")) == NULL) {
	return;
    }
    KQMLSetParameter(perf, ":receiver", "IM");
    sprintf(buf, "(listen %s)", listenTo);
    KQMLSetParameter(perf, ":content", buf);
    trlibSendPerformative(stdout, perf);
    KQMLFreePerformative(perf);
    /* Monitor */
    DEBUG0("sending monitors to IM");
    if ((perf = KQMLNewPerformative("monitor")) == NULL) {
	return;
    }
    KQMLSetParameter(perf, ":receiver", "IM");
    sprintf(buf, "(status %s)", listenTo);
    KQMLSetParameter(perf, ":content", buf);
    trlibSendPerformative(stdout, perf);
    KQMLFreePerformative(perf);
    /* Ready */
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
sendStartMsg(void)
{
    static KQMLPerformative *perf;

    DEBUG0("sending start to SPEECH-IN");
    if (perf == NULL) {
	if ((perf = KQMLNewPerformative("request")) == NULL) {
	    return;
	}
	KQMLSetParameter(perf, ":receiver", sendTo);
	KQMLSetParameter(perf, ":content", "(start)");
    }
    trlibSendPerformative(stdout, perf);
    DEBUG0("done");
}

void
sendStopMsg(void)
{
    static KQMLPerformative *perf;

    DEBUG0("sending stop to SPEECH-IN");
    if (perf == NULL) {
	if ((perf = KQMLNewPerformative("request")) == NULL) {
	    return;
	}
	KQMLSetParameter(perf, ":receiver", sendTo);
	KQMLSetParameter(perf, ":content", "(stop)");
    }
    trlibSendPerformative(stdout, perf);
    DEBUG0("done");
}

void
sendOfflineMsg(int state)
{
    static KQMLPerformative *perf;
    char content[16];

    DEBUG1("sending (offline %s) to SPEECH-PP", (state ? "t" : "nil"));
    if (perf == NULL) {
	if ((perf = KQMLNewPerformative("request")) == NULL) {
	    return;
	}
	KQMLSetParameter(perf, ":receiver", "speech-pp");
    }
    sprintf(content, "(offline %s)", (state ? "t" : "nil"));
    KQMLSetParameter(perf, ":content", content);
    trlibSendPerformative(stdout, perf);
    DEBUG0("done");
}
