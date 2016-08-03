/*
 * trlib_error.c
 *
 * George Ferguson, ferguson@cs.rochester.edu,  7 Mar 1996
 * Time-stamp: <96/03/07 12:06:11 ferguson>
 */
#include <stdio.h>
#include <string.h>
#include "error.h"
#include "send.h"
#include "util/error.h"
#include "util/debug.h"

/*
 * Functions defined here:
 */
void trlibErrorReply(KQMLPerformative *perf, TrlibErrorCode code, char *comment);
static char *errorCodeToString(TrlibErrorCode code);

/*	-	-	-	-	-	-	-	-	*/

void
trlibErrorReply(KQMLPerformative *perf, TrlibErrorCode code, char *comment)
{
    KQMLPerformative *err;
    char num[8], text[256];

    DEBUG0("sending error reply");
    if ((err = KQMLNewPerformative("error")) == NULL) {
	ERROR0("couldn't send error reply!");
	return;
    }
    KQMLSetParameter(err, ":receiver", KQMLGetParameter(perf, ":sender"));
    KQMLSetParameter(err, ":in-reply-to",KQMLGetParameter(perf,":reply-with"));
    sprintf(num, "%d", code);
    KQMLSetParameter(err, ":code", num);
    sprintf(text, "\"%s: %s\"", errorCodeToString(code), comment);
    KQMLSetParameter(err, ":comment", text);
    trlibSendPerformative(stdout, err);
    KQMLFreePerformative(err);
    DEBUG0("done");
}

static char *
errorCodeToString(TrlibErrorCode code)
{
    char *s;

    switch (code) {
      case ERR_SYNTAX_ERROR: s = "syntax error"; break;
      case ERR_MISSING_PARAMETER: s = "missing parameter"; break;
      case ERR_MISSING_ARGUMENT: s = "missing argument"; break;
      case ERR_BAD_ARGUMENT: s = "bad argument"; break;
      case ERR_UNKNOWN_RECEIVER: s = "unknown receiver"; break;
      case ERR_BAD_PERFORMATIVE: s = "bad performative"; break;
      case ERR_BAD_CONTENT: s = "bad content"; break;
      case ERR_BAD_MODULE: s = "bad module"; break;
      case ERR_BAD_VALUE: s = "bad value"; break;
      default: s = "unknown error";
    }
    return s;
}
