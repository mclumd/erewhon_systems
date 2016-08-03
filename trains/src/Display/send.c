/*
 * send.c
 *
 * George Ferguson, ferguson@cs.rochester.edu, 10 Apr 1996
 * Time-stamp: <Tue Nov 12 13:41:53 EST 1996 ferguson>
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
