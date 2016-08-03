/*
 * main.c : Program entry point for Process Manager
 *
 * George Ferguson, ferguson@cs.rochester.edu,  7 Apr 1995
 * Time-stamp: <96/08/13 16:35:43 ferguson>
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "trlib/debugarg.h"
#include "trlib/hostname.h"
#include "util/error.h"
#include "util/debug.h"
#include "main.h"
#include "input.h"
#include "im.h"
#include "send.h"

/*
 * Functions defined here:
 */
int main(int argc, char **argv, char **envp);
static void parseArgs(int argc, char **argv);

/*
 * Data defined here:
 */
char *localhost;
char **main_envp;
/* Default this to stderr to have debugging on by default */
FILE *debugfp = NULL;
char *progname;

/*	-	-	-	-	-	-	-	-	*/

int
main(int argc, char **argv, char **envp)
{
    int sock;
    FILE *fp;

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
    /* Save envp for later use when forking processes */
    main_envp = envp;
    /* Find out hostname */
    localhost = trlibGetHostname();
    /* Use it to set the default address for contacting the IM */
    setIMAddr(localhost, IM_DEFAULT_PORT);
    /* Parse the command line */
    parseArgs(argc, argv);
    /* Initialize the process manager's connection to the IM */
    DEBUG0("initializing connection to IM");
    if ((sock = openIMSocket()) < 0) {
	ERROR0("couldn't connect to IM");
	exit(-1);
    }
    /* Make stdout be a FILE* to the socket (but don't change fd 0) */
    /* This is awful, but the alternative is a FILE* argument to all the
     * trlib routines, which are *only* used for a stream other than
     * stdout in the *this* module.
     */
    DEBUG1("changing stdout to socket=%d", sock);
    if ((fp = fdopen(sock, "w")) == NULL) {
	SYSERR0("couldn't fdopen IM socket");
	exit(-1);
    }
#ifdef SOLARIS
    memcpy((char*)stdout, (char*)fp, sizeof(FILE));
#else
    memcpy((char*)stdout, (char*)fp, sizeof(struct _iobuf));
#endif
    /* Send initial messages */
    DEBUG0("registering with IM");
    sendRegisterAndReadyMsgs();
    /* Go do that PM thing, possibly forever */
    DEBUG0("PM initialized");
    inputLoop(sock);
    /* Just in case */
    exit(-1);
}

/*	-	-	-	-	-	-	-	-	*/

static void
parseArgs(int argc, char **argv)
{
    char hostname[256], *s;
    int port;

    /* Use environment variables for defaults */
    if ((s = getenv("TRAINS_SOCKET")) != NULL) {
	if (sscanf(s, "%[^:]:%d", hostname, &port) != 2) {
	    ERROR1("bad $TRAINS_SOCKET (should be HOST:PORT): \"%s\"", s);
	} else if (setIMAddr(hostname, port) < 0) {
	    ERROR1("couldn't set address from $TRAINS_SOCKET \"%s\"", s);
	}
    }
    /* Parse options */
    while (--argc > 0) {
	argv += 1;
	if (strcmp(argv[0], "-socket") == 0) {
	    if (argc < 2) {
		ERROR0("missing argument for -socket");
	    } else {
		if (sscanf(argv[1], "%[^:]:%d", hostname, &port) != 2) {
		    ERROR1("bad -socket spec (should be HOST:PORT): \"%s\"",
			   argv[1]);
		} else if (setIMAddr(hostname, port) < 0) {
		    ERROR1("couldn't set address from -socket \"%s\"",argv[1]);
		}
		argc -= 1;
		argv += 1;
	    }
	} else if (strcmp(argv[0], "-debug") == 0) {
	    /* Handled by trlib */
	    argc -= 1;
	    argv += 1;
	} else {
	    ERROR1("unknown option: \"%s\"", argv[0]);
	}
    }
}
