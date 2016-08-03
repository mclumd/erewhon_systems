/*
 * send.c : Message output for Keyboard Manager
 *
 * George Ferguson, ferguson@cs.rochester.edu, 17 Jul 1996
 * Time-stamp: <Tue Nov 12 13:42:46 EST 1996 ferguson>
 */
#include <stdio.h>
#include "KQML/KQML.h"
#include "trlib/send.h"
#include "util/debug.h"
#include "send.h"

/*
 * Functions defined here:
 */
void sendReadyMsg(void);
void sendSpeechMsg(char *content);
void sendMsg(char *content);

/*	-	-	-	-	-	-	-	-	*/

void
sendReadyMsg(void)
{
    KQMLPerformative *perf;

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
sendSpeechMsg(char *content)
{
    static KQMLPerformative *perf;

    DEBUG1("sending %s to SPEECH-IN", content);
    if (perf == NULL) {
	if ((perf = KQMLNewPerformative("request")) == NULL) {
	    return;
	}
	KQMLSetParameter(perf, ":receiver", "SPEECH-IN");
    }
    KQMLSetParameter(perf, ":content", content);
    trlibSendPerformative(stdout, perf);
    DEBUG0("done");
}

void
sendMsg(char *content)
{
    static KQMLPerformative *perf = NULL;

    DEBUG0("sending ready to IM");
    if (perf == NULL) {
	if ((perf = KQMLNewPerformative("tell")) == NULL) {
	    return;
	}
    }
    KQMLSetParameter(perf, ":content", content);
    trlibSendPerformative(stdout, perf);
    DEBUG0("done");
}    
