/*
 * send.c
 *
 * George Ferguson, ferguson@cs.rochester.edu, 22 Mar 1996
 * Time-stamp: <96/08/16 11:52:37 ferguson>
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
void sendMsg(char *perf);

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
sendMsg(char *perf)
{
    DEBUG1("sending %s", perf);
    printf("%s\n", perf);
    fflush(stdout);
    DEBUG0("done");
}
