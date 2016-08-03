/*
 * recv.c
 *
 * George Ferguson, ferguson@cs.rochester.edu,  5 Mar 1996
 * Time-stamp: <96/08/21 17:38:14 ferguson>
 */
#include <stdio.h>
#include "trlib/parse.h"
#include "trlib/error.h"
#include "util/memory.h"
#include "util/error.h"
#include "util/debug.h"
#include "recv.h"
#include "display.h"
#include "utt.h"
#include "log.h"
#include "main.h"

#ifndef SVR4
# define memmove(DST,SRC,LEN)	bcopy(SRC,DST,LEN)
#endif

/*
 * Functions defined here:
 */
void receiveMsg(KQMLPerformative *perf);
static void receiveTellStart(KQMLPerformative *perf, char **contents);
static void receiveTellInputEnd(KQMLPerformative *perf, char **contents);
static void receiveTellEnd(KQMLPerformative *perf, char **contents);
static void receiveTellMouse(KQMLPerformative *perf, char **contents);
static void receiveTellWord(KQMLPerformative *perf, char **contents);
static void receiveTellBackto(KQMLPerformative *perf, char **contents);
static void receiveTellStartConv(KQMLPerformative *perf, char **contents);
static void receiveTellEndConv(KQMLPerformative *perf, char **contents);
static void receiveRequestHideWindow(KQMLPerformative *perf, char **contents);
static void receiveRequestShowWindow(KQMLPerformative *perf, char **contents);
static void receiveRequestLog(KQMLPerformative *perf, char **contents);
static void receiveRequestChdir(KQMLPerformative *perf, char **contents);
static void receiveRequestExit(KQMLPerformative *perf, char **contents);

/*
 * Data defined here:
 */
static TrlibParseDef defs[] = {
    { "tell",		"start",		receiveTellStart },
    { "tell",		"input-end",		receiveTellInputEnd },
    { "tell",		"end",			receiveTellEnd },
    { "tell",		"mouse",		receiveTellMouse },
    { "tell",		"confirm",		receiveTellMouse },
    { "tell",		"word",			receiveTellWord },
    { "tell",		"backto",		receiveTellBackto },
    { "tell",		"start-conversation",	receiveTellStartConv },
    { "tell",		"end-conversation",	receiveTellEndConv },
    { "request",	"hide-window",		receiveRequestHideWindow },
    { "request",	"show-window",		receiveRequestShowWindow },
    { "request",	"log",			receiveRequestLog },
    { "request",	"chdir",		receiveRequestChdir },
    { "request",	"exit",			receiveRequestExit },
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
receiveTellStart(KQMLPerformative *perf, char **contents)
{
    char *sender;

    DEBUG0("");
    if ((sender = KQMLGetParameter(perf, ":sender")) == NULL) {
	trlibErrorReply(perf, ERR_MISSING_PARAMETER, ":sender");
	return;
    }
    if (contents[1] && STREQ(contents[1], ":uttnum") && contents[2]) {
	uttStart(sender, atoi(contents[2]));
    } else {
	uttStart(sender, 0);
    }
    DEBUG0("done");
}

static void
receiveTellInputEnd(KQMLPerformative *perf, char **contents)
{
    DEBUG0("");
    DEBUG0("ignoring input-end");
    DEBUG0("done");
}

static void
receiveTellEnd(KQMLPerformative *perf, char **contents)
{
    char *sender;

    DEBUG0("");
    if ((sender = KQMLGetParameter(perf, ":sender")) == NULL) {
	trlibErrorReply(perf, ERR_MISSING_PARAMETER, ":sender");
	return;
    }
    if (contents[1] && STREQ(contents[1], ":uttnum") && contents[2]) {
	uttEnd(sender, atoi(contents[2]));
    } else {
	uttEnd(sender, 0);
    }
    DEBUG0("done");
}

/* Also used for (confirm tag value) */
static void
receiveTellMouse(KQMLPerformative *perf, char **contents)
{
    DEBUG0("");
    displayAndLog("USR dsp ");
    while (*contents) {
	displayAndLog(*contents);
	displayAndLog(" ");
	contents += 1;
    }
    displayAndLog("\n");
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
    /* Convert word from KQML string to char* */
    /* Could use KQMLParseThing here, which would accept token or string */
    if ((word = KQMLParseString(w)) == NULL) {
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
    /* Check for required arguments (uttnum can be missing, eg from display) */
    if (start == -1) {
	trlibErrorReply(perf, ERR_MISSING_PARAMETER, ":index");
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
    /*
     * Decided to leave it hidden if hidden
    displayShowWindow();
     */
    DEBUG0("done");
}

static void
receiveTellEndConv(KQMLPerformative *perf, char **contents)
{
    DEBUG0("");
    /*
     * Decided to leave it shown if shown
    displayHideWindow();
     */
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
receiveRequestLog(KQMLPerformative *perf, char **contents)
{
    char *s;

    DEBUG0("");
    if (contents[1] != NULL) {
	if ((s = KQMLParseThing(contents[1])) == NULL) {
	    trlibErrorReply(perf, ERR_BAD_ARGUMENT, contents[1]);
	} else {
	    /* Hack since Brad won't do it */
	    if (strncmp(s, "SYS dsp say", 11) == 0) {
		memmove(s+4, s+8, strlen(s)-7);
	    }
	    displayAndLog(s);
	    displayAndLog("\n");
	    gfree(s);
	}
    }
    DEBUG0("done");
}

static void
receiveRequestChdir(KQMLPerformative *perf, char **contents)
{
    char *dir;

    DEBUG0("");
    if (contents[1] == NULL) {
	trlibErrorReply(perf, ERR_MISSING_ARGUMENT, contents[0]);
    } else {
	dir = KQMLParseThing(contents[1]);
	DEBUG1("dir=\"%s\"", dir);
	logChdir(dir);
	gfree(dir);
	displayReset();
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
    programExit(status);
}

