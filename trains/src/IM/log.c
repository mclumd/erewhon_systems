/*
 * log.c
 *
 * George Ferguson, ferguson@cs.rochester.edu,  9 Jan 1996
 * Time-stamp: <96/08/01 14:43:31 ferguson>
 */
#include <stdio.h>
#include <sys/param.h>
#include "log.h"
#include "client.h"
#include "util/memory.h"
#include "util/error.h"

/*
 * Functions defined here:
 */
void openLog(void);
void logInput(int fd, char *txt);
void logOutput(int fd, char *txt, int len);
void logGarbage(int fd, char *txt, char *errtxt);
void logChdir(char *dir);
static void flushGarbage(void);
static char *timestring(void);

/*
 * Data defined here:
 */
static FILE *logfp = NULL;
static char *logdir = NULL;
static int garbageFd = -1;
static char garbage[1024];
static char *garbageError;

/*	-	-	-	-	-	-	-	-	*/

void
openLog(void)
{
    char pathname[MAXPATHLEN];

    if (logdir == NULL) {
	strcpy(pathname, "im.log");
    } else {
	sprintf(pathname, "%s/im.log", logdir);
    }
    DEBUG1("pathname=%s", pathname);
    if ((logfp = fopen(pathname, "w")) == NULL) {
	SYSERR1("couldn't open %s", pathname);
    }
    fprintf(logfp, "-- %s [log starts]\n\n", timestring());
}

void
closeLog(void)
{
    if (logfp) {
	fprintf(logfp, "--  %s [log ends]\n\n", timestring());
	fclose(logfp);
    }
}

void
logInput(int fd, char *txt)
{
    Client *c;

    if (logfp) {
	/* Flush any pending garbage */
	flushGarbage();
	/* Log the sender (or just the fd if no sender known) */
	if ((c=findClientByFd(fd)) != NULL && c->name) {
	    fprintf(logfp, "<%s ", c->name);
	} else {
	    fprintf(logfp, "<%-2d ", fd);
	}
	/* Log the time and message to the im log */
	fprintf(logfp, "%s %s\n", timestring(), txt);	
	fflush(logfp);
    }
}

void
logOutput(int fd, char *txt, int len)
{
    Client *c;

    if (logfp) {
	/* Flush any pending garbage */
	flushGarbage();
	/* Log the receiver (or just the fd if no receiver known) */
	if ((c=findClientByFd(fd)) != NULL && c->name) {
	    fprintf(logfp, ">%s ", c->name);
	} else {
	    fprintf(logfp, ">%-2d ", fd);
	}
	fprintf(logfp, "%s ", timestring());
	/* Log the message to the im log */
	fwrite(txt, 1, len, logfp);
	fflush(logfp);
    }
}

void
logChdir(char *dir)
{
    DEBUG1("dir=%s", dir);
    closeLog();
    gfree(logdir);
    logdir = gnewstr(dir);
    openLog();
    DEBUG0("done");
}

/*
 * When logging "garbage", we gather it up as much as possible before
 * writing it to the log. This is in particular to make it easier to
 * understand the KQML_ERROR_BAD_START errors that are reported for every
 * character seen outside a performative.
 * Note: This strategy is predicated on the fact that we get a single
 * character of garbage in the BAD_START case, whereas other errors (in the
 * middle of a message) will be longer.
 * NOTE: We assume errtxt won't go away, so we can save it in `garbageError'
 * until it's time to print the garbage. This is safe (for now) since we
 * only ever pass in the result of KQMLErrorString(). In general we'd need
 * to copy the string, and then use strcmp instead of !=.
 */
void
logGarbage(int fd, char *txt, char *errtxt)
{
    if (fd != garbageFd || strlen(txt) != 1 || garbageError != errtxt) {
	flushGarbage();
	garbageFd = fd;
	garbageError = errtxt;
    }
    if (strlen(garbage) + strlen(txt) > sizeof(garbage)-1) {
	ERROR1("garbage buffer overflow, text=\"%s\"", txt);
    } else {
	strcat(garbage, txt);
    }
}

static void
flushGarbage(void)
{
    Client *c;

    if (garbage[0] != '\0') {
	if (logfp) {
	    /* Log the garbage to the im log */
	    if ((c=findClientByFd(garbageFd)) != NULL && c->name) {
		fprintf(logfp, "!%s ", c->name);
	    } else {
		fprintf(logfp, "!%-2d ", garbageFd);
	    }
	    fprintf(logfp, "%s [garbage: %s]\n %s\n",
		    timestring(), garbageError, garbage);
	    fflush(logfp);
	}
	/* Reset the garbage */
	garbage[0] = '\0';
    }
}

/*	-	-	-	-	-	-	-	-	*/
/*
 * We could just store the value of time() in the log and parse it into
 * hh:mm:ss later, but this makes it easier to read the log (at the cost
 * of possibly slowing down the im a bit).
 */
#include <time.h>

static char *
timestring(void)
{
    static char buf[16];
    time_t t;
    struct tm *tt;

    t = time(NULL);
    tt = localtime(&t);
    sprintf(buf, "%02d:%02d:%02d", tt->tm_hour, tt->tm_min, tt->tm_sec);
    return buf;
}
