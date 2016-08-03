/*
 * input.c : Read input from clients and forward messages, v2.0
 *
 * George Ferguson, ferguson@cs.rochester.edu,  7 Apr 1995
 * Time-stamp: <96/08/01 15:03:38 ferguson>
 */

#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <ctype.h>
#include "KQML/KQML.h"
#include "input.h"
#include "recv.h"
#include "send.h"
#include "bcast.h"
#include "log.h"
#include "close.h"
#include "reply.h"
#ifndef NO_DISPLAY
# include "display.h"
#endif
#include "util/error_codes.h"
#include "util/streq.h"
#include "util/memory.h"
#include "util/error.h"
#include "util/debug.h"

/*
 * Functions defined here:
 */
void inputCallback(int fd);

/*	-	-	-	-	-	-	-	-	*/

void
inputCallback(int fd)
{
    KQMLPerformative *perf;
    int error;
    char *txt, *senderName, *receiverName;
    Client *sender, *receiver;
    
    /* Sanity checks */
    DEBUG1("reading from fd=%d", fd);
    perf = KQMLReadNoHang(fd, &error, &txt);
    if (error < 0) {
	/* Error */
	if (txt != NULL) {
	    ERROR3("KQML error %d (%s): \"%s\"",
		   error, KQMLErrorString(error), txt);
	    logGarbage(fd, txt, KQMLErrorString(error));
	} else {
	    ERROR2("KQML error %d (%s)", error, KQMLErrorString(error));
	}
    } else if (error == 0) {
	/* EOF */
	DEBUG0("EOF!");
	closeClient(fd);
    } else if (perf != NULL) {
	/* Read complete */
	DEBUG1("processing msg from fd=%d", fd);
	/* Log the receipt of the message */
	logInput(fd, txt);
	/* Lookup clients involved in message (for processing and display) */
	if ((senderName=KQMLGetParameter(perf, ":sender")) != NULL) {
	    sender = findClientByName(senderName);
	} else if ((sender = findClientByFd(fd)) != NULL) {
	    /* Add :sender if not given (allows forgeries) */
	    KQMLSetParameter(perf, ":sender", sender->name);
	} else {
	    sender = NULL;
	}
#ifndef NO_DISPLAY
	displayMessageRecv(sender, perf);
#endif
	receiverName = KQMLGetParameter(perf, ":receiver");
	/* Dispatch based on destination module */
	if (receiverName == NULL) {
	    /* No receiver: broadcast */
	    if (sender == NULL) {
		ERROR1("can't determine sender; can't broadcast: %s", txt);
	    } else {
		broadcastPerformativeToListeners(sender, perf);
	    }
	} else if (STREQ(receiverName, "IM")) {
	    /* Message for IM itself */
	    receiveMsg(fd, perf);
	} else if ((receiver = findClientByName(receiverName)) != NULL) {
	    /* Message for other client: pass it on */
	    sendPerformative(receiver, perf);
	} else {
	    /* Otherwise error */
	    errorReply(perf, ERR_UNKNOWN_RECEIVER, receiverName);
	}
	/* Free performative */
	KQMLFreePerformative(perf);
    }
    /* Free the string containing the message */
    gfree(txt);
    DEBUG0("done");
}
