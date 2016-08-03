/*
 * main.c: Program entry point for Scenario selector
 *
 * George Ferguson, ferguson@cs.rochester.edu, 23 May 1996
 * Time-stamp: <96/05/23 17:16:12 ferguson>
 */
#include <stdio.h>
#include <string.h>
#include "trlib/debugarg.h"
#include "util/error.h"
#include "util/debug.h"
#include "main.h"
#include "display.h"
#include "send.h"

/*
 * Functions defined here:
 */
int main(int argc, char **argv);
void programExit(int status);

/*
 * Data defined here:
 */
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
    /* Initialize display */
    displayInit(argc, argv);
    /* Tell the PM we're ready */
    sendReadyMsg();
    /* Go process events, possibly forever */
    displayEventLoop();
    /* NOTREACHED */
}

void
programExit(int status)
{
    DEBUG1("exiting with status=%d", status);
    displayClose();
    exit(status);
}
