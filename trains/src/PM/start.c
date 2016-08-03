/*
 * start.c: Start processes
 *
 * George Ferguson, ferguson@cs.rochester.edu,  8 Apr 1995
 * Time-stamp: <96/09/24 12:58:42 ferguson>
 *
 * Note: We send the "register" message on behalf of children here,
 *       in runCommand() after forking the child process.
 *
 * Note: We run remote commands by writing a script that gets exec'd
 * remotely via rsh. This could be considered yucky, but is one way,
 * at least, of getting the environment setup properly. By using exec
 * both here (for rsh) and there (within the script), we also keep down
 * the number of processes involved in a remote launch.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/param.h>
#include <unistd.h>			/* getcwd() */
#include "start.h"
#include "im.h"
#include "main.h"			/* localhost */
#include "util/error.h"
#include "util/debug.h"

/*
 * Functions defined here:
 */
int startProcess(Process *p);
static int openConnection(Process *p);
static int runCommand(Process *p, int sock);
static int runCommandLocal(Process *p);
static int runCommandRemote(Process *p);
static void fprintfWithQuotes(FILE *fp, char *s);

/*	-	-	-	-	-	-	-	-	*/

int
startProcess(Process *p)
{
    int sock = -1;

    DEBUG1("starting process %s", p->name);
    /* Sanity check */
    if (p == NULL) {
	ERROR0("attempt to start NULL process");
	return -1;
    }
    /* Open socket connection */
    if (!p->connect) {
	DEBUG0("process marked non-connecting, setting TRAINS_SOCKET");
	processSetenv(p, "TRAINS_SOCKET", getIMAddr());
    } else if ((sock = openConnection(p)) < 0) {
	ERROR0("couldn't open connection");
	return -1;
    }
    /* Launch the program */
    if (runCommand(p, sock) < 0) {
	ERROR0("couldn't start process");
	return -1;
    }
    DEBUG0("done");
    return 0;
}

/*	-	-	-	-	-	-	-	-	*/

static int
openConnection(Process *p)
{
    int sock;
    FILE *fp;

    /* Create socket */
    DEBUG0("creating IM socket");
    if ((sock = openIMSocket()) < 0) {
	DEBUG0("couldn't connect to IM");
	return -1;
    }
    /* Save info for process */
    DEBUG1("new connection to IM, sock=%d", sock);
    p->state = PM_CONNECTED;
    /* Register with IM */
    DEBUG1("registering process %s with IM", p->name);
    if ((fp=fdopen(sock, "w")) == NULL) {
	SYSERR1("couldn't fdopen IM connection for %s", p->name);
    } else {
	if (p->classname != NULL) {
	    fprintf(fp, "(register :receiver IM :name %s :class %s)\n",
		    p->name, p->classname);
	} else {
	    fprintf(fp, "(register :receiver IM :name %s)\n", p->name);
	}
	fflush(fp);
    }
    /* Done */
    DEBUG0("done");
    return sock;
}

/*	-	-	-	-	-	-	-	-	*/
/*
 * Run the process, dup-ing stdin/stdout if connected
 */
static int
runCommand(Process *p, int sock)
{
    DEBUG2("starting process 0x%lx (%s)", p, p->name);
    /* Sanity check */
    if (p->executable == NULL) {
	DEBUG0("no executable for process; not started");
	return;
    }
    /* Fork for new process */
    DEBUG0("forking new process");
    if ((p->pid = fork()) < 0) {
	/* Error */
	SYSERR0("couldn't fork");
	return -1;
    } else if (p->pid == 0) {
	/* Child: set stdin/stdout to socket, if connected */
	if (sock >= 0) {
	    DEBUG2("%d: dup'ing socket %d onto stdin/stdout",
		   getpid(), sock);
	    /* Then make child's stdin/stdout the socket */
	    dup2(sock, 0);
	    dup2(sock, 1);
	    close(sock);
	}
	/* Now run the command, either locally or remotely */
	if (p->host == NULL || strcasecmp(p->host, localhost) == 0) {
	    runCommandLocal(p);
	} else {
	    runCommandRemote(p);
	}
	/* Note: only get here after error running command */
	DEBUG1("%d: couldn't run command", getpid());
	return -1;
    } else {
	DEBUG1("child pid is %d", p->pid);
	p->state = PM_STARTED;
	/* Close parent version of socket if needed */
	if (sock >= 0) {
	    close(sock);
	}
    }
    DEBUG0("done");
}
	
