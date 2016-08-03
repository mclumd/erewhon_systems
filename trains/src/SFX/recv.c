/*
 * recv.c
 *
 * George Ferguson, ferguson@cs.rochester.edu, 12 Jan 1996
 * Time-stamp: <96/09/04 15:03:38 ferguson>
 */
#include <stdio.h>
#include <string.h>
#include "trlib/parse.h"
#include "trlib/error.h"
#include "util/debug.h"
#include "recv.h"
#include "send.h"
#include "play.h"
#include "main.h"
#include "audio.h"

/*
 * Functions defined here:
 */
void receiveMsg(KQMLPerformative *perf);
static void receiveRequestPlay(KQMLPerformative *perf, char **contents);
static void receiveRequestExit(KQMLPerformative *perf, char **contents);

/*
 * Data defined here:
 */
static TrlibParseDef defs[] = {
    { "request",	"play",			receiveRequestPlay },
    { "request",	"exit",			receiveRequestExit },
    { "request",	"hide-window",		NULL },
    { "request",	"show-window",		NULL },
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

static void
receiveRequestPlay(KQMLPerformative *perf, char **contents)
{
    char *str;

    DEBUG0("");
    if (contents[1] == NULL) {
	trlibErrorReply(perf, ERR_MISSING_ARGUMENT, contents[0]);
	return;
    }
    /* Convert from KQML to normal string */
    if ((str = KQMLParseString(contents[1])) == NULL) {
	trlibErrorReply(perf, ERR_BAD_VALUE, contents[1]);
	return;
    }
    /* Go play the file */
    DEBUG1("playing file \"%s\"", str);
    playFile(str, perf);
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
