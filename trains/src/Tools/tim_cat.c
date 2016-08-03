/*
 * tim_cat.c: Copy KQML messages from stdin to IM
 *
 * George Ferguson, ferguson@cs.rochester.edu, 23 Jan 1996
 * Time-stamp: <96/04/05 15:46:53 ferguson>
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <netdb.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include "KQML/KQML.h"
#include "util/debug.h"
#include "util/error.h"

#define MAX_CONNECT_TRIES 100

/*
 * Functions defined here:
 */
int main(int argc, char **argv);
static void initArgs(int argc, char **argv);
static int initSocket(char *hostname, int port);

/*
 * Data defined here:
 */
static char hostname[256] = "localhost";
static int port = 6200;
/* Default this to stderr to have debugging on by default (if -DDEBUG) */
FILE *debugfp = stderr;
char *progname;

/*	-	-	-	-	-	-	-	-	*/

int
main(int argc, char **argv)
{
    int sock, error;
    FILE *sockfp;
    KQMLPerformative *perf;
    KQMLParameter *parm;

    /* Print our timestamp to stderr for id purposes */
    extern char *_timestamp;
    fprintf(stderr, "%s: %s\n", argv[0], _timestamp);
    if ((progname = strrchr(argv[0], '/')) == NULL) {
	progname = argv[0];
    } else {
	progname += 1;
    }
    /* Parse command-line and environment */
    initArgs(argc, argv);
    /* Connect to IM */
    if ((sock = initSocket(hostname, port)) < 0) {
	exit(-1);
    }
    /* Create stdio stream for printing to IM */
    if ((sockfp = fdopen(sock, "w")) == NULL) {
	SYSERR0("fdopen failed");
	exit(-1);
    }
    /* Loop until EOF */
    while (1) {
	DEBUG0("calling KQMLRead...");
	/* Read a performative from stdin */
	perf = KQMLRead(0, &error, NULL);
	if (error < 0) {
	    /* Error */
	    ERROR2("KQML error %d (%s)", error, KQMLErrorString(error));
	} else if (error == 0) {
	    /* EOF */
	    exit(0);
	} else if (perf != NULL) {
	    /* Read done: print performative to IM */
	    DEBUG0("sending to IM");
	    fprintf(sockfp, "(%s", perf->verb);
	    for (parm=perf->parameters; parm != NULL; parm=parm->next) {
		if (parm->key && parm->value) {
		    fprintf(sockfp, " %s %s", parm->key, parm->value);
		}
	    }
	    fprintf(sockfp, ")\n");
	    fflush(sockfp);
	    /* Free performative */
	    KQMLFreePerformative(perf);
	}
    }
}

static void
initArgs(int argc, char **argv)
{
    char *s;

    /* Use environment variables for defaults */
    if ((s = getenv("TRAINS_SOCKET")) != NULL) {
	if (sscanf(s, "%[^:]:%d", hostname, &port) != 2) {
	    ERROR1("bad $TRAINS_SOCKET (should be HOST:PORT): \"%s\"", s);
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
		}
		argc -= 1;
		argv += 1;
	    }
	} else {
	    ERROR1("unknown option: \"%s\"", argv[0]);
	}
    }
}

/*	-	-	-	-	-	-	-	-	*/

static int
initSocket(char *hostname, int port)
{
    struct hostent *hent;
    u_long haddr;
    struct sockaddr_in saddr;
    int sockfd, i;

    DEBUG2("connecting to host \"%s\", port %d", hostname, port);
    /* Lookup address */
    if ((hent = gethostbyname(hostname)) == NULL) {
	SYSERR1("couldn't find address for host \"%s\"", hostname);
	return -1;
    }
    DEBUG1("gethostbyname said hostname=\"%s\"", hent->h_name);
    haddr = *((u_long*)(hent->h_addr_list[0]));
    DEBUG4("haddr=%d.%d.%d.%d",
	    (haddr & 0xff000000) >> 24, (haddr & 0x00ff0000) >> 16,
	    (haddr & 0x0000ff00) >> 8, (haddr & 0x000000ff));
    for (i=0; i < MAX_CONNECT_TRIES; i++) {
	/* Create socket */
	DEBUG0("creating socket");
	if ((sockfd = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
	    SYSERR0("couldn't create socket");
	    return -1;
	}
	/* Connect to remote host/port */
	DEBUG1("sockfd=%d", sockfd);
	memset((char*)&saddr, '\0', sizeof(saddr));
	saddr.sin_family = htons((short)AF_INET);
	saddr.sin_port = htons((u_short)port);
	memcpy((char*)&(saddr.sin_addr),(char*)&haddr,sizeof(saddr.sin_addr));
	DEBUG1("connecting: port=%d", port);
	if (connect(sockfd,(struct sockaddr *)&saddr,sizeof(saddr)) >= 0) {
	    DEBUG0("connected!");
	    return sockfd;
	}
	SYSERR2("couldn't connect to %s:%d (will retry)", hostname, port);
	close(sockfd);
	port += 1;
    }
    ERROR1("failed to connect to %s", hostname);
    return -1;
}