/*
 * main.c: Program entry point for Audio Manager
 *
 * George Ferguson, ferguson@cs.rochester.edu,  2 Jan 1996
 * Time-stamp: <96/08/23 13:51:31 ferguson>
 */
#include <stdio.h>
#include <string.h>
#include "trlib/debugarg.h"
#include "util/error.h"
#include "util/debug.h"
#include "main.h"
#include "display.h"
#include "send.h"
#include "audio.h"

/*
 * Functions defined here:
 */
int main(int argc, char **argv);
void programExit(int status);
static void parseArgs(int argc, char **argv);

/*
 * Data defined here:
 */
static char *audio_server = NULL;
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
    /* Parse command line */
    parseArgs(argc, argv);
    /* Initialize display */
    displayInit(argc, argv);
    /* Initialize connection to the audio server */
    if (audioInit(audio_server) < 0) {
	exit(-1);
    }
    /* Tell the PM we're ready */
    sendReadyMsg();
    /* Off we go */
    displayEventLoop();
    /* NOTREACHED */
}

void
programExit(int status)
{
    DEBUG0("cleaning up...");
    audioClose();
    displayClose();
    DEBUG1("exiting with status=%d", status);
    exit(status);
}

/*	-	-	-	-	-	-	-	-	*/

static void
parseArgs(int argc, char **argv)
{
    while (--argc > 0) {
	argv += 1;
	if (strcmp(argv[0], "-audio") == 0) {
	    if (argc < 2) {
		ERROR0("missing name for -audio");
	    } else {
		audio_server = argv[1];
		argc -= 1;
		argv += 1;
	    }
	} else {
	    /* Ignore -- may be handled by X */
	}
    }
}
