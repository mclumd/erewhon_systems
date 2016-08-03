/*
 * main.c: Startup for TRAINS-95 display
 *
 * George Ferguson, ferguson@cs.rochester.edu, 21 Dec 1994
 * Time-stamp: <96/04/13 12:09:53 ferguson>
 */
#include <stdio.h>
#include <string.h>
#include "trlib/debugarg.h"
#include "main.h"
#include "display.h"
#include "object.h"
#include "send.h"

/*
 * Functions defined here:
 */
int main (int argc, char **argv, char **envp);
void programExit(int status);
void restart(void);

/*
 * Data defined here:
 */
/* Default this to stderr to have debugging on by default */
FILE *debugfp = NULL;
char *progname;

/*	-	-	-	-	-	-	-	-	*/

int
main(int argc, char **argv, char **envp)
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
    displayInit(&argc, argv);
    /* Read initial map */
    displayReadMapFile();
    /* Tell the IM we're ready */
    sendReadyMsg();
    /* Off we go */
    displayEventLoop();
    /*NOTREACHED*/
}

void
programExit(int status)
{
    displayClose();
    exit(status);
}

void
restart(void)
{
    destroyObjects();
    displayRestart();
}
