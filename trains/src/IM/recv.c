/*
 * recv.c: Messages sent to the IM itself
 *
 * George Ferguson, ferguson@cs.rochester.edu,  8 Apr 1995
 * Time-stamp: <Wed Nov 13 15:59:31 EST 1996 ferguson>
 */
#include <stdio.h>
#include "KQML/KQML.h"
#include "trlib/parse.h"
#include "util/error_codes.h"
#include "util/memory.h"
#include "util/streq.h"
#include "util/error.h"
#include "util/debug.h"
#include "recv.h"
#include "client.h"
#include "listen.h"
#include "monitor.h"
#include "reply.h"
#include "log.h"
#include "status.h"
#include "bcast.h"
#ifndef NO_DISPLAY
# include "display.h"
#endif


/*
 * Functions defined here:
 */
void receiveMsg(int fd, KQMLPerformative *perf);
static void receiveRequestListen(KQMLPerformative *perf, char **contents);
static void receiveRequestUnlisten(KQMLPerformative *perf, char **contents);
static void receiveRequestExit(KQMLPerformative *perf, char **contents);
static void receiveRequestDump(KQMLPerformative *perf, char **contents);
static void receiveRequestChdir(KQMLPerformative *perf,char **contents);
static void receiveRequestDefineClass(KQMLPerformative *perf,char **contents);
#ifndef NO_DISPLAY
static void receiveRequestHideWindow(KQMLPerformative *perf, char **contents);
static void receiveRequestShowWindow(KQMLPerformative *perf, char **contents);
#endif
static void receiveRegister(KQMLPerformative *perf, char **contents);
static void receiveTellReady(KQMLPerformative *perf,char **contents);
static void receiveEvaluateStatus(KQMLPerformative *perf, char **contents);
static void receiveMonitorStatus(KQMLPerformative *perf, char **contents);
static void receiveUnmonitorStatus(KQMLPerformative *perf, char **contents);
static void receiveBroadcast(KQMLPerformative *perf, char **contents);

/*
 * Data defined here:
 */
static TrlibParseDef defs[] = {
    { "request",	"listen",		receiveRequestListen },
    { "request",	"unlisten",		receiveRequestUnlisten },
    { "request",	"chdir",		receiveRequestChdir },
    { "request",	"dump",			receiveRequestDump },
    { "request",	"exit",			receiveRequestExit },
    { "request",	"define-class",		receiveRequestDefineClass },
#ifndef NO_DISPLAY
    { "request",	"hide-window",		receiveRequestHideWindow },
    { "request",	"show-window",		receiveRequestShowWindow },
#endif
    { "register",	NULL,			receiveRegister },
    { "tell",		"start-conversation",	NULL },
    { "tell",		"end-conversation",	NULL },
    { "tell",		"ready",		receiveTellReady },
    { "evaluate",	"status",		receiveEvaluateStatus },
    { "monitor",	"status",		receiveMonitorStatus },
    { "unmonitor",	"status",		receiveUnmonitorStatus },
    { "broadcast",	NULL,			receiveBroadcast },
    { NULL,		NULL,			NULL }
};
static int msgFd;

/*	-	-	-	-	-	-	-	-	*/

void
receiveMsg(int fd, KQMLPerformative *perf)
{
    DEBUG2("from fd=%d, verb=%s", fd, KQML_VERB(perf));
    /* Save fd for use by receive routines (eg., REGISTER) */
    msgFd = fd;
    /* Then dispatch the message */
    trlibParsePerformative(perf, defs);
    DEBUG0("done");
}

/*	-	-	-	-	-	-	-	-	*/

