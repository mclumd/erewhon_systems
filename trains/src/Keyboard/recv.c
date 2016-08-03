/*
 * recv.c : Message input for Keyboard Manager
 *
 * George Ferguson, ferguson@cs.rochester.edu, 17 Jul 1996
 * Time-stamp: <Sat Nov 16 11:16:11 EST 1996 ferguson>
 */
#include <stdio.h>
#include "trlib/parse.h"
#include "util/debug.h"
#include "recv.h"
#include "display.h"

/*
 * Functions defined here:
 */
void receiveMsg(KQMLPerformative *perf);
static void receiveTellStartConv(KQMLPerformative *perf, char **contents);
static void receiveTellEndConv(KQMLPerformative *perf, char **contents);
static void receiveRequestExit(KQMLPerformative *perf, char **contents);
static void receiveRequestHideWindow(KQMLPerformative *perf, char **contents);
static void receiveRequestShowWindow(KQMLPerformative *perf, char **contents);
static void receiveRequestReset(KQMLPerformative *perf, char **contents);
static void receiveRequestGrab(KQMLPerformative *perf, char **contents);
static void receiveRequestUngrab(KQMLPerformative *perf, char **contents);
static void receiveRequestAddText(KQMLPerformative *perf, char **contents);

/*
 * Data defined here:
 */
static TrlibParseDef defs[] = {
    { "tell",		"start-conversation",	receiveTellStartConv },
    { "tell",		"end-conversation",	receiveTellEndConv },
    { "request",	"exit",			receiveRequestExit },
    { "request",	"hide-window",		receiveRequestHideWindow },
    { "request",	"show-window",		receiveRequestShowWindow },
    { "request",	"reset",		receiveRequestReset },
    { "request",	"grab",			receiveRequestGrab },
    { "request",	"ungrab",		receiveRequestUngrab },
    { "request",	"add-text",		receiveRequestAddText },
    { "request",	"chdir",		NULL },
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

/*	-	-	-	-	-	-	-	-	*/

static void
receiveTellStartConv(KQMLPerformative *perf, char **contents)
{
    DEBUG0("");
    displayReset();
    displayShowWindow();
    DEBUG0("done");
}

static void
receiveTellEndConv(KQMLPerformative *perf, char **contents)
{
    DEBUG0("");
    displayHideWindow();
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
receiveRequestReset(KQMLPerformative *perf, char **contents)
{
    DEBUG0("");
    displayReset();
    DEBUG0("done");
}

static void
receiveRequestGrab(KQMLPerformative *perf, char **contents)
{
    DEBUG0("");
    displayGrabKeyboard();
    DEBUG0("done");
}

static void
receiveRequestUngrab(KQMLPerformative *perf, char **contents)
{
    DEBUG0("");
    displayUngrabKeyboard();
    DEBUG0("done");
}

static void
receiveRequestAddText(KQMLPerformative *perf, char **contents)
{
    char *s;

    DEBUG0("");
    if (contents[1] && (s=KQMLParseThing(contents[1]))) {
	displayAddText(s);
	free(s);
    }
    DEBUG0("done");
}
