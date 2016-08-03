/*
 * logdir.c
 *
 * George Ferguson, ferguson@cs.rochester.edu,  5 Apr 1996
 * Time-stamp: <96/04/09 17:57:00 ferguson>
 */
#include <stdio.h>
#include <errno.h>
#include <time.h>
#include <sys/param.h>
#include "util/memory.h"
#include "util/error.h"
#include "util/debug.h"
#include "logdir.h"

/* This is used to create the new directory name */
#define STRFTIME_FORMAT	"%y%m%d.%H%M"

/*
 * Functions defined here:
 */
void setLogDirectory(char *dir);
char *newLogDirectory(void);
static int createDirectory(char *name);

/*
 * Data defined here:
 */
static char *logdir = NULL;

/*	-	-	-	-	-	-	-	-	*/

void
setLogDirectory(char *dir)
{
    DEBUG1("dir=%s", dir);
    gfree(logdir);
    logdir = gnewstr(dir);
    DEBUG0("done");
}

char *
newLogDirectory(void)
{
    static char dirname[MAXPATHLEN];
    int len, i;
    char *s;
    time_t t;
    struct tm *tt;

    DEBUG0("computing new directory");
    /* Start with logdir */
    strcpy(dirname, logdir);
    strcat(dirname, "/");
    len = strlen(dirname);
    /* Get the current local time */
    t = time(0);
    tt = localtime(&t);
    /* Format it into the dirname after the path (if any) */
    strftime(dirname+len, sizeof(dirname)-len, STRFTIME_FORMAT, tt);
    /* Now try to create it, adding a suffix if needed to get a new name */
    s = dirname + strlen(dirname);
    i = 1;
    while (i < 100 && createDirectory(dirname) < 0) {
	sprintf(s, ".%d", i++);
    }
    if (i == 100) {
	ERROR0("couldn't create new directory");
	return NULL;
    }
    /* Done */
    DEBUG1("done, dirname=\"%s\"", dirname);
    return dirname;
}

/*
 * Tries to create directory with given name. Returns:
 *	1  if successful
 *	0  if something with that name already exists
 *	-1 some other error
 */
static int
createDirectory(char *dirname)
{
    DEBUG1("checking directory \"%s\"", dirname);
    /* Try to create it */
    if (mkdir(dirname, 0775) < 0) {
	SYSERR1("couldn't create directory %s", dirname);
	return (errno == EEXIST) ? 0 : -1;
    }
    /* The mode in mkdir is masked by umask, so we need to chmod */
    if (chmod(dirname, 0775) < 0) {
	SYSERR1("couldn't chmod directory %s", dirname);
	/* This still counts as "success" though */
    }
    DEBUG0("done");
    return 1;
}
