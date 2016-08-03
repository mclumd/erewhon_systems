/*
 * main.c
 *
 * George Ferguson, ferguson@cs.rochester.edu,  5 Mar 1996
 * Time-stamp: <96/10/22 16:13:12 ferguson>
 */
#include <stdio.h>
#include "util/error.h"
#include "util/debug.h"
#include "main.h"
#include "display.h"
#include "send.h"
#include "log.h"

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
    /* Parse the command line */
    trlibDebugArg(argc, argv);
    /* Initialize the display */
    displayInit(&argc, argv);
    /* Open the transcript file */
    if (writeTranscript) {
	logOpen();
    }
    /* Tell the IM we're ready */
    sendReadyMsg();
    /* Enter the X dispatch loop, probably forever */
    displayEventLoop();
    /* Just in case */
    exit(-1);
}

void
programExit(int status)
{
    displayClose();
    exit(status);
}
