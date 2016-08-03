/*
 * accept.c: Completes TCP socket connections
 *
 * George Ferguson, ferguson@cs.rochester.edu,  8 Apr 1995
 * Time-stamp: <96/07/30 16:56:36 ferguson>
 */

#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include "accept.h"
#include "select.h"
#include "util/nonblockio.h"
#include "util/error.h"
#include "util/debug.h"

/*
 * Functions defined here:
 */
void acceptCallback(int fd);

/*	-	-	-	-	-	-	-	-	*/

void
acceptCallback(int fd)
{
    int sock;
    struct sockaddr saddr;
    int saddrlen = sizeof(struct sockaddr);

    DEBUG1("accepting connection on fd=%d", fd);
    /* Try to accept the connection */
    if ((sock = accept(fd, &saddr, &saddrlen)) < 0) {
	/* Error */
	SYSERR0("accept failed");
	return;
    }
    DEBUG1("new socket is fd %d", sock);
    /* Setup the new socket for use */
    MAKE_NONBLOCKING(sock);
    registerFd(sock, IM_READ);
    /* Done */
    DEBUG0("done");
}

