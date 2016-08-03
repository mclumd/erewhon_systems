/*
 * send.c : Handles sending message between two clients
 *
 * George Ferguson, ferguson@cs.rochester.edu,  8 Apr 1995
 * Time-stamp: <96/07/30 17:09:30 ferguson>
 */
#include <stdio.h>
#include "send.h"
#include "output.h"
#include "log.h"
#ifndef NO_DISPLAY
# include "display.h"
#endif
#include "util/buffer.h"
#include "util/error.h"
#include "util/debug.h"

/*
 * Functions defined here:
 */
void sendPerformative(Client *dst, KQMLPerformative *perf);
void sendPerformativeNoLog(Client *dst, KQMLPerformative *perf);
static void sendPerformative1(Client *dst, KQMLPerformative *perf, int dolog);
static void formatPerformativeToBuffer(KQMLPerformative *perf, Buffer *msgbuf);

/*	-	-	-	-	-	-	-	-	*/
/*
 * sendPerformative:
 *   Formats the message and calls output() to start sending it.
 */
void
sendPerformative(Client *dst, KQMLPerformative *perf)
{
#ifndef NO_DISPLAY
    displayMessageSend(dst, perf);
#endif
    sendPerformative1(dst, perf, 1);
}

void
sendPerformativeNoLog(Client *dst, KQMLPerformative *perf)
{
    sendPerformative1(dst, perf, 0);
}

static void
sendPerformative1(Client *dst, KQMLPerformative *perf, int dolog)
{
    static Buffer *msgbuf;

    DEBUG2("sending to %s, fd=%d", dst->name, dst->fd);
    /* Sanity check */
    if (dst->fd < 0) {
	DEBUG1("bad fd: %d", dst->fd);
	return;
    }
    /* Create and/or erase the msgbuf */
    if (msgbuf == NULL) {
	if ((msgbuf = bufferCreate()) == NULL) {
	    ERROR0("couldn't create msgbuf!");
	    return;
	}
    }
    bufferErase(msgbuf);
    /* Print performative into msgbuf */
    formatPerformativeToBuffer(perf, msgbuf);
    /* Log output of message if we need to */
    if (dolog) {
	logOutput(dst->fd, bufferData(msgbuf), bufferDatalen(msgbuf));
    }
    /* Actually send the message */
    output(dst->fd, bufferData(msgbuf), bufferDatalen(msgbuf));
    DEBUG0("done");
}

static void
formatPerformativeToBuffer(KQMLPerformative *perf, Buffer *msgbuf)
{
    KQMLParameter *p;

    bufferAddString(msgbuf, "(");
    bufferAddString(msgbuf, KQML_VERB(perf));
    for (p=perf->parameters; p != NULL; p=p->next) {
	if (p->key && p->value) {
	    bufferAddString(msgbuf, " ");
	    bufferAddString(msgbuf, p->key);
	    bufferAddString(msgbuf, " ");
	    bufferAddString(msgbuf, p->value);
	}
    }
    /* The newline is technically not needed, but will help programs
     * that need it to get input.
     */
    bufferAddString(msgbuf, ")\n");
}
