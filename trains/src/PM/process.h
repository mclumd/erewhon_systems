/*
 * process.h: Process structure for TRAINS-95 PM/IM, v2.0
 *
 * George Ferguson, ferguson@cs.rochester.edu, 3 Nov 1995
 * Time-stamp: <Mon Nov 11 17:34:50 EST 1996 ferguson>
 *
 */

#ifndef _process_h_gf
#define _process_h_gf

#include "util/buffer.h"

typedef enum {
    PM_DEAD = 0, PM_CONNECTED, PM_STARTED, PM_READY,
    PM_EXITED, PM_KILLED, PM_RESTARTING
} ProcessState;

typedef struct _Process_s {
    char *name;				/* Name of module */
    char *classname;			/* Name of class (for IM) */
    char *host;				/* Host to run process on */
    char *executable;			/* Executable to run */
    char **argv;			/* Args for process */
    char **envp;			/* Environment: NAME=VALUE */
    int connect;			/* Whether to connect to IM or not */
    ProcessState state;			/* Process state */	
    int exit_status;			/* Exit status or killing signal */
    int pid;				/* Child process pid */
    struct _Process_s *next, *prev;	/* Linked list of running processes */
} Process;

extern Process *newProcess(char *name);
extern void deleteProcess(Process *p);
extern Process *findProcessByPID(int pid);
extern Process *findProcessByName(char *name);
extern Process *findOrCreateProcess(char *name);
extern char *processStatusString(Process *p);
extern void processSetenv(Process *p, char *var, char *val);
extern void processSetArgv(Process *p, char **argv);
extern void processSetEnvp(Process *p, char **envp);
extern void dumpProcesses(void);

extern Process *processList;

#endif
