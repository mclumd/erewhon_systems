/*
 * recv.c: Messages sent to the AM
 *
 * George Ferguson, ferguson@cs.rochester.edu,  2 Jan 1996
 * Time-stamp: <Tue Nov 12 12:01:49 EST 1996 ferguson>
 *
 */
#include <stdio.h>
#include "trlib/parse.h"
#include "trlib/error.h"
#include "util/buffer.h"
#include "util/error.h"
#include "util/debug.h"
#include "recv.h"
#include "main.h"
#include "display.h"

/*
 * Functions defined here:
 */
void receiveMsg(KQMLPerformative *perf);
static void receiveRequestHideWindow(KQMLPerformative *perf, char **contents);
static void receiveRequestShowWindow(KQMLPerformative *perf, char **contents);
static void receiveRequestExit(KQMLPerformative *perf, char **contents);
static void receiveTellStartConv(KQMLPerformative *perf, char **contents);
static void receiveTellEndConv(KQMLPerformative *perf, char **contents);

/*
 * Data defined here:
 */
static TrlibParseDef defs[] = {
    { "request",	"chdir",		NULL },
    { "request",	"hide-window",		receiveRequestHideWindow },
    { "request",	"show-window",		receiveRequestShowWindow },
    { "request",	"exit",			receiveRequestExit },
    { "tell",		"start-conversation",	receiveTellStartConv },
    { "tell",		"end-conversation",	receiveTellEndConv },
    { NULL,		NULL,			NULL }
};

/*	-	-	-	-	-	-	-	-	*/

void
receiveMsg(KQMLPerformative *perf)
{
    DEBUG1("verb=%s", KQML_VERB(perf));
    trlibParsePerformative(perf, defs);
    DEBUG0("done");
}

static void
receiveRequestHideWindow(KQMLPerformative *perf, char **contents)
{
    DEBUG0("");
    displayHideWindow();
    DEBUG0("done");
}

static void
receiveRequestShowWindow(KQMLPerformative *perf, char **contents)
{
    DEBUG0("");
    displayShowWindow();
    DEBUG0("done");
}

static void
receiveRequestExit(KQMLPerformative *perf, char **contents)
{
    int status = 0;

    DEBUG0("");
    if (contents[1] != NULL) {
	status = atoi(contents[1]);
    }
    programExit(status);
    DEBUG0("done");
}

static void
receiveTellStartConv(KQMLPerformative *perf, char **contents)
{
    DEBUG0("");
    displayEnableMeter(0);
    DEBUG0("done");
}

static void
receiveTellEndConv(KQMLPerformative *perf, char **contents)
{
    DEBUG0("");
    displayEnableMeter(1);
    DEBUG0("done");
}

