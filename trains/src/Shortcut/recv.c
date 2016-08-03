/*
 * recv.c
 *
 * George Ferguson, ferguson@cs.rochester.edu, 22 Mar 1996
 * Time-stamp: <96/08/15 17:52:15 ferguson>
 */
#include <stdio.h>
#include "trlib/parse.h"
#include "trlib/error.h"
#include "util/debug.h"
#include "recv.h"
#include "display.h"
#include "main.h"

/*
 * Functions defined here:
 */
void receiveMsg(KQMLPerformative *perf);
static void receiveRequestDefine(KQMLPerformative *perf, char **contents);
static void receiveRequestExit(KQMLPerformative *perf, char **contents);
static void receiveRequestHideWindow(KQMLPerformative *perf, char **contents);
static void receiveRequestShowWindow(KQMLPerformative *perf, char **contents);

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

/*	-	-	-	-	-	-	-	-	*/

static void
receiveRequestDefine(KQMLPerformative *perf, char **contents)
{
    char *label, *content;
    
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
    /* Ok, create a new message entry */
    displayNewMessage(label, content);
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
