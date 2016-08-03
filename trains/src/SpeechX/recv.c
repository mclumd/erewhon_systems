/*
 * recv.c
 *
 * George Ferguson, ferguson@cs.rochester.edu, 1 Feb 1996
 * Time-stamp: <96/10/22 14:13:41 ferguson>
 */
#include <stdio.h>
#include "trlib/parse.h"
#include "trlib/error.h"
#include "util/debug.h"
#include "recv.h"
#include "display.h"
#include "main.h"
#include "utt.h"

/*
 * Functions defined here:
 */
void receiveMsg(KQMLPerformative *perf);
static void receiveTellStart(KQMLPerformative *perf, char **contents);
static void receiveTellInputEnd(KQMLPerformative *perf, char **contents);
static void receiveTellEnd(KQMLPerformative *perf, char **contents);
static void receiveTellWord(KQMLPerformative *perf, char **contents);
static void receiveTellBackto(KQMLPerformative *perf, char **contents);
static void receiveTellStartConv(KQMLPerformative *perf, char **contents);
static void receiveTellEndConv(KQMLPerformative *perf, char **contents);
static void receiveRequestExit(KQMLPerformative *perf, char **contents);
static void receiveRequestHideWindow(KQMLPerformative *perf, char **contents);
static void receiveRequestShowWindow(KQMLPerformative *perf, char **contents);
static void receiveRequestReset(KQMLPerformative *perf, char **contents);
static void receiveReplyStatus(KQMLPerformative *perf, char **contents);
static void receiveRequestSetButton(KQMLPerformative *perf, char **contents);

/*
 * Data defined here:
 */
