/*
 * recv.c: Messages sent to the PM itself
 *
 * George Ferguson, ferguson@cs.rochester.edu,  8 Apr 1995
 * Time-stamp: <Mon Nov 11 17:59:08 EST 1996 ferguson>
 */
#include <stdio.h>
#include "KQML/KQML.h"
#include "trlib/parse.h"
#include "trlib/error.h"
#include "util/memory.h"
#include "util/streq.h"
#include "util/error.h"
#include "util/debug.h"
#include "recv.h"
#include "start.h"
#include "kill.h"
#include "input.h"

/*
 * Functions defined here:
 */
void receiveMsg(KQMLPerformative *perf);
static void receiveRequestStart(KQMLPerformative *perf, char **contents);
static void receiveRequestRestart(KQMLPerformative *perf, char **contents);
static void receiveRequestKill(KQMLPerformative *perf, char **contents);
static void receiveRequestDump(KQMLPerformative *perf, char **contents);
static void receiveRequestExit(KQMLPerformative *perf, char **contents);

/*
 * Data defined here:
 */
static TrlibParseDef defs[] = {
    { "request",	"start",		receiveRequestStart },
    { "request",	"restart",		receiveRequestRestart },
    { "request",	"kill",			receiveRequestKill },
    { "request",	"dump",			receiveRequestDump },
    { "request",	"exit",			receiveRequestExit },
    { "request",	"chdir",		NULL },
    { "request",	"hide-window",		NULL },
    { "request",	"show-window",		NULL },
    { "tell",		"start-conversation",	NULL },
    { "tell",		"end-conversation",	NULL },
    { NULL,		NULL,			NULL }
};

/*	-	-	-	-	-	-	-	-	*/

void
receiveMsg(KQMLPerformative *perf)
{
    DEBUG1("verb=%s", KQML_VERB(perf));
    trlibParsePerformative(perf, defs);
    DEBUG0("done");
}

static void
receiveRequestStart(KQMLPerformative *perf, char **contents)
{
    char *name = NULL, *classname = NULL, *host = NULL, *exec = NULL;
    char **argv = NULL, **envp = NULL;
    int connect = 1;
    Process *p;

    DEBUG0("");
    /* First word of contents was "start" */
    contents += 1;
    /* Parse remaining contents args */
    while (*contents) {
	/* Check for key/value pair */
	if (contents[1] == NULL) {
	    trlibErrorReply(perf, ERR_MISSING_ARGUMENT, contents[0]);
	    return;
	}
	/* Save value */
	if (STREQ(contents[0], ":name")) {
	    name = contents[1];
	} else if (STREQ(contents[0], ":class")) {
	    classname = contents[1];
	} else if (STREQ(contents[0], ":host")) {
	    host = contents[1];
	} else if (STREQ(contents[0], ":exec")) {
	    exec = KQMLParseThing(contents[1]);
	} else if (STREQ(contents[0], ":argv")) {
	    if ((argv = KQMLParseThingList(contents[1])) == NULL) {
		trlibErrorReply(perf, ERR_SYNTAX_ERROR, contents[1]);
		return;
	    }
	} else if (STREQ(contents[0], ":envp")) {
	    if ((envp = KQMLParseThingList(contents[1])) == NULL) {
		trlibErrorReply(perf, ERR_SYNTAX_ERROR, contents[1]);
		return;
	    }
	} else if (STREQ(contents[0], ":connect")) {
	    if (STREQ(contents[1], "nil")) {
		connect = 0;
	    } else {
		connect = 1;
	    }
	}
	/* Next key/value pair */
	contents += 2;
    }
    /* Check for required args */
    if (name == NULL) {
	trlibErrorReply(perf, ERR_MISSING_PARAMETER, ":name");
	return;
    }
    if (exec == NULL) {
	trlibErrorReply(perf, ERR_MISSING_PARAMETER, ":exec");
	return;
    }
    /* Check that there's isn't already a process with this name */
    if (findProcessByName(name) != NULL) {
	ERROR1("attempt to start existing process: %s", name);
	trlibErrorReply(perf, ERR_BAD_VALUE, name);
	return;
    }
    /* Create new process */
    if ((p = newProcess(name)) == NULL) {
	SYSERR0("couldn't create new process");
	return;
    }
    /* Set attributes */
    p->classname = gnewstr(classname);
    p->host = gnewstr(host);
    p->executable = gnewstr(exec);
    p->connect = connect;
    processSetArgv(p, argv);
    gfreeall(argv);
    processSetEnvp(p, envp);
    gfreeall(envp);
    /* Start the process */
    startProcess(p);
    /* Done */
    DEBUG0("done");
}

