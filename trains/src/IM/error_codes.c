/*
 * error_codes.c
 *
 * George Ferguson, ferguson@cs.rochester.edu,  8 Nov 1995
 * Time-stamp: <96/08/02 13:15:17 ferguson>
 */
#include <stdio.h>
#include "util/error_codes.h"

/*
 * Functions defined here:
 */
char *errorCodeToString(int code);

/*	-	-	-	-	-	-	-	-	*/

char *
errorCodeToString(int code)
{
    char *s;

    switch (code) {
      case ERR_SYNTAX_ERROR: s = "syntax error"; break;
      case ERR_MISSING_PARAMETER: s = "missing parameter"; break;
      case ERR_MISSING_ARGUMENT: s = "missing argument"; break;
      case ERR_BAD_ARGUMENT: s = "bad argument"; break;
      case ERR_UNKNOWN_RECEIVER: s = "unknown receiver"; break;
      case ERR_BAD_PERFORMATIVE: s = "bad performative"; break;
      case ERR_BAD_TELL: s = "bad tell"; break;
      case ERR_BAD_REQUEST: s = "bad request"; break;
      case ERR_BAD_EVALUATE: s = "bad evaluate"; break;
      case ERR_BAD_MONITOR: s = "bad monitor"; break;
      case ERR_BAD_UNMONITOR: s = "bad unmonitor"; break;
      case ERR_BAD_MODULE: s = "bad module"; break;
      case ERR_BAD_VALUE: s = "bad value"; break;
      case ERR_BAD_CLASS: s = "bad class"; break;
      default: s = "unknown error";
    }
    return s;
}
