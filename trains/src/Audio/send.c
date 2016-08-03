/*
 * send.c : Messages sent by the AM
 *
 * George Ferguson, ferguson@cs.rochester.edu,  2 Jan 1996
 * Time-stamp: <96/10/16 17:04:58 ferguson>
 *
 * I used to have code in here that would use a client (stdoutClient)
 * to prevent blocking when writing a message (to the IM). However, I
 * have decided that that is so unlikely as to not be worth it, and I
 * have gone to using the trlib routine (trlibSendPerformative()).
 */
#include <stdio.h>
#include "trlib/hostname.h"
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