/*
 * Blatant copy of the code for START...
 */
static void
receiveRequestRestart(KQMLPerformative *perf, char **contents)

{
    char *name = NULL, *classname = NULL, *host = NULL, *exec = NULL;
    char **argv = NULL, **envp = NULL;
    int connect = 1, connectseen = 0;
    Process *p;

    DEBUG0("");
    /* First word of contents was "restart" */
    contents += 1;
    /* Next word is name of process */
    if ((name = contents[0]) == NULL) {
	trlibErrorReply(perf, ERR_MISSING_ARGUMENT, contents[0]);
	return;
    }
    contents += 1;
    /* Parse remaining contents args (not including :name and :class) */
    while (*contents) {
	/* Check for key/value pair */
	if (contents[1] == NULL) {
	    trlibErrorReply(perf, ERR_MISSING_ARGUMENT, contents[0]);
	    return;
	}
	/* Save value */
	if (STREQ(contents[0], ":host")) {
	    host = contents[1];
	} else if (STREQ(contents[0], ":exec")) {
	    exec = KQMLParseThing(contents[1]);
	} else if (STREQ(contents[0], ":argv")) {
	    if ((argv = KQMLParseThingList(contents[1])) == NULL) {
		trlibErrorReply(perf, ERR_SYNTAX_ERROR, contents[1]);
		return;
	    }
	} else if (STREQ(contents[0], ":envp")) {
	    if ((envp = KQMLParseThingList(contents[1])) == NULL) {
		trlibErrorReply(perf, ERR_SYNTAX_ERROR, contents[1]);
		return;
	    }
	} else if (STREQ(contents[0], ":connect")) {
	    connectseen = 1;
	    if (STREQ(contents[1], "nil")) {
		connect = 0;
	    } else {
		connect = 1;
	    }
	}
	/* Next key/value pair */
	contents += 2;
    }
    /* Check that there's already a process with this name */
    if ((p = findProcessByName(name)) == NULL) {
	ERROR1("attempt to restart non-existing process: %s", name);
	trlibErrorReply(perf, ERR_BAD_VALUE, name);
	return;
    }
    /* Set attributes (can't change class!) */
    if (host) {
	gfree(p->host);
	p->host = gnewstr(host);
    }
    if (exec) {
	gfree(p->executable);
	p->executable = gnewstr(exec);
    }
    if (connectseen) {
	p->connect = connect;
    }
    if (argv) {
	gfreeall(p->argv);
	processSetArgv(p, argv);
	gfreeall(argv);
    }
    if (envp) {
	gfreeall(p->envp);
	processSetEnvp(p, envp);
	gfreeall(envp);
    }
    /* Mark process for restart after kill */
    p->state = PM_RESTARTING;
    /* Kill the process */
    processKill(p);
    /* Done */
    DEBUG0("done");
}

static void
receiveRequestKill(KQMLPerformative *perf, char **contents)
{
    Process *p;

    DEBUG0("");
    if (contents[1] == NULL) {
	trlibErrorReply(perf, ERR_MISSING_ARGUMENT, contents[0]);
	return;
    }
    if ((p = findProcessByName(contents[1])) == NULL) {
	trlibErrorReply(perf, ERR_BAD_MODULE, contents[1]);
    } else {
	processKill(p);
    }
    DEBUG0("done");
}

static void
receiveRequestDump(KQMLPerformative *perf, char **contents)
{
    DEBUG0("");
    dumpProcesses();
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
    programExit(status);
}
