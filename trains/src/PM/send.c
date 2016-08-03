/*
 * send.c : Handles sending messages from the PM
 *
 * George Ferguson, ferguson@cs.rochester.edu,  8 Apr 1995
 * Time-stamp: <96/04/05 14:41:25 ferguson>
 */
#include <stdio.h>
#include "KQML/KQML.h"
#include "trlib/send.h"
#include "trlib/error.h"
#include "util/error.h"
#include "util/debug.h"
#include "send.h"
#include "im.h"

/*
 * Functions defined here:
 */
void sendRegisterAndReadyMsgs(void);

/*	-	-	-	-	-	-	-	-	*/

void
sendRegisterAndReadyMsgs(void)
{
    KQMLPerformative *perf;

    DEBUG0("registering as PM");
    if ((perf = KQMLNewPerformative("register")) == NULL) {
	return;
    }
    KQMLSetParameter(perf, ":receiver", "IM");
    KQMLSetParameter(perf, ":name", "PM");
    trlibSendPerformative(stdout, perf);
    KQMLFreePerformative(perf);
    /* Also tell the IM we're ready */
    if ((perf = KQMLNewPerformative("tell")) == NULL) {
	return;
    }
    KQMLSetParameter(perf, ":receiver", "IM");
    KQMLSetParameter(perf, ":content", "(ready)");
    trlibSendPerformative(stdout, perf);
    KQMLFreePerformative(perf);
    DEBUG0("done");
}