/*
 * Running a command locally is easy, since argv and envp are setup already
 */
static int
runCommandLocal(Process *p)
{
    int i;

    DEBUG3("%d: starting local process 0x%lx (%s)", getpid(), p, p->name);
    DEBUG2("%d: executable = \"%s\"", getpid(), p->executable);
    for (i=0; p->argv[i] != NULL; i++) {
	DEBUG3("%d: argv[%d] = \"%s\"", getpid(), i, p->argv[i]);
    }
    for (i=0; p->envp[i] != NULL; i++) {
	DEBUG3("%d: envp[%d] = \"%s\"", getpid(), i, p->envp[i]);
    }
    DEBUG2("%d: execing: \"%s\"", getpid(), p->executable);
    if (execve(p->executable, p->argv, p->envp) < 0) {
	SYSERR1("couldn't exec %s", p->executable);
	return -1;
    }
    /*NOTREACHED*/
}

#ifdef undef
/*
 * Running a command remotely is a bit more involved, since we have to
 * go via rsh, which requires that we set the remote environment, etc.
 */
#include "util/buffer.h"
static int
runCommandRemote(Process *p)
{
    static Buffer *cmdbuf = NULL;
    static char nul = '\0';
    char cwd[MAXPATHLEN];
    char *cmd;
    int i;

    DEBUG3("%d: starting remote process 0x%lx (%s)", getpid(), p, p->name);
    /* Create and/or erase buffer */
    if (cmdbuf == NULL) {
	if ((cmdbuf = bufferCreate()) == NULL) {
	    ERROR0("couldn't create cmdbuf!");
	    return -1;
	}
    }
    bufferErase(cmdbuf);
    /* First sh, with single quotes around command */
    bufferAddString(cmdbuf, "sh -c '");
    /* Now a cd to the current directory (since rsh takes us home) */
    if (getcwd(cwd, MAXPATHLEN-1) != NULL) {
	bufferAddString(cmdbuf, "cd ");
	bufferAddString(cmdbuf, cwd);
	bufferAddString(cmdbuf, "; ");
    }
    /* Set environment using VAR=VALUE form for sh */
    for (i=0; p->envp[i] != NULL; i++) {
	bufferAddString(cmdbuf, p->envp[i]);
	bufferAddString(cmdbuf, " ");
    }
    /* Now command to execute */
    bufferAddString(cmdbuf, p->executable);
    /* Then the arguments, skipping argv[0] which is name of program */
    for (i=1; p->argv[i] != NULL; i++) {
	bufferAddString(cmdbuf, " ");
	bufferAddString(cmdbuf, p->argv[i]);
    }
    /* Close quote on `sh -c' command */
    bufferAddString(cmdbuf, "'");
    /* Add NUL to cmd string */
    bufferAdd(cmdbuf, &nul, 1);
    /* Exec rsh */
    cmd = bufferData(cmdbuf);
    DEBUG3("%d: execing: rsh %s %s", getpid(), p->host, cmd);
    if (execl("/usr/ucb/rsh", "rsh", p->host, cmd, NULL) < 0) {
	/* Error */
	SYSERR0("couldn't exec /usr/ucb/rsh");
	return -1;
    }
    /* NOTREACHED */
}
#endif

/*
 * Running a command remotely is a bit more involved, since we have to
 * go via rsh, which requires that we set the remote environment, etc.
 * This version sets the environment by writing a file which is sourced
 * by the remote process.
 */
