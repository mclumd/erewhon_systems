/*
 * socket.c: Initialize IM by creating and registering initial socket
 *
 * George Ferguson, ferguson@cs.rochester.edu,  9 Nov 1995
 * Time-stamp: <96/07/31 15:30:37 ferguson>
 */
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include "socket.h"
#include "select.h"
#include "util/nonblockio.h"
#include "util/error.h"
#include "util/debug.h"

#define MAX_BIND_TRIES	100

/*
 * Functions defined here:
 */
int initialize(int port);
static int createIMSocket(int *portp);

/*	-	-	-	-	-	-	-	-	*/
/*
 * This creates the socket used to accept connections, and registers
 * it for select() on accept().
 * It returns the port number of the socket, or -1 on error.
 */
int
initSocket(int port)
{
    int sock;

    if ((sock = createIMSocket(&port)) < 0) {
	DEBUG0("couldn't create socket");
	return -1;
    }
    registerFd(sock, IM_ACCEPT);
    return port;
}

/*
 * This creates the socket on which the IM listens for new connections.
 * It returns the socket (and fills in the port number), or returns -1.
 */
static int
createIMSocket(int *portp)
{
    int sock;
    int reuse;
    struct sockaddr_in saddr;
    u_long inaddr_any = INADDR_ANY;
    int port;
    int i;

    /* Create socket */
    DEBUG0("creating socket");
    if ((sock = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
	SYSERR0("couldn't create socket");
	return -1;
    }
    DEBUG1("socket fd=%d", sock);
    /* Set socket options */
    reuse = 0;
    if (setsockopt(sock, SOL_SOCKET, SO_REUSEADDR,
		   (char*)&reuse, sizeof(int)) < 0) {
	SYSERR0("couldn't setsockopt SO_REUSADDR");
    }
    /* Bind to specified port, default (local) addr */
    port = *portp;
    for (i=0; i < MAX_BIND_TRIES; i++) {
	memset((char*)&saddr, '\0', sizeof(saddr));
	saddr.sin_family = (short)AF_INET;
	saddr.sin_port = (u_short)port;
	memcpy((char*)&(saddr.sin_addr),
	       (char*)&inaddr_any, sizeof(saddr.sin_addr));
	DEBUG1("binding socket, port=%d", port);
	if (bind(sock,(struct sockaddr *)&saddr,sizeof(saddr)) == 0) {
	    break;
	}
	SYSERR1("couldn't bind socket, port %d (will retry)", port);
	port += 1;
    }
    if (i == MAX_BIND_TRIES) {
	ERROR2("couldn't bind socket, ports %d-%d",
	       port-MAX_BIND_TRIES, port);
	return -1;
    }
    /* Listen for others to connect() */
    DEBUG0("listening on socket");
    if (listen(sock,5) < 0) {
	SYSERR0("couldn't listen on socket");
	return -1;
    }
    /* Setup socket */
    MAKE_NONBLOCKING(sock);
    /* Return port number and socket*/
    *portp = port;
    DEBUG2("done; sock=%d, port=%d", sock, port);
    return sock;
}    
