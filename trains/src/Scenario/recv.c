/*
 * recv.c
 *
 * George Ferguson, ferguson@cs.rochester.edu, 23 May 1996
 * Time-stamp: <Tue Nov 12 11:07:09 EST 1996 ferguson>
 */
#include <stdio.h>
#include "trlib/parse.h"
#include "trlib/error.h"
#include "util/memory.h"
#include "util/debug.h"
#include "recv.h"
#include "display.h"
#include "main.h"
#include "send.h"

/*
 * Functions defined here:
 */
void receiveMsg(KQMLPerformative *perf);
static void receiveRequestDefine(KQMLPerformative *perf, char **contents);
static void receiveRequestExit(KQMLPerformative *perf, char **contents);
static void receiveRequestHideWindow(KQMLPerformative *perf, char **contents);
static void receiveRequestShowWindow(KQMLPerformative *perf, char **contents);
static void receiveTellEndConv(KQMLPerformative *perf, char **contents);
static void receiveReplyStatus(KQMLPerformative *perf, char **contents);

/*
 * Data defined here:
 */
static TrlibParseDef defs[] = {
    { "request",	"define",		receiveRequestDefine },
    { "request",	"exit",			receiveRequestExit },
    { "request",	"hide-window",		receiveRequestHideWindow },
    { "request",	"show-window",		receiveRequestShowWindow },
    { "request",	"chdir",		NULL },
    { "tell",		"start-conversation",	NULL },
    { "tell",		"end-conversation",	receiveTellEndConv },
    { "reply",		"status",		receiveReplyStatus },
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
receiveRequestDefine(KQMLPerformative *perf, char **contents)
{
    char *label = NULL, *content = NULL;
    
    DEBUG0("");
    /* First word of contents was "define" */
    contents += 1;
    /* Parse remaining contents args */
    while (*contents) {
	/* Check for key/value pair */
	if (contents[1] == NULL) {
	    trlibErrorReply(perf, ERR_MISSING_ARGUMENT, contents[0]);
	    return;
	}
	/* Save value */
	if (STREQ(contents[0], ":label")) {
	    label = KQMLParseThing(contents[1]);
	} else if (STREQ(contents[0], ":content")) {
	    content = KQMLParseThing(contents[1]);
	} else {
	    trlibErrorReply(perf, ERR_BAD_VALUE, contents[0]);
	    return;
	}
	/* Next key/value pair */
	contents += 2;
    }
    /* Check for required args */
    if (label == NULL) {
	trlibErrorReply(perf, ERR_MISSING_PARAMETER, ":label");
	return;
    }
    if (content == NULL) {
	trlibErrorReply(perf, ERR_MISSING_PARAMETER, ":content");
	return;
    }
    /* And update the scenario buttons */
    displayNewPreset(label, content);
    gfree(label);
    gfree(content);
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
receiveTellEndConv(KQMLPerformative *perf, char **contents)
{
    DEBUG0("");
    displayEndConversation();
    DEBUG0("done");
}

static void
receiveReplyStatus(KQMLPerformative *perf, char **contents)
{
    DEBUG0("");
    /* Now wait for DM to be READY */
    if (contents[1] && STREQ(contents[1], "DM") &&
	contents[2] && STREQ(contents[2], "READY")) {
	displaySetInitialScenario();
	sendUnmonitorMsg();
    }
    DEBUG0("done");
}

