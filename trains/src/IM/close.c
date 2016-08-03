/*
 * close.c: Close a client's i/o connections and clean up
 *
 * George Ferguson, ferguson@cs.rochester.edu, 13 Apr 1995
 * Time-stamp: <Tue Nov 12 18:53:17 EST 1996 ferguson>
 */
#include <stdio.h>
#include "util/error.h"
#include "util/debug.h"
#include "close.h"
#include "client.h"
#include "output.h"
#include "select.h"
#include "status.h"
#include "listen.h"
#include "monitor.h"

/*
 * Functions defined here:
 */
void closeClient(int fd);

/*	-	-	-	-	-	-	-	-	*/

void
closeClient(int fd)
{
    Client *c, *nextc;

    DEBUG1("fd=%d", fd);
    /* Sanity check */
    if (fd < 0) {
	ERROR0("bogus fd");
	return;
    }
    /* Find all clients using this fd (watch for deletion) */
    for (c=clientList; c != NULL; c=nextc) {
	nextc = c->next;
	if (c->fd == fd) {
	    /* Erase client's fd */
	    c->fd = -1;
	    /* Stop this client's listening to others */
	    clientUnlistenToAny(c);
	    clientUnmonitorAny(c);
	    /* If no one listening to us, might as well delete the client */
	    if (c->listeners == NULL && c->monitors == NULL) {
#ifndef NO_DISPLAY
		if (c->sendCount > 0 || c->recvCount > 0) {
		    DEBUG0("deferring deletion until display completes");
		    /* We'll be cleaning the client up shortly */
		    c->state = IM_EOF;
		} else {
		    deleteClient(c);
		}
#else
		deleteClient(c);
#endif
	    } else {
		/* Otherwise set status to EOF */
		clientSetStatus(c, IM_EOF);
	    }
	}
    }
    /* Zero the representative for this fd */
    clientSetFd(NULL, fd);
    /* Flush anything that was pending for this fd */
    outputFlush(fd);
    /* Close the fd itself */
    unregisterFd(fd, IM_ALL);
    DEBUG1("closing fd=%d", fd);
    close(fd);
    DEBUG0("done");
}
