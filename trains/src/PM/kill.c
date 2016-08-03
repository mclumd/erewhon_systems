/*
 * kill.c
 *
 * George Ferguson, ferguson@cs.rochester.edu,  7 Nov 1995
 * Time-stamp: <96/03/11 13:38:11 ferguson>
 */
#include <stdio.h>
#include <signal.h>
#include "util/error.h"
#include "util/debug.h"
#include "kill.h"

/*
 * Functions defined here:
 */
void processKill(Process *p);

/*	-	-	-	-	-	-	-	-	*/

void
processKill(Process *p)
{
    DEBUG2("killing process 0x%lx (%s)", p, p->name);
    if (p->pid <= 0) {
	ERROR2("bad pid in process 0x%lx (%s)", p, p->name);
    } else {
	DEBUG1("killing pid %d", p->pid);
	if (kill(p->pid, SIGTERM) < 0) {
	    SYSERR1("couldn't kill process %d", p->pid);
	}
    }
    DEBUG0("done");
}
