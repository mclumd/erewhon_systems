/*
 * main.c: Program entry point for Input Manager
 *
 * George Ferguson, ferguson@cs.rochester.edu, 9 Nov 1995
 * Time-stamp: <Thu Nov 14 17:42:05 EST 1996 ferguson>
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include "main.h"
#include "socket.h"
#include "select.h"
#include "log.h"
#ifndef NO_DISPLAY
# include "display.h"
#endif
#include "util/error.h"
#include "util/debug.h"

/*
 * Functions defined here:
 */
int main(int argc, char **argv);
static void parseArgs(int argc, char **argv);
static void handler(int sig);

/*
 * Data defined here:
 */
static int port = IM_DEFAULT_PORT;
static int doLog = 1;
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
    parseArgs(argc, argv);
    /* Initialize Input Manager */
    if (initSocket(port) < 0) {
	exit(-1);
    }
    if (doLog) {
	/* Open IM log */
	openLog();
    }
#ifndef NO_DISPLAY
    /* Setup the display */
    displayInit(argc, argv);
#endif
    /* Ignore SIGPIPE (we'll deal with EPIPE when we get it) */
    signal(SIGPIPE, SIG_IGN);
    /* Other signals: try to flush the debug log */
    signal(SIGINT, handler);
    signal(SIGQUIT, handler);
    signal(SIGTERM, handler);
    signal(SIGSEGV, handler);
    signal(SIGBUS, handler);
    /* Go do that IM thing, possibly forever */
    while (1) {
	DEBUG0("IM main loop -----------------------------------------------");
	if (doSelect() < 0) {
	    exit(-1);
	}
    }
    /* NOTREACHED */
}

/*	-	-	-	-	-	-	-	-	*/

static void
parseArgs(int argc, char **argv)
{
    char *s;

    /* Use environment variables for defaults */
    if ((s = getenv("TRAINS_SOCKET")) != NULL) {
	if (sscanf(s, "%*[^:]:%d", &port) != 1) {
	    ERROR1("bad $TRAINS_SOCKET (should be HOST:PORT): \"%s\"", s);
	    port = IM_DEFAULT_PORT;
	}
    }
    /* Parse options */
    while (--argc > 0) {
	argv += 1;
	if (strcmp(argv[0], "-port") == 0) {
	    if (argc < 2) {
		ERROR0("missing argument for -port");
	    } else {
		port = atoi(argv[1]);
		argc -= 1;
		argv += 1;
	    }
	} else if (strcmp(argv[0], "-debug") == 0) {
	    if (argc < 2) {
		ERROR0("missing filename for -debug");
	    } else {
		if (strcmp(argv[1], "-") == 0) {
		    debugfp = stderr;
		} else if (*argv[1] == '|') {
		    if ((debugfp = popen(argv[1]+1, "w")) == NULL) {
			SYSERR1("couldn't open debug pipe \"%s\"", argv[1]+1);
		    } else {
			setbuf(debugfp, NULL);
		    }
		} else if ((debugfp = fopen(argv[1], "w")) == NULL) {
		    SYSERR1("couldn't open debug file \"%s\"", argv[1]);
		}
		argc -= 1;
		argv += 1;
	    }
	} else if (strcmp(argv[0], "-nolog") == 0) {
	    doLog = 0;
	} else {
	    /* Ignore: may be handled by X */
	}
    }
}

/*	-	-	-	-	-	-	-	-	*/

static void
handler(int sig)
{
    ERROR1("caught signal %d", sig);
    if (debugfp) {
	fclose(debugfp);
    }
    exit(-1);
}