static void
receiveRequestListen(KQMLPerformative *perf, char **contents)
{
    char *name;
    Client *sender, *c;
    ClientClass *class;

    DEBUG0("");
    if ((name = KQMLGetParameter(perf, ":sender")) == NULL) {
	errorReply(perf, ERR_MISSING_PARAMETER, ":sender");
	return;
    }
    if ((sender = findOrCreateClient(name)) == NULL) {
	ERROR1("couldn't find or create sender %s", name);
	return;
    }
    DEBUG1("from %s", sender->name);
    if (contents[1] == NULL) {
	errorReply(perf, ERR_MISSING_ARGUMENT, contents[0]);
    } else if ((class=findClientClassByName(contents[1])) != NULL) {
	clientListenToClass(sender, class);
    } else if ((c = findOrCreateClient(contents[1])) != NULL) {
	clientListenToClient(sender, c);
    }
    DEBUG0("done");
}

static void
receiveRequestUnlisten(KQMLPerformative *perf, char **contents)
{
    char *name;
    Client *sender, *c;
    ClientClass *class;

    DEBUG0("");
    if ((name = KQMLGetParameter(perf, ":sender")) == NULL) {
	errorReply(perf, ERR_MISSING_PARAMETER, ":sender");
	return;
    }
    if ((sender = findOrCreateClient(name)) == NULL) {
	ERROR1("couldn't find or create sender %s", name);
	return;
    }
    DEBUG1("from %s", sender->name);
    if (contents[1] == NULL) {
	errorReply(perf, ERR_MISSING_ARGUMENT, contents[0]);
    } else if ((class=findClientClassByName(contents[1])) != NULL) {
	clientUnlistenToClass(sender, class);
    } else if ((c = findClientByName(contents[1])) != NULL) {
	clientUnlistenToClient(sender, c);
    }
    DEBUG0("done");
}

static void
receiveRequestExit(KQMLPerformative *perf, char **contents)
{
    int status = 0;

    DEBUG0("");
    if (contents[1] != NULL) {
	status = atoi(contents[1]);
    }
    exit(status);
}

static void
receiveRequestDump(KQMLPerformative *perf, char **contents)
{
    DEBUG0("");
    dumpClients(stderr);
    DEBUG0("done");
}

static void
receiveRequestChdir(KQMLPerformative *perf, char **contents)
{
    char *dir;

    DEBUG0("");
    if (contents[1] == NULL) {
	errorReply(perf, ERR_MISSING_ARGUMENT, contents[0]);
    } else {
	dir = KQMLParseThing(contents[1]);
	DEBUG1("dir=\"%s\"", dir);
	logChdir(dir);
	gfree(dir);
    }
    DEBUG0("done");
}

static void
receiveRequestDefineClass(KQMLPerformative *perf, char **contents)
{
    char *classname, *parentname = NULL;
    ClientClass *parent = NULL;

    DEBUG0("");
    if (contents[1] == NULL) {
	errorReply(perf, ERR_MISSING_ARGUMENT, contents[0]);
	return;
    }
    classname = contents[1];
    DEBUG1("classname=\"%s\"", classname);
    if (contents[2] != NULL) {
	if (STREQ(contents[2], ":parent")) {
	    if (contents[3] == NULL) {
		errorReply(perf, ERR_MISSING_PARAMETER, contents[2]);
		return;
	    } else {
		parentname = contents[3];
		DEBUG1("parent=\"%s\"", parentname);
		if ((parent = findClientClassByName(parentname)) == NULL) {
		    errorReply(perf, ERR_BAD_CLASS, parentname);
		    return;
		}
	    }
	} else {
	    errorReply(perf, ERR_BAD_ARGUMENT, contents[2]);
	    return;
	}
    }
    DEBUG0("creating new class");
    (void)newClientClass(classname, parent);
    DEBUG0("done");
}

#ifndef NO_DISPLAY
static void
receiveRequestHideWindow(KQMLPerformative *perf, char **contents)
{
    DEBUG0("");
    displayHideWindow();
    DEBUG0("done");
}

static void
receiveRequestShowWindow(KQMLPerformative *perf, char **contents)
{
    DEBUG0("");
    displayShowWindow();
    DEBUG0("done");
}
#endif

/*	-	-	-	-	-	-	-	-	*/

