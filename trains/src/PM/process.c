/*
 * process.c
 *
 * George Ferguson, ferguson@cs.rochester.edu,  3 Nov 1995
 * Time-stamp: <Tue Jan 14 18:31:32 EST 1997 ferguson>
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "util/streq.h"
#include "util/memory.h"
#include "util/error.h"
#include "util/debug.h"
#include "process.h"
#include "main.h"			/* localhost, main_envp */

/*
 * Functions defined here:
 */
Process *newProcess(char *name);
void deleteProcess(Process *p);
Process *findProcessByPID(int pid);
Process *findProcessByName(char *name);
Process *findOrCreateProcess(char *name);
void processSetenv(Process *p, char *var, char *val);
void processSetArgv(Process *p, char **argv);
void processSetEnvp(Process *p, char **envp);
char *processStatusString(Process *p);
void dumpProcesses(void);

/*
 * Data defined here:
 */
Process *processList;
static Process *lastProcess;

/*	-	-	-	-	-	-	-	-	*/

Process *
newProcess(char *name)
{
    Process *this;

    DEBUG1("name = \"%s\"", name);
    if ((this=(Process*)malloc(sizeof(Process))) == NULL) {
	return NULL;
    }
    if (processList == NULL) {
	/* First process in list */
	processList = lastProcess = this;
	this->next = this->prev = NULL;
    } else {
	/* Add to end of list */
	lastProcess->next = this;
	this->prev = lastProcess;
	this->next = NULL;
	lastProcess = this;
    }
    /* Set components of process */
    this->name = gnewstr(name);
    this->state = PM_DEAD;
    this->pid = -1;
    /* Return process */
    DEBUG0("done");
    return this;
}

void
deleteProcess(Process *this)
{    

    DEBUG1("name = \"%s\"", this->name);
    /* Delete from global list of processes */
    if (this == processList) {
	/* Deleting head of list */
	processList = processList->next;
	if (processList != NULL) {
	    processList->prev = NULL;
	}
    } else {
	/* Deleting in list */
	if (this->next != NULL) {
	    this->next->prev = this->prev;
	}
	if (this->prev != NULL) {
	    this->prev->next = this->next;
	}
    }
    /* Adjust end of list if needed */
    if (this == lastProcess) {
	lastProcess = this->prev;
    }
    /* Free components of process */
    gfree(this->name);
    gfree(this->classname);
     /* Free process itself */
    gfree(this);
    /* Done */
    DEBUG0("done");
}

/*	-	-	-	-	-	-	-	-	*/

Process *
findProcessByPID(int pid)
{
    Process *p;

    for (p=processList; p != NULL; p=p->next) {
	if (p->pid == pid) {
	    return p;
	}
    }
    return NULL;
}

Process *
findProcessByName(char *name)
{
    Process *p;

    for (p=processList; p != NULL; p=p->next) {
	if (STREQ(p->name, name)) {
	    return p;
	}
    }
    return NULL;
}

Process *
findOrCreateProcess(char *name)
{
    Process *p;

    if ((p = findProcessByName(name)) != NULL) {
        return p;
    }
    return newProcess(name);
}

/*	-	-	-	-	-	-	-	-	*/

void
processSetenv(Process *p, char *var, char *val)
{
    int i, num;
    char **new;

    DEBUG2("var=\"%s\", val=\"%s\"", var, val);
    /* Sanity check */
    if (p->envp == NULL) {
	ERROR0("attempt to setenv on NULL envp!");
	return;
    }
    /* Scan for this element of envp */
    for (num=0; p->envp[num] != NULL; num++) {
	if (strncmp(var, p->envp[num], strlen(var)) == 0 &&
	    *(p->envp[num] + strlen(var)) == '=') {
	    break;
	}
    }
    /* Not found, need to extend envp */
    if (p->envp[num] == NULL) {
	DEBUG0("allocating new envp");
	if ((new = (char**)calloc(num + 2, sizeof(char*))) == NULL) {
	    SYSERR0("couldn't calloc new process envp");
	    return;
	}
	for (i=0; i < num; i++) {
	    DEBUG2("copied envp[%d]: %s", i, p->envp[i]);
	    new[i] = p->envp[i];
	}
	new[num+1] = NULL;
	free(p->envp);
	p->envp = new;
    }
    /* Set new value */
    DEBUG1("setting envp[%d]", num);
    if (p->envp[num]) {
	free(p->envp[num]);
    }
    if ((p->envp[num] = malloc(strlen(var) + strlen(val) + 2)) == NULL) {
	SYSERR0("couldn't malloc new envp entry");
	return;
    }
    sprintf(p->envp[num], "%s=%s", var, val);
    DEBUG0("done");
}