static int
runCommandRemote(Process *p)
{
    static char cwd[MAXPATHLEN];
    char filename[256], *var, *val;
    FILE *fp;
    int i;

    DEBUG3("%d: starting remote process 0x%lx (%s)", getpid(), p, p->name);
    /* Create the script we'll use to launch the process on the remote host */
    sprintf(filename, "pm.start.%s", p->name);
    if ((fp = fopen(filename, "w")) == NULL) {
	SYSERR1("couldn't write %s", filename);
	return -1;
    }
    /* Make it executable */
    if (chmod(filename, 0775) < 0) {
	SYSERR1("couldn't chmod %s", filename);
	return -1;
    }
    /* Useless first line, but what the heck */
    fprintf(fp, "#!/bin/sh\n\n");
    /* First, delete ourselves (that's right) so we don't stick around after */
    fprintf(fp, "# Delete this script now\n");
    fprintf(fp, "rm -f $0\n\n");
    /* First cd to the current directory, if possible */
    if (getcwd(cwd, MAXPATHLEN-1) != NULL) {
	fprintf(fp, "cd %s\n\n", cwd);
    } else {
	/* Otherwise use this for current dir later in exec */
	strcpy(cwd, ".");
    }
    /* Then set environment variables */
    for (i=0; p->envp[i] != NULL; i++) {
	var = p->envp[i];
	if ((val = strchr(p->envp[i], '=')) != NULL) {
	    *val = '\0';
	    fprintf(fp, "%s=", var);
	    fprintfWithQuotes(fp, val+1);
	    fprintf(fp, "; export %s\n", var);
	    *val = '=';
	} else {
	    ERROR1("bogus envp element: %s", p->envp[i]);
	}
	fprintf(fp, "\n");
    }
    /* Finally exec the program and arguments (skipping argv[0]) */
    fprintf(fp, "exec %s", p->executable);
    for (i=1; p->argv[i] != NULL; i++) {
	fprintf(fp, " ");
	fprintfWithQuotes(fp, p->argv[i]);
    }
    fprintf(fp, "\n");
    /* Done writing script */
    fclose(fp);
    /* Now, we exec rsh to run the script on the remote host */
    /* Pathname to script is "$CWD/scriptname" */
    strcat(cwd, "/");
    strcat(cwd, filename);
    DEBUG3("%d: execing: rsh %s %s", getpid(), p->host, cwd);
    if (execl("/usr/ucb/rsh", "rsh", p->host, cwd, NULL) < 0) {
	/* Error */
	SYSERR0("couldn't exec /usr/ucb/rsh");
	return -1;
    }
    /* NOTREACHED */
}

static void
fprintfWithQuotes(FILE *fp, char *s)
{
    /* If value doesn't use quote, can just print it directly */
    if (strchr(s, '\'') == NULL) {
	fprintf(fp, "'%s'", s);
    } else {
	/* Else need to escape quotes in value */
	putc('\'', fp);
	while (*s) {
	    if (*s == '\'') {
		putc('\\', fp);
	    }
	    putc(*s, fp);
	    s += 1;
	}
	putc('\'', fp);
    }
}

/*	-	-	-	-	-	-	-	-	*/
/*	-	-	-	-	-	-	-	-	*/
/*
 * Versions of runCommandRemote() saved for posterity...
 */
