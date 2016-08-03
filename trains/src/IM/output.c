/*
 * output.c : Output to clients
 *
 * George Ferguson, ferguson@cs.rochester.edu,  7 Apr 1995
 * Time-stamp: <96/09/11 19:35:18 ferguson>
 */
#include <stdio.h>
#include <errno.h>
#include <sys/types.h>			/* FD_SETSIZE */
#include "output.h"
#include "select.h"
#include "util/nonblockio.h"
#include "util/buffer.h"
#include "util/error.h"
#include "util/debug.h"

#ifndef FD_SETSIZE
 FD_SETSIZE_MUST_BE DEFINED_SOMEHOW!
#endif

/*
 * Functions defined here:
 */
void output(int fd, char *msg, int msglen);
void outputCallback(int fd);
void outputFlush(int fd);

/*
 * Functions defined here:
 */
static Buffer *outbuf[FD_SETSIZE];

/*	-	-	-	-	-	-	-	-	*/
/*
 * imOutput: Tries to send a msg to the client. If it can't all
 *	be sent, the rest is buffered and the client marked for async
 *	output.
 */

void
output(int fd, char *msg, int msglen)
{
    int numsent;

    DEBUG1("sending to fd=%d", fd);
    /* Sanity check */
    if (fd < 0 || fd >= FD_SETSIZE) {
        DEBUG0("invalid fd");
	return;
    }
    /* If output buffer empty for client, try to write */
    if (outbuf[fd] == NULL || bufferEmpty(outbuf[fd])) {
	DEBUG4("trying to write %d bytes, fd=%d, msg=\"%.*s\"",
	       msglen, fd, msglen, msg);
	numsent = write(fd, msg, msglen);
	if (numsent < 0) {
	    /* Error */
	    if (!ISWOULDBLOCK(errno)) {
		SYSERR0("write failed");
		return;
	    } else {
		SYSERR0("write would block");
		numsent = 0;
	    }
	} else if (numsent == msglen) {
	    /* All done */
	    DEBUG0("msg sent completely");
	    return;
	}
	/* Something left to write */
	DEBUG1("wrote %d bytes", numsent);
	msg += numsent;
	msglen -= numsent;
    }
    /* Otherwise (something pending or didn't write it all) add msg (or
     * what's left of it to output buffer */
    if (outbuf[fd] == NULL) {
	if ((outbuf[fd] = bufferCreate()) == NULL) {
	    ERROR0("couldn't create outbuf");
	    return;
	}
    }
    DEBUG2("adding %d bytes to outbuf[%d]", msglen, fd);
    bufferAdd(outbuf[fd], msg, msglen);
    /* And register that we want to write this fd */
    registerFd(fd, IM_WRITE);
    DEBUG0("done");
}

/*
 * outputCallback: Called when the outfd selects for write to
 *	try to send pending output.
 */
void
outputCallback(int fd)
{
    char *msg;
    int msglen, numsent;

    DEBUG1("sending to fd=%d", fd);
    /* Sanity check */
    if (fd < 0 || fd >= FD_SETSIZE) {
	DEBUG0("invalid fd");
	return;
    }
    /* If output buffer empty for client, forget it (shouldn't happen) */
    if (bufferEmpty(outbuf[fd])) {
	/* Well, at least try not to get called back again */
	unregisterFd(fd, IM_WRITE);
	return;
    }
    /* Get the data we need to send */
    msg = bufferData(outbuf[fd]);
    msglen = bufferDatalen(outbuf[fd]);
    /* Try to write it all */
    DEBUG4("trying to write %d bytes, fd=%d, msg=\"%.*s\")",
	   msglen, fd, msglen, msg);
    numsent = write(fd, msg, msglen);
    if (numsent < 0) {
	/* Error */
	if (!ISWOULDBLOCK(errno)) {
	    SYSERR0("write failed");
	    return;
	} else {
	    SYSERR0("write would block");
	    numsent = 0;
	}
    } else if (numsent == msglen) {
	/* All done */
	DEBUG0("buffer sent completely");
	bufferErase(outbuf[fd]);
	/* Unregister write notification */
	unregisterFd(fd, IM_WRITE);
	
    }
    /* Otherwise, we didn't send it all, but pull what we did send out
     * of the buffer. */
    DEBUG1("wrote %d bytes", numsent);
    if (numsent > 0) {
	bufferDiscard(outbuf[fd], numsent);
    }
    /* That's it, we'll be called back again later */
    DEBUG0("done");
}

void
outputFlush(int fd)
{
    DEBUG1("fd=%d", fd);
    /* Sanity check */
    if (fd < 0 || fd >= FD_SETSIZE) {
	DEBUG0("invalid fd");
	return;
    }
    if (outbuf[fd] != NULL) {
	bufferErase(outbuf[fd]);
    }
    unregisterFd(fd, IM_WRITE);
    DEBUG0("done");
}
	
