/*
 * log.c
 *
 * George Ferguson, ferguson@cs.rochester.edu,  6 Mar 1996
 * Time-stamp: <96/08/14 14:02:15 ferguson>
 */
#include <stdio.h>
#include <time.h>
#include <sys/param.h>
#include "util/memory.h"
#include "util/error.h"
#include "util/debug.h"
#include "log.h"

/*
 * Functions defined here:
 */
void logOpen(void);
void logClose(void);
void logString(char *s);
void logChdir(char *dir);

/*
 * Data defined here:
 */
static FILE *logfp = NULL;
static char *logdir = NULL;

/*	-	-	-	-	-	-	-	-	*/

void
logOpen(void)
{
    char pathname[MAXPATHLEN];
    time_t t;
    struct tm *tt;

    DEBUG0("opening transcript");
    if (logdir == NULL) {
	strcpy(pathname, "transcript");
    } else {
	sprintf(pathname, "%s/transcript", logdir);
    }
    DEBUG1("pathname=%s", pathname);
    if ((logfp = fopen(pathname, "w")) == NULL) {
	SYSERR1("couldn't write %s", pathname);
    }
    t = time(NULL);
    tt = localtime(&t);
    fprintf(logfp, "--- --- %02d:%02d:%02d %02d/%02d/%04d\n",
	    tt->tm_hour, tt->tm_min, tt->tm_sec,
	    tt->tm_mon, tt->tm_mday, tt->tm_year+1900);
    fflush(logfp);
    DEBUG0("done");
}

void
logClose(void)
{
    DEBUG0("closing transcript");
    if (logfp) {
	fclose(logfp);
    }
    DEBUG0("done");
}

void
logString(char *s)
{
    DEBUG1("string=%s", s);
    if (logfp) {
	fprintf(logfp, "%s", s);
	fflush(logfp);
    }
    DEBUG0("done");
}

void
logChdir(char *dir)
{
    DEBUG1("dir=%s", dir);
    logClose();
    gfree(logdir);
    logdir = gnewstr(dir);
    logOpen();
    DEBUG0("done");
}