#ifdef undef
    /*
     * This one started using rexec, but the i/o connections were too much.
     */
    char ahost[256];
    struct servent *serv;
    u_short inport;
    char *user, *passwd;

    DEBUG3("%d: starting remote process 0x%lx (%s)", getpid(), p, p->name);
    /* Remote host (needs to be copied since rxec can modify it */
    strcpy(ahost, p->host);
    /* Find port number for exec service */
    if ((serv = getservbyname("exec", "tcp")) != NULL) {
	inport = (u_short)serv->s_port;
    } else {
	/* Not found, use default exec port */
	inport = 512;
    }
    /* Username and password */
    if ((s = getenv("USER")) != NULL) {
	user = s;
	if ((pw = getpwname(user)) != NULL) {
	    passwd = pw->passwd;
	} else {
	    ERROR1("can't find password for USER=%s", user);
	}
    } else if ((pw = getpwuid(getpid())) != NULL) {
	user = pw->pw_name;
	passwd = pw->pw_passwd;
    } else {
	ERROR0("can't determine username; try setting $USER");
	return -1;
    }
    /* Command is simply the shell */
    cmd = "/bin/sh";
    /* Now, try to run the command remotely */
    if ((fd = rexec(&ahost, inport, user, passwd, cmd, &fd2)) < 0) {
	SYSERR2("couldn't rexec %s on %s", cmd, ahost);
	return -1;
    }
    /* Convert the rexec socket into a stdio descriptor */
    if ((fp = fdopen(fd)) == NULL) {
	SYSERR0("couldn't fdopen socket");
	return -1;
    }
    /* Set the environment on the remote host */
    for (i=0; p->envp[i] != NULL; i++) {
	DEBUG3("%d: envp[%d]: %s", getpid(), i, p->envp[i]);
	var = p->envp[i];
	if ((val = strchr(p->envp[i], '=')) != NULL) {
	    *val = '\0';
	    fprintf(fp, "%s=", var);
	    fprintfWithQuotes(fp, val+1);
	    fprintf(fp, "; export %s\n", var);
	    fflush(fp);
	    *val = '=';
	}
    }
    /* Then cd to the current directory, if possible */
    if (getcwd(cwd, MAXPATHLEN-1) != NULL) {
	fprintf(fp, "cd %s\n", cwd);
	fflush(fp);
    }
    /* Then exec the program and arguments (skipping argv[0]) */
    DEBUG2("%d: exec'ing %s", getpid(), p->executable);
    fprintf(fp, "exec %s", p->executable);
    for (i=1; p->argv[i] != NULL; i++) {
	fprintfWithQuotes(fp, p->argv[i]);
    }
    fprintf(fp, "\n");
    fflush(fp);
    /* Ok, it's running, we can just sit here processing stderr until killed */
    ...
    DEBUG0("done");
    return 0;
#endif
#ifdef undef
    /*
     * This version used a popen, which was ok, but I never resolved how
     * to wait for it to exit, and it uses an extra process, and the killing
     * had yet to be worked out.
     */
    FILE *fp;
    char cmd[64], cwd[MAXPATHLEN];
    char *var, *val, *s;
    int i;

    DEBUG3("%d: starting remote process 0x%lx (%s)", getpid(), p, p->name);
    /* Open pipe to sh on the remote host */
    sprintf(cmd, "/usr/ucb/rsh %s /bin/sh", p->host);
    DEBUG2("%d: cmd=\"%s\"\n", getpid(), cmd);
    if ((fp = popen(cmd, "w")) == NULL) {
	/* Error */
	SYSERR1("couldn't popen \"%s\"", cmd);
	return -1;
    }
    /* Set the environment on the remote host */
    for (i=0; p->envp[i] != NULL; i++) {
	DEBUG3("%d: envp[%d]: %s", getpid(), i, p->envp[i]);
	var = p->envp[i];
	if ((val = strchr(p->envp[i], '=')) != NULL) {
	    *val = '\0';
	    fprintf(fp, "%s=", var);
	    fprintfWithQuotes(fp, val+1);
	    fprintf(fp, "; export %s\n", var);
	    fflush(fp);
	    *val = '=';
	}
    }
    /* Then cd to the current directory, if possible */
    if (getcwd(cwd, MAXPATHLEN-1) != NULL) {
	fprintf(fp, "cd %s\n", cwd);
	fflush(fp);
    }
    /* Then exec the program and arguments (skipping argv[0]) */
    DEBUG2("%d: exec'ing %s", getpid(), p->executable);
    fprintf(fp, "exec %s", p->executable);
    for (i=1; p->argv[i] != NULL; i++) {
	fprintfWithQuotes(fp, p->argv[i]);
    }
    fprintf(fp, "\n");
    fflush(fp);
    DEBUG0("done");
    return 0;
#endif
