/*
 * main.c
 *
 * George Ferguson, ferguson@cs.rochester.edu,  5 Feb 1996
 * Time-stamp: <96/04/05 16:34:56 ferguson>
 */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "trlib/debugarg.h"
#include "util/error.h"
#include "main.h"
#include "display.h"
#include "send.h"
#include "logdir.h"

#ifndef TRAINS_BASE
/* This is almost certainly wrong, so be sure to override it */
#define TRAINS_BASE "."
#endif

/*
 * Functions defined here:
 */
int main(int argc, char **argv);
static void initOptions(int argc, char **argv);
void programExit(int status);

/*
 * Data defined here:
 */
char *trains_base;
/* Default this to stderr to have debugging on by default */
FILE *debugfp = NULL;
char *progname;

/*	-	-	-	-	-	-	-	-	*/

int
main(int argc, char **argv)
{
    /* Print our timestamp to stderr for id purposes */
    extern char *_timestamp;
    fprintf(stderr, "%s: %s\n", argv[0], _timestamp);
    if ((progname = strrchr(argv[0], '/')) == NULL) {
	progname = argv[0];
    } else {
	progname += 1;
    }
    /* Handle -debug if given */
    trlibDebugArg(argc, argv);
    /* Initialize other options/environment */
    initOptions(argc, argv);
    /* Setup display */
    displayInit(argc, argv);
    /* Tell IM we're ready */
    sendReadyMsg();
    /* Off we go... */
    displayEventLoop();
    /*NOTREACHED*/
}

static void
initOptions(int argc, char **argv)
{
    char *s, *logdir;

    if ((trains_base = getenv("TRAINS_BASE")) == NULL) {
	trains_base = TRAINS_BASE;
    }
    /* Use TRAINS_LOGS for logdir if given */
    if ((s = getenv("TRAINS_LOGS")) != NULL) {
	setLogDirectory(s);
    } else {
	/* Otherwise default logdir is TRAINS_BASE/logs */
	if ((logdir = malloc(strlen(trains_base)+6)) == NULL) {
	    SYSERR0("couldn't malloc to set initial logdir");
	    return;
	}
	sprintf(logdir, "%s/logs", trains_base);
	setLogDirectory(logdir);
	free(logdir);
    }
}

void
programExit(int ret)
{
    displayExit();
    exit(ret);
}
