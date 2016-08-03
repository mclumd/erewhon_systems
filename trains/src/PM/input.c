/*
 * input.c : Process Manager main loop
 *
 * George Ferguson, ferguson@cs.rochester.edu, 24 Mar 1995
 * Time-stamp: <Mon Nov 11 17:39:41 EST 1996 ferguson>
 */
#include <stdio.h>
#include <string.h>
#include <signal.h>
#include <sys/wait.h>
#include "trlib/input.h"
#include "util/error.h"
#include "util/debug.h"
#include "input.h"
#include "process.h"
#include "recv.h"
#include "kill.h"

/*
 * Functions defined here:
 */
void inputLoop(int fd);
void programExit(int status);
static void initHandlers(void);
static void handleSIGCHLD(int sig);
static void reapSIGCHLD(void);

/*
 * Data defined here:
 */
static int numSIGCHLDs;

/*	-	-	-	-	-	-	-	-	*/

void
inputLoop(int fd)
{
    int ret;
#ifndef SOLARIS
    int mask;
#endif

    /* Setup signal handlers */
    initHandlers();
    /* Now loop forever processing messages */
    while (1) {
	DEBUG1("PM main loop (fd=%d) -----------------------------------", fd);
	/* Read KQML from stdin (connected to IM) */
	ret = trlibInput(fd, TRLIB_BLOCK, receiveMsg);
	/* Special case for `interrupted read' error */
	if (ret <= 0 && ret != KQML_ERROR_READ_INTERRUPTED) {
	    /* Otherwise error or EOF -> we exit */
	    DEBUG0("exiting");
	    programExit(ret);
	}
	/* If we got any SIGCHLD signals, handle them now */
	if (numSIGCHLDs > 0) {
	    DEBUG1("processing %d SIGCHLD signals", numSIGCHLDs);
	    /* Block SIGCHLD */
#ifdef SOLARIS
	    sighold(SIGCHLD);
#else
	    mask = sigblock(sigmask(SIGCHLD));
#endif
	    /* Reap the dead processes */
	    while (numSIGCHLDs > 0) {
		reapSIGCHLD();
		numSIGCHLDs -= 1;
	    }
	    /* Unblock SIGCHLD */
#ifdef SOLARIS
	    sigrelse(SIGCHLD);
#else
	    sigsetmask(mask);
#endif
	}
    }
}

void
programExit(int status)
{
    Process *p;

    DEBUG0("ignoring SIGCHLD from now on");
    signal(SIGCHLD, SIG_IGN);
    DEBUG0("killing all processes...");
    for (p=processList; p != NULL; p=p->next) {
	if (p->pid > 0 && p->state != PM_EXITED && p->state != PM_KILLED) {
	    processKill(p);
	}
    }
    DEBUG0("exiting");
    exit(status);
}

/*	-	-	-	-	-	-	-	-	*/
/* Previously, I used these simple incantations, although even they had
 * to account for the change to the semantics of signal() in Solaris.
#ifdef SOLARIS
    sigset(SIGCHLD, pmHandleSIGCHLD);
#else
    signal(SIGCHLD, pmHandleSIGCHLD);
#endif
 * Together with the block/release code in pmMainLoop() to process dead
 * children safely, this almost did the trick. The problem was that
 * pmMainLoop() needs to block in read() (during KQMLRead()), yet when
 * a child dies, we'd like to wake up and update our status (and, eg.,
 * the supervisor display) immediately. So I was forced to go to
 * sigaction(), which also has some nice differences on Solaris, not
 * to mention being completely unportable, I would bet. Oh well.
 * -> Now that PM status isn't even used in the supervisor display, this
 *    whole exercise ends up being pointless. Live and learn.
 */

static void
initHandlers(void)
{
    struct sigaction sa;

    DEBUG0("starting...");
    /* Here's how we want to handle the signal */
    sa.sa_handler = handleSIGCHLD;
    /* Clear the "additional signals to block" mask (portably) */
    memset((char*)&(sa.sa_mask), '\0', sizeof(sigset_t));
    /* Ensure that this signal will interrupt system calls like read() */
#ifdef SOLARIS
    /* Solaris says "clear SA_RESTART to have signal interrupt read()" */
    sa.sa_flags = 0;
#else
    /* BSD says "set SA_INTERRUPT to have signal interrupt read()" */
    sa.sa_flags = SA_INTERRUPT;
#endif
    /* Install the "handler" for SIGCHLD */
    sigaction(SIGCHLD, &sa, NULL);
    DEBUG0("done");
}

/*
 * The signal handler just sets a flag so we know to handle the signal
 * later when we get a chance. The work is done by processSIGCHLD, below.
 * These used to be one function. (Actually, we used to call wait() and
 * mark the relevant process in the handler. That was a mistake. We now
 * do all the processing a safe section of code.
 */
/*ARGSUSED*/
static void
handleSIGCHLD(int sig)
{
    numSIGCHLDs += 1;
    DEBUG1("SIGCHLD %d", numSIGCHLDs);
}

static void
reapSIGCHLD(void)
{
    int pid, status;
    Process *p;

    DEBUG0("calling wait");
    /* Find out which process died to cause SIGCHLD */
    if ((pid = wait(&status)) < 0) {
	SYSERR0("wait failed");
	return;
    }
    DEBUG2("pid=%d, status=0x%04x", pid, (status & 0xffff));
    if (!WIFSIGNALED(status) && !WIFEXITED(status)) {
	ERROR1("received SIGCHLD for unknown reason, process %d", pid);
    }
    if ((p = findProcessByPID(pid)) == NULL) {
	ERROR1("received SIGCHLD for unknown process %d", pid);
	return;
    }
    DEBUG1("dead process is %s", p->name);
    /* If we're waiting on a restart, do it now */
    if (p->state == PM_RESTARTING) {
	DEBUG0("restarting process");
	startProcess(p);
    } else {
	/* Mark process appropriately */
	if (WIFSIGNALED(status)) {
	    p->state = PM_KILLED;
	    p->exit_status = WTERMSIG(status);
	    DEBUG1("killed, signal=%d", p->exit_status);
	} else if (WIFEXITED(status)) {
	    p->state = PM_EXITED;
	    p->exit_status = WEXITSTATUS(status);
	    DEBUG1("exited, status=%d", p->exit_status);
	}
	/* Delete process (hmm, why bother with the above? oh well) */
	p->state = PM_DEAD;
	deleteProcess(p);
    }
    DEBUG0("done");
}
