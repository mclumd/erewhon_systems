/*
 * recv.c
 *
 * George Ferguson, ferguson@cs.rochester.edu, 19 Jan 1996
 * Time-stamp: <96/10/09 15:22:18 ferguson>
 */
#include <stdio.h>
#include "trlib/parse.h"
#include "trlib/error.h"
#include "util/memory.h"
#include "util/error.h"
#include "util/debug.h"
#include "recv.h"
#include "utt.h"

/*
 * Functions defined here:
 */
void receiveMsg(KQMLPerformative *perf);
static void receiveRequestStart(KQMLPerformative *perf, char **contents);
static void receiveRequestStop(KQMLPerformative *perf, char **contents);
static void receiveRequestChdir(KQMLPerformative *perf, char **contents);
static void receiveRequestExit(KQMLPerformative *perf, char **contents);
static void receiveTellStartConv(KQMLPerformative *perf, char **contents);

/*
 * Data defined here:
 */
static TrlibParseDef defs[] = {
    { "request",	"start",		receiveRequestStart },
    { "request",	"stop",			receiveRequestStop },
    { "request",	"chdir",		receiveRequestChdir },
    { "request",	"exit",			receiveRequestExit },
    { "request",	"hide-window",		NULL },
    { "request",	"show-window",		NULL },
    { "tell",		"start-conversation",	receiveTellStartConv },
    { "tell",		"end-conversation",	NULL },
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
receiveRequestStart(KQMLPerformative *perf, char **contents)
{
    DEBUG0("");
    uttStart();
    DEBUG0("done");
}

static void
receiveRequestStop(KQMLPerformative *perf, char **contents)
{
    DEBUG0("");
    uttStop();
    DEBUG0("done");
}

static void
receiveRequestChdir(KQMLPerformative *perf, char **contents)
{
    char *dir;

    DEBUG0("");
    if (contents[1] == NULL) {
	trlibErrorReply(perf, ERR_MISSING_ARGUMENT, "chdir");
    } else {
	dir = KQMLParseThing(contents[1]);
	uttChdir(dir);
	gfree(dir);
    }
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
    exit(status);
}

static void
receiveTellStartConv(KQMLPerformative *perf, char **contents)
{
    DEBUG0("");
    uttReset();
    DEBUG0("done");
}