void
processSetArgv(Process *p, char **argv)
{
    char *s;

    DEBUG1("name=%s", p->name);
    if (argv == NULL) {
	DEBUG0("using default argv");
	/* Allocate for argv */
	if ((p->argv = (char**)calloc(2, sizeof(char*))) == NULL) {
	    SYSERR0("couldn't calloc for argv");
	    return;
	}
#ifdef seems_to_be_hosed_under_solaris
	/* argv[0] is basename of executable */
	if ((s=strrchr(p->executable, '/')) != NULL) {
	    p->argv[0] = gnewstr(s+1);
	} else {
	    p->argv[0] = gnewstr(p->executable);
	}
#else /* ok, we'll use the whole name here */
	    p->argv[0] = gnewstr(p->executable);
#endif
	/* Final element of argv is NULL */
	p->argv[1] = NULL;
    } else {
	DEBUG0("using given argv");
	p->argv = gcopyall(argv);
    }
    DEBUG0("done");
    return;
}

void
processSetEnvp(Process *p, char **envp)
{
    char **env;
    char *s, *eq;
    int n, len;

    DEBUG1("name=%s", p->name);
    /* First we copy the entire current environment */
    DEBUG0("setting default envp");
    p->envp = gcopyall(main_envp);
#ifdef undef
    /* Temporarily use only part of the environment while we figure out
     * what to do about rsh for remote processes.
     */
    /* Allocate for envp (4 elements + NULL) */
    if ((p->envp = (char**)calloc(5, sizeof(char*))) == NULL) {
	SYSERR0("couldn't calloc for envp");
	return;
    }
    n = 0;
    /* envp[0] is PATH */
    len = strlen("PATH") + strlen("/bin:/usr/bin") + 2;
    if ((p->envp[n] = malloc(len)) == NULL) {
	SYSERR0("couldn't malloc for PATH");
	return;
    }
    strcpy(p->envp[n++], "PATH=/bin:/usr/bin");
    /* envp[1] is DISPLAY */
    if ((s = getenv("DISPLAY")) == NULL) {
	s = "unix:0";
    }
    len = strlen("DISPLAY") + strlen(s) + 2;
    if ((p->envp[n] = malloc(len)) == NULL) {
	SYSERR0("couldn't malloc for DISPLAY");
	return;
    }
    sprintf(p->envp[n++], "DISPLAY=%s", s);
    /* envp[2] is TRAINS_BASE */
    if ((s = getenv("TRAINS_BASE")) != NULL) {
	len = strlen("TRAINS_BASE") + strlen(s) + 2;
	if ((p->envp[n] = malloc(len)) == NULL) {
	    SYSERR0("couldn't malloc for TRAINS_BASE");
	    return;
	}
	sprintf(p->envp[n++], "TRAINS_BASE=%s", s);
    }
    /* envp[3] is TRAINS_LOGS */
    if ((s = getenv("TRAINS_LOGS")) != NULL) {
	len = strlen("TRAINS_LOGS") + strlen(s) + 2;
	if ((p->envp[n] = malloc(len)) == NULL) {
	    SYSERR0("couldn't malloc for TRAINS_LOGS");
	    return;
	}
	sprintf(p->envp[n++], "TRAINS_LOGS=%s", s);
    }
    /* Final element of envp is NULL */
    p->envp[n] = NULL;
#endif
    /* Then we add or replace anything explicitly specified */
    if (envp != NULL) {
	DEBUG0("setting additional envp");
	/* For each envvar specified here... */
	for (env=envp; *env != NULL; env++) {
	    /* Break it into VAR=VALUE */
	    if ((eq = strchr(*env, '=')) != NULL) {
		/* Yup, go set it in the process' environment */
		*eq = '\0';
		processSetenv(p, *env, eq+1);
		*eq = '=';
	    } else {
		/* Hmm, no equal sign, let's do this by default */
		processSetenv(p, *env, "");
	    }
	}
    }
    DEBUG0("done");
    return;
}

/*	-	-	-	-	-	-	-	-	*/

char *
processStatusString(Process *p)
{
    char *s;

    switch (p->state) {
      case PM_DEAD: s = "dead"; break;
      case PM_CONNECTED: s = "connected"; break;
      case PM_STARTED: s = "started"; break;
      case PM_READY: s = "ready"; break;
      case PM_EXITED: s = "exited"; break;
      case PM_KILLED: s = "killed"; break;
      default: s = "!unknown!";
    }
    return s;
}

void
dumpProcesses(void)
{
    Process *p, *q;
    char st;
    int n, k;

    fprintf(stderr, "#  Name              St  Pid       Host\n");
    for (n=0,p=processList; p != NULL; n++,p=p->next) {
	/* Print information from process struct */
	st = *(processStatusString(p));
	if (islower(st)) {
	    st = toupper(st);
	}
	fprintf(stderr, "%2d %-16s  %c %5d %-10.10s", n, p->name, st, p->pid,
	       p->host ? p->host : localhost);
	fprintf(stderr, "\n");
    }
}