static TrlibParseDef defs[] = {
    { "tell",		"start",		receiveTellStart },
    { "tell",		"input-end",		receiveTellInputEnd },
    { "tell",		"end",			receiveTellEnd },
    { "tell",		"word",			receiveTellWord },
    { "tell",		"backto",		receiveTellBackto },
    { "tell",		"start-conversation",	receiveTellStartConv },
    { "tell",		"end-conversation",	receiveTellEndConv },
    { "request",	"exit",			receiveRequestExit },
    { "request",	"hide-window",		receiveRequestHideWindow },
    { "request",	"show-window",		receiveRequestShowWindow },
    { "request",	"reset",		receiveRequestReset },
    { "reply",		"status",		receiveReplyStatus },
    { "request",	"chdir",		NULL },
    { "request",	"set-button",		receiveRequestSetButton },
    { "request",	"unset-button",		receiveRequestSetButton },
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
receiveTellStart(KQMLPerformative *perf, char **contents)
{
    char *sender;

    DEBUG0("");
    /* Get sender so we know which display to update */
    if ((sender = KQMLGetParameter(perf, ":sender")) == NULL) {
	trlibErrorReply(perf, ERR_MISSING_PARAMETER, ":sender");
	return;
    }
    if (contents[1] && STREQ(contents[1], ":uttnum") && contents[2]) {
	uttStart(sender, atoi(contents[2]));
    } else {
	DEBUG0("ignoring start without :uttnum");
    }    
    DEBUG0("done");
}

static void
receiveTellInputEnd(KQMLPerformative *perf, char **contents)
{
    DEBUG0("ignoring input-end");
}

static void
receiveTellEnd(KQMLPerformative *perf, char **contents)
{
    char *sender;

    DEBUG0("");
    /* Get sender so we know which display to update */
    if ((sender = KQMLGetParameter(perf, ":sender")) == NULL) {
	trlibErrorReply(perf, ERR_MISSING_PARAMETER, ":sender");
	return;
    }
    if (contents[1] && STREQ(contents[1], ":uttnum") && contents[2]) {
	uttEnd(sender, atoi(contents[2]));
    } else {
	DEBUG0("ignoring end without :uttnum");
    }    
    DEBUG0("done");
}

static void
receiveTellWord(KQMLPerformative *perf, char **contents)
{
    char *sender, *word, *w;
    int start = -1, end = -1, uttnum = -1;
    
    DEBUG0("");
    /* Get sender so we know which display to update */
    if ((sender = KQMLGetParameter(perf, ":sender")) == NULL) {
	trlibErrorReply(perf, ERR_MISSING_PARAMETER, ":sender");
	return;
    }
    /* Token `word' was first in contents, then value of word */
    if ((w = contents[1]) == NULL) {
	trlibErrorReply(perf, ERR_MISSING_ARGUMENT, "word");
	return;
    }
    /* Convert word from KQML string to char* (we allow token or string) */
    if ((word = KQMLParseThing(w)) == NULL) {
	trlibErrorReply(perf, ERR_BAD_ARGUMENT, w);
	return;
    }
    DEBUG1("word=\"%s\"", word);
    /* Now process remaining arguments */
    contents += 2;
    while (contents[0]) {
	/* Check for key/value pair */
	if (contents[1] == NULL) {
	    trlibErrorReply(perf, ERR_MISSING_ARGUMENT, contents[0]);
	    return;
	}
	/* Save value */
	if (STREQ(contents[0], ":index")) {
	    if (sscanf(contents[1], "(%d %d)", &start, &end) == 2) {
		DEBUG2("start=%d, end=%d", start, end);
	    } else if (sscanf(contents[1], "%d", &start) == 1) {
		DEBUG1("start=%d", start);
		end = start + 1;
	    } else {
		trlibErrorReply(perf, ERR_BAD_ARGUMENT, contents[1]);
		return;
	    }
	} else if (STREQ(contents[0], ":uttnum")) {
	    if (sscanf(contents[1], "%d", &uttnum) == 1) {
		DEBUG1("uttnum=%d", uttnum);
	    } else {
		trlibErrorReply(perf, ERR_BAD_ARGUMENT, contents[1]);
		return;
	    }
	}
	/* Next key/value pair */
	contents += 2;
    }
    /* Check for required arguments */
    if (start == -1) {
	trlibErrorReply(perf, ERR_MISSING_PARAMETER, ":index");
	return;
    }
    if (uttnum == -1) {
	trlibErrorReply(perf, ERR_MISSING_PARAMETER, ":uttnum");
	return;
    }
    /* Ok, finally we can update the display */
    uttWord(sender, word, start, end, uttnum);
    DEBUG0("done");
}

static void
receiveTellBackto(KQMLPerformative *perf, char **contents)
{
    char *sender;
    int index = -1, uttnum = -1;
    
    DEBUG0("");
    /* Get sender so we know which display to update */
    if ((sender = KQMLGetParameter(perf, ":sender")) == NULL) {
	trlibErrorReply(perf, ERR_MISSING_PARAMETER, ":sender");
	return;
    }
    /* First element of contents was `backto' */
    contents += 1;
    /* Now process remaining arguments */
    while (contents[0]) {
	/* Check for key/value pair */
	if (contents[1] == NULL) {
	    trlibErrorReply(perf, ERR_MISSING_ARGUMENT, contents[0]);
	    return;
	}
	/* Save value */
	if (STREQ(contents[0], ":index")) {
	    if (sscanf(contents[1], "%d", &index) == 1) {
		DEBUG1("index=%d", index);
	    } else {
		trlibErrorReply(perf, ERR_BAD_ARGUMENT, contents[1]);
		return;
	    }
	} else if (STREQ(contents[0], ":uttnum")) {
	    if (sscanf(contents[1], "%d", &uttnum) == 1) {
		DEBUG1("uttnum=%d", uttnum);
	    } else {
		trlibErrorReply(perf, ERR_BAD_ARGUMENT, contents[1]);
		return;
	    }
	}
	/* Next key/value pair */
	contents += 2;
    }
    /* Check for required arguments */
    if (index == -1) {
	trlibErrorReply(perf, ERR_MISSING_PARAMETER, ":index");
	return;
    }
    if (uttnum == -1) {
	trlibErrorReply(perf, ERR_MISSING_PARAMETER, ":uttnum");
	return;
    }
    /* Ok, finally we can update the display (NULL word indicates backup) */
    uttWord(sender, NULL, index, -1, uttnum);
    DEBUG0("done");
}

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
receiveReplyStatus(KQMLPerformative *perf, char **contents)
{
    XClient who;
    XStatus what;

    DEBUG0("");
    if (contents[1] == NULL) {
	trlibErrorReply(perf, ERR_MISSING_ARGUMENT, "name");
    } else if (contents[2] == NULL) {
	trlibErrorReply(perf, ERR_MISSING_ARGUMENT, "status");
    } else if (strncasecmp(contents[1], "speech-in", 9) == 0) {
	who = CLIENT_SPEECH_IN;
    } else if (strncasecmp(contents[1], "speech-pp", 9) == 0) {
	who = CLIENT_SPEECH_PP;
    } else {
	trlibErrorReply(perf, ERR_BAD_VALUE, contents[1]);
    }
    if (STREQ(contents[2], "ready")) {
	what = STATUS_GREEN;
    } else if (STREQ(contents[2], "connected")) {
	what = STATUS_YELLOW;
    } else {
	what = STATUS_RED;
    }
    displaySetStatus(who, what);
    DEBUG0("done");
}

static void
receiveRequestSetButton(KQMLPerformative *perf, char **contents)
{
    DEBUG0("");
    if (STREQ(contents[0], "set-button")) {
	displaySetButton(1);
    } else if (STREQ(contents[0], "unset-button")) {
	displaySetButton(0);
    }
    DEBUG0("done");
}


