/*
 * init.c
 *
 * George Ferguson, ferguson@cs.rochester.edu, 19 Jan 1996
 * Time-stamp: <96/10/22 15:06:41 ferguson>
 *
 * This is called from Sphinx and passed the value of the
 * "-ui_arg" argument. We take that and process it as a list of arguments.
 */
#include <stdio.h>
#include <string.h>
#include "util/memory.h"
#include "util/error.h"
#include "util/debug.h"
#include "init.h"
#include "send.h"
#include "wordbuf.h"

/*
 * Functions defined here:
 */
void initialize(char *str);
static int parseArgs(char *str);
static int parseArg(char *arg);

/*
 * Data defined here:
 */
/* Default this to stderr to have debugging on by default */
/* If this is NULL, main() will open "sphinx.log" for it */
FILE *debugfp = NULL;
/* This is set from argv[0] in Sphinx/src/v8/main.c */
char *progname;
/* Other options */
char *audio_server = NULL;
char *basename = "utt";

void
initialize(char *str)
{
    int argc;
    char **argv;

    DEBUG0("");
    /* Parse pseudo argc/argv */
    if (parseArgs(str) < 0) {
	exit(-1);
    }
    /* Tell the IM we're ready */
    sendReadyMsg();
    DEBUG0("done");
}

/*	-	-	-	-	-	-	-	-	*/

static int
parseArgs(char *str)
{
    char buf[256], *arg;
    char quoting;
    int n;

    DEBUG1("str=\"%s\"", str ? str : "<null>");
    /* If no string to parse, that's it */
    if (str == NULL) {
	DEBUG0("done (str is NULL)");
	return;
    }
    /* Otherwise scan the string... */
    while (*str) {
	DEBUG1("str=\"%s\"", str);
	/* Skip whitespace */
	while (*str == ' ' || *str == '\t') {
	    str += 1;
	}
	/* End of string -> done */
	if (!*str) {
	    break;
	}
	/* Check if we're starting a quoted argument or not */
	if (*str == '\'' || *str == '"') {
	    quoting = *str++;
	} else {
	    quoting = 0;
	}
	DEBUG1("str=\"%s\"", str);
	/* Now scan this argument, copying into buf[] */
	n = 0;
	arg = buf;
	while (*str && ((!quoting && *str != ' ' && *str != '\t') ||
			(quoting && *str != quoting))) {
	    /* Watch for backslash */
	    if (*str == '\\') {
		str += 1;
		if (!*str) {
		    *arg++ = '\\';
		} else {
		    *arg++ = *str++;
		}
	    } else {
		*arg++ = *str++;
	    }
	    n += 1;
	    if (n >= sizeof(buf)-1) {
		ERROR0("argument in ui_arg too long!");
		return -1;
	    }
	}
	/* Skip close quote of quoted argument */
	if (quoting) {
	    str += 1;
	}
	/* Terminate string */
	*arg = '\0';
	DEBUG2("buf=\"%s\", str=\"%s\"", buf, str);
	/* Process argument */
	if (parseArg(buf) < 0) {
	    return -1;
	}
    }
    return 0;
}

static int
parseArg(char *arg)
{
    /* This variable lets us handle "-flag value" pairs */
    /* I admit that this is disgusting. */
    static int last = 0;

    if (last == 0) {
	if (strcmp(arg, "-bufnum") == 0) {
	    last = 1;
	} else if (strcmp(arg, "-audio") == 0) {
	    last = 2;
	} else if (strcmp(arg, "-basename") == 0) {
	    last = 3;
	} else {
	    /* Ignore: May be for sphinx */
	}
    } else {
	/* Expecting argument from previous arg */
	if (last == 1) {
	    /* -bufnum */
	    wordbufSetBufferLen(atoi(arg));
	} else if (last == 2) {
	    /* -audio */
	    audio_server = gnewstr(arg);
	} else if (last == 3) {
	    /* -basename */
	    basename = gnewstr(arg);
	}
	last = 0;
    }
    return 0;
}
