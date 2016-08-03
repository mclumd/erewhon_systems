/*
 * recv.c
 *
 * George Ferguson, ferguson@cs.rochester.edu,  8 Feb 1996
 * Time-stamp: <Mon Nov 11 18:37:47 EST 1996 ferguson>
 */
#include <stdio.h>
#include "trlib/parse.h"
#include "trlib/error.h"
#include "util/memory.h"
#include "util/debug.h"
#include "recv.h"
#include "display.h"
#include "main.h"
#include "conv.h"

/*
 * Functions defined here:
 */
void receiveMsg(KQMLPerformative *perf);
static void receiveTellStartConv(KQMLPerformative *perf, char **contents);
static void receiveTellEndConv(KQMLPerformative *perf, char **contents);
static void receiveRequestExit(KQMLPerformative *perf, char **contents);
static void receiveRequestHideWindow(KQMLPerformative *perf, char **contents);
static void receiveRequestShowWindow(KQMLPerformative *perf, char **contents);

/*
 * Data defined here:
 */
static TrlibParseDef defs[] = {
    { "tell",		"start-conversation",	receiveTellStartConv },
    { "tell",		"end-conversation",	receiveTellEndConv },
    { "request",	"exit",			receiveRequestExit },
    { "request",	"hide-window",		receiveRequestHideWindow },
    { "request",	"show-window",		receiveRequestShowWindow },
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
    char *name = NULL, *lang = NULL, *sex = NULL;
    char *intro = NULL, *goals = NULL, *scoring = NULL;

    DEBUG0("");
    /* First word of contents was "start-conversation" */
    contents += 1;
    /* Parse remaining contents args */
    while (*contents) {
	/* Check for key/value pair */
	if (contents[1] == NULL) {
	    trlibErrorReply(perf, ERR_MISSING_ARGUMENT, contents[0]);
	    return;
	}
	/* Save value */
	if (STREQ(contents[0], ":name")) {
	    name = KQMLParseThing(contents[1]);
	} else if (STREQ(contents[0], ":lang")) {
	    lang = KQMLParseThing(contents[1]);
	} else if (STREQ(contents[0], ":sex")) {
	    sex = KQMLParseThing(contents[1]);
	} else if (STREQ(contents[0], ":intro")) {
	    intro = KQMLParseThing(contents[1]);
	} else if (STREQ(contents[0], ":goals")) {
	    goals = KQMLParseThing(contents[1]);
	} else if (STREQ(contents[0], ":scoring")) {
	    scoring = KQMLParseThing(contents[1]);
	}
	/* Next key/value pair */
	contents += 2;
    }
    convStart(name, lang, sex, intro, goals, scoring);
    gfree(name);
    gfree(lang);
    gfree(sex);
    DEBUG0("done");
}

static void
receiveTellEndConv(KQMLPerformative *perf, char **contents)
{
    DEBUG0("");
    convEnd();
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