static void
receiveRegister(KQMLPerformative *perf, char **contents)
{
    char *name, *classname, **classnames = NULL, **s;
    Client *c;
    ClientClass *class = AnyClass;

    DEBUG1("from fd=%d", msgFd);
    /* Accept either :name or :sender to specify name */
    if ((name = KQMLGetParameter(perf, ":name")) == NULL &&
	(name = KQMLGetParameter(perf, ":sender")) == NULL) {
	errorReply(perf, ERR_MISSING_PARAMETER, ":name or :sender");
	return;
    }
    DEBUG1("name=%s", name);
    /* Check class(es), if specified before proceeding */
    if ((classname = KQMLGetParameter(perf, ":class")) != NULL) {
	DEBUG1("class=%s", classname);
	/* If we've got a list of classes, check them all */
	if (*classname == '(' &&
	    (classnames = KQMLParseList(classname)) != NULL) {
	    for (s=classnames; *s != NULL; s++) {
		if (findClientClassByName(*s) == NULL) {
		    errorReply(perf, ERR_BAD_CLASS, *s);
		    gfree((char*)classnames);
		    return;
		}
	    }
	} else if ((class=findClientClassByName(classname)) == NULL) {
	    /* Otherwise check just this one class (and save it) */
	    errorReply(perf, ERR_BAD_CLASS, classname);
	    return;
	}
    }
    DEBUG0("finding/creating client");
    /* Ok, Find existing client or create new one */
    if ((c=findClientByName(name)) != NULL) {
	/* Existing client needs to be reset */
	DEBUG1("resetting existing client %s", name);
	clientSetFd(c, -1);
	clientUnlistenToClass(c, AnyClass);
	clientUnmonitorClass(c, AnyClass);
	deleteClientFromClasses(c);
	/* Set fd for this client */
	clientSetFd(c, msgFd);
    } else if ((c=newClient(name, msgFd)) != NULL) {
	/* New client is ready to go */
	DEBUG1("created new client %s", name);
    } else {
	ERROR1("couldn't create client: %s", name);
	gfree((char*)classnames);
	return;
    }
    /* Set class(es) */
    if (classnames != NULL) {
	for (s=classnames; *s != NULL; s++) {
	    DEBUG1("adding client to class=%s", *s);
	    addClientToClass(c, findClientClassByName(*s));
	}
	gfree((char*)classnames);
    } else {
	DEBUG1("adding client to class=%s", class->name);
	addClientToClass(c, class);
    }
#ifndef NO_DISPLAY
    /* Update display (position may change if "child" client) */
    displayDoLayout();
#endif
    /* Mark client ready */
    clientSetStatus(c, IM_CONNECTED);
    DEBUG0("done");
}

/*	-	-	-	-	-	-	-	-	*/

static void
receiveTellReady(KQMLPerformative *perf, char **contents)
{
    char *sender;
    Client *c;

    DEBUG0("");
    if ((sender = KQMLGetParameter(perf, ":sender")) == NULL) {
	errorReply(perf, ERR_MISSING_PARAMETER, ":sender");
    } else if ((c = findClientByName(sender)) == NULL) {
	errorReply(perf, ERR_BAD_MODULE, sender);
    } else {
	clientSetStatus(c, IM_READY);
    }
    DEBUG0("done");
}

/*	-	-	-	-	-	-	-	-	*/

static void
receiveEvaluateStatus(KQMLPerformative *perf, char **contents)
{
    Client *c;
    ClientClass *class;

    DEBUG0("");
    if (contents[1] == NULL) {
	errorReply(perf, ERR_MISSING_ARGUMENT, contents[0]);
    } else if ((class = findClientClassByName(contents[1])) != NULL) {
	statusReplyClass(perf, class);
    } else if ((c = findClientByName(contents[1])) != NULL) {
	statusReplyClient(perf, c);
    } else {
	errorReply(perf, ERR_BAD_MODULE, contents[1]);
    }
    DEBUG0("done");
}

