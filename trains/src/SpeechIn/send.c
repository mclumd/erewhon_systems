/*
 * send.c
 *
 * George Ferguson, ferguson@cs.rochester.edu, 19 Jan 1996
 * Time-stamp: <96/08/13 14:58:55 ferguson>
 *
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

/*	-	-	-	-	-	-	-	-	*/

void
sendReadyMsg(void)
{
    KQMLPerformative *perf;

    DEBUG0("");
    if ((perf = KQMLNewPerformative("tell")) == NULL) {
	return;
    }
    KQMLSetParameter(perf, ":receiver", "IM");
    KQMLSetParameter(perf, ":content", "(ready)");
    trlibSendPerformative(stdout, perf);
    KQMLFreePerformative(perf);
    DEBUG0("done");
}

