/*
 * select.c: Main loop of the IM, doing select() and dispatch
 *
 * George Ferguson, ferguson@cs.rochester.edu,  7 Apr 1995
 * Time-stamp: <Wed Nov 13 15:40:01 EST 1996 ferguson>
 *
 * There is now support for setting a timeout for select(), which is
 * currently used by the display to ensure that it's timers get noticed.
 * If NO_DISPLAY is defined, using the timeout will cause an error.
 */

#include <stdio.h>
#include <sys/types.h>
#include <sys/time.h>
#include "select.h"
#include "input.h"
#include "output.h"
#include "accept.h"
#ifndef NO_DISPLAY
# include "display.h"
#endif
#include "util/error.h"
#include "util/debug.h"

#ifndef FD_SETSIZE
 FD_SETSIZE_MUST_BE DEFINED_SOMEHOW!
#endif

/*
 * Functions defined here:
 */
int doSelect(void);
void registerFd(int fd, int flags);
void unregisterFd(int fd, int flags);
void selectSetTimeout(int usec);

/*
 * Data defined here:
 */
static fd_set readfds, writefds;
static int maxfd = -1;
static IMOp fdFlags[FD_SETSIZE];
static int imSelectTimeout = -1;

/*	-	-	-	-	-	-	-	-	*/
/*
 * Calls select(2) using the current fd masks, and invokes callbacks as
 * appropriate.
 * Returns number of descriptors selected for (>0), or -1 on error.
 */
int
doSelect(void)
{
    fd_set rfds, wfds;
    int ret, i;
    struct timeval timeout;

    DEBUG0("starting...");
    if (maxfd == -1) {
	DEBUG0("no fds registered");
	return -1;
    }
    /* Copy fd sets since select changes them */
    memcpy((char*)&rfds, (char*)&readfds, sizeof(fd_set));
    memcpy((char*)&wfds, (char*)&writefds, sizeof(fd_set));
    /* Call select */
    if (imSelectTimeout >= 0) {
	timeout.tv_sec = 0;
	timeout.tv_usec = imSelectTimeout;
	DEBUG2("calling select, maxfd = %d, usec=%d", maxfd, imSelectTimeout);
	ret = select(maxfd+1, &rfds, &wfds, NULL, &timeout);
    } else {
	DEBUG1("calling select, maxfd = %d", maxfd);
	ret = select(maxfd+1, &rfds, &wfds, NULL, NULL);
    }
    if (ret < 0) {
	if (errno == EINTR) {
	    /* Interrupted system call, no problem */
	    return 0;
	} else {
	    /* Error */
	    SYSERR0("select failed");
	    return -1;
	}
    } else if (ret == 0) {
	/* Timeout */
#ifndef NO_DISPLAY
	DEBUG0("timeout: processing X events");
	displayProcessEvents();
	return 0;
#else
	DEBUG0("select returned 0???");
	return -1;
#endif
    }
    /* If we get here, some descriptors are ready */
    DEBUG1("select returned %d", ret);
    for (i=0; i <= maxfd; i++) {
	if (FD_ISSET(i, &rfds)) {
#ifndef NO_DISPLAY
	    if (fdFlags[i] == IM_DISPLAY) {
		DEBUG1("fd %d (X display) ready for read", i);
		displayProcessEvents();
	    } else
#endif
		if (fdFlags[i] == IM_ACCEPT) {
		DEBUG1("fd %d ready for accept", i);
		acceptCallback(i);
	    } else {
		DEBUG1("fd %d ready for read", i);
		inputCallback(i);
	    }
	}
    }
    for (i=0; i <= maxfd; i++) {
	if (FD_ISSET(i, &wfds)) {
	    DEBUG1("fd %d ready for write", i);
	    outputCallback(i);
	}
    }
    DEBUG0("done");
    return ret;
}

/*	-	-	-	-	-	-	-	-	*/

void
registerFd(int fd, int flags)
{
    DEBUG2("fd=%d, flags=%d", fd, flags);
    /* Sanity check */
    if (fd < 0 || fd >= FD_SETSIZE) {
	ERROR1("bogus fd: %d",fd);
	return;
    }
    /* Adjust select masks */
    if (flags & IM_READ || flags & IM_ACCEPT
#ifndef NO_DISPLAY
	|| flags & IM_DISPLAY
#endif
	) {
	FD_SET(fd, &readfds);
    }
    if (flags & IM_WRITE) {
	FD_SET(fd, &writefds);
    }
    /* Save flags for this fd */
    fdFlags[fd] |= flags;
    /* Update number of fd's being checked in select */
    if (fd > maxfd) {
	maxfd = fd;
    }
    DEBUG0("done");
}

void
unregisterFd(int fd, int flags)
{
    int i;

    DEBUG2("fd=%d, flags=%d", fd, flags);
    /* Sanity checks */
    if (fd < 0 || fd >= FD_SETSIZE) {
	return;
    }
    /* Adjust select masks */
    if (flags & IM_READ || flags & IM_ACCEPT
#ifndef NO_DISPLAY
	|| flags & IM_DISPLAY
#endif
	) {
	FD_CLR(fd, &readfds);
    }
    if (flags & IM_WRITE) {
	FD_CLR(fd, &writefds);
    }
    /* Clear flags for this fd */
    fdFlags[fd] &= ~flags;
    /* If this was the highest fd, we need to scan for the new highest */
    if (fd == maxfd && fdFlags[fd] == 0) {
	for (i=FD_SETSIZE-1; i >= 0; i--) {
	    if (fdFlags[i] != 0) {
		maxfd = i;
		DEBUG1("done, new maxfd=%d", maxfd);
		return;
	    }
	}
	/* This was the last registered fd, so there are none left */
	maxfd = -1;
	DEBUG0("done, no fds registered");
	return;
    }
    /* Otherwise we haven't changed the max fd */
    DEBUG0("done");
}

/*	-	-	-	-	-	-	-	-	*/

void
selectSetTimeout(int usec)
{
    imSelectTimeout = usec;
}