/*	-	-	-	-	-	-	-	-	*/

static void
receiveMonitorStatus(KQMLPerformative *perf, char **contents)
{
    Client *from, *to;
    ClientClass *class;
    char *sender, *reply_with;

    DEBUG0("");
    /* :sender specifies who is doing the monitoring */
    if ((sender = KQMLGetParameter(perf, ":sender")) == NULL) {
	errorReply(perf, ERR_MISSING_PARAMETER, ":sender");
	return;
    }
    if ((from = findOrCreateClient(sender)) == NULL) {
	ERROR1("couldn't find or create client %s", sender);
	return;
    }
    /* Check for module name */
    if (contents[1] == NULL) {
	errorReply(perf, ERR_MISSING_ARGUMENT, "monitor status");
	return;
    }
    /* Get :reply-with, if any */
    reply_with = KQMLGetParameter(perf, ":reply-with");
    if ((class=findClientClassByName(contents[1])) != NULL) {
	clientMonitorClass(from, class, reply_with);
	statusReplyClass(perf, class);
    } else if ((to = findOrCreateClient(contents[1])) != NULL) {
	clientMonitorClient(from, to, reply_with);
	statusReplyClient(perf, to);
    }
    DEBUG0("done");
}

/*	-	-	-	-	-	-	-	-	*/

static void
receiveUnmonitorStatus(KQMLPerformative *perf, char **contents)
{
    Client *from, *to;
    ClientClass *class;
    char *sender;

    DEBUG0("");
    /* :sender specifies who is doing the unmonitoring */
    if ((sender = KQMLGetParameter(perf, ":sender")) == NULL) {
	errorReply(perf, ERR_MISSING_PARAMETER, ":sender");
	return;
    }
    if ((from = findOrCreateClient(sender)) == NULL) {
	ERROR1("couldn't find or create client %s", sender);
	return;
    }
    /* Check for module name */
    if (contents[1] == NULL) {
	errorReply(perf, ERR_MISSING_ARGUMENT, "unmonitor status");
	errorReply(perf, ERR_MISSING_ARGUMENT, contents[0]);
    } else if ((class=findClientClassByName(contents[1])) != NULL) {
	clientUnmonitorClass(from, class);
    } else if ((to = findClientByName(contents[1])) != NULL) {
	clientUnmonitorClient(from, to);
    }
    DEBUG0("done");
}

/*	-	-	-	-	-	-	-	-	*/
/*
 * We currently have the IM try to understand any broadcasts, for example
 * to get CHDIR. This might have to be changed, or at least we might have
 * to disable error replies in those cases.
 */

static void
receiveBroadcast(KQMLPerformative *perf, char **contents)
{
    char *content, *sendername;
    KQMLPerformative *bperf;

    DEBUG0("");
    /* Sanity check */
    if ((content = KQMLGetParameter(perf, ":content")) == NULL) {
	errorReply(perf, ERR_MISSING_PARAMETER, ":content");
    }	
    /* Parse content of message */
    if ((bperf = KQMLParsePerformative(content)) == NULL) {
	errorReply(perf, ERR_SYNTAX_ERROR, "in contents");
	return;
    }
    /* Lookup sender of message (to not bcast to), if known */
    if ((sendername = KQMLGetParameter(perf, ":sender")) == NULL) {
	errorReply(perf, ERR_MISSING_PARAMETER, ":sender");
    } else {
	/* Set sender of perf to bcast if it wasn't set */
	if (KQMLGetParameter(bperf, ":sender") == NULL) {
	    KQMLSetParameter(bperf, ":sender", sendername);
	}
	/* Send the performative to everyone but the original sender */
	broadcastPerformative(findClientByName(sendername), bperf);
	/* And we may want this ourselves... */
	receiveMsg(msgFd, bperf);
    }
    /* Free nested performative */
    KQMLFreePerformative(bperf);
    /* Done */
    DEBUG0("done");
}
