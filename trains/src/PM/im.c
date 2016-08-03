/*
 * im.c: Routines used to connect the PM and the IM
 *
 * George Ferguson, ferguson@cs.rochester.edu, 11 Dec 1995
 * Time-stamp: <Tue Jan 14 15:06:17 EST 1997 ferguson>
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <netdb.h>
#include <sys/param.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include "util/error.h"
#include "util/debug.h"
#include "im.h"

#define MAX_BIND_TRIES	100

/*
 * Functions defined here:
 */
int setIMAddr(char *hostname, int port);
char *getIMAddr(void);
int openIMSocket(void);

/*
 * Data defined here:
 */
static char im_host[MAXHOSTNAMELEN];
static int im_port = IM_DEFAULT_PORT;
static u_long im_haddr = (u_long)INADDR_ANY;

/*	-	-	-	-	-	-	-	-	*/

int
setIMAddr(char *hostname, int port)
{
    struct hostent *hent;
    
    /* Lookup address */
    DEBUG2("hostname=%s, port=%d", hostname, port);
    DEBUG1("looking up \"%s\"", hostname);
    if ((hent = gethostbyname(hostname)) == NULL) {
	ERROR1("couldn't find address for host \"%s\"", hostname);
	return -1;
    }
    DEBUG1("gethostbyname said hostname=\"%s\"", hent->h_name);
    im_haddr = *((u_long*)(hent->h_addr_list[0]));
    DEBUG4("gethostbyname said addr=%d.%d.%d.%d",
	   (im_haddr & 0xff000000) >> 24, (im_haddr & 0x00ff0000) >> 16,
	   (im_haddr & 0x0000ff00) >> 8, (im_haddr & 0x000000ff));
    strcpy(im_host, hostname);
    im_port = port;
    /* Done */
    DEBUG0("done");
    return 0;
}

char *
getIMAddr(void)
{
    static char buf[sizeof(im_host)+8];

    sprintf(buf, "%s:%d", im_host, im_port);
    return buf;
}

/*
 * Note: We increment im_port directly in this while looping to try and
 * find the IM socket. This means that subsequent calls should find the IM
 * immediately. It means that the IM can't re-appear at a lower port
 * number, however (whatever exactly that would mean anyway).
 */
int
openIMSocket(void)
{
    int sockfd;
    int i;
    struct sockaddr_in saddr;

    if (im_port < 0) {
	DEBUG0("no IM address known; can't connect to IM");
	return -1;
    }
    DEBUG1("connecting to host \"%s\"", im_host);
    DEBUG4("host addr=%d.%d.%d.%d",
	   (im_haddr & 0xff000000) >> 24, (im_haddr & 0x00ff0000) >> 16,
	   (im_haddr & 0x0000ff00) >> 8, (im_haddr & 0x000000ff));
    for (i=0; i < MAX_BIND_TRIES; i++) {
	/* Create socket (has to be inside loop, apparently) */
	DEBUG0("creating socket");
	if ((sockfd = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
	    SYSERR0("couldn't create socket");
	    return -1;
	}
	/* Connect to remote host/port */
	memset((char*)&saddr, '\0', sizeof(saddr));
	saddr.sin_family = (short)AF_INET;
	saddr.sin_port = (u_short)im_port;
	memcpy((char*)&(saddr.sin_addr),
	       (char*)&im_haddr, sizeof(saddr.sin_addr));
	DEBUG1("connecting to port=%d...", im_port);
	if (connect(sockfd, (struct sockaddr *)&saddr, sizeof(saddr)) == 0) {
	    break;
	}
#ifdef undef
	SYSERR2("couldn't connect to %s:%d (will retry)", im_host, im_port);
#endif
	close(sockfd);
	im_port += 1;
    }
    if (i == MAX_BIND_TRIES) {
	ERROR3("couldn't connect to %s:%d-%d", im_host,
	       im_port-MAX_BIND_TRIES, im_port);
	return -1;
    }
    DEBUG1("connection established, fd=%d", sockfd);
    return sockfd;
}
