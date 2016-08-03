/*
 * rc.c : read init file at startup
 *
 * George Ferguson, ferguson@cs.rochester.edu, 23 May 1996
 * Time-stamp: <96/05/23 18:05:18 ferguson>
 */
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/param.h>
#include "trlib/input.h"
#include "util/error.h"
#include "util/debug.h"
#include "rc.h"
#include "recv.h"

/*
 * Functions defined here:
 */
void readInitFile(char *filename);

/*	-	-	-	-	-	-	-	-	*/

void
readInitFile(char *filename)
{
    char fullname[MAXPATHLEN], *s;
    KQMLPerformative *perf;
    int fd;

    if (filename == NULL) {
	return;
    }
    DEBUG1("filename=%s", filename);
    /* Try current directory first */
    if ((fd = open(filename, O_RDONLY)) >= 0) {
	/* Ok */
	DEBUG1("reading %s", filename);
    } else if (errno != ENOENT) {
	/* Error other than "file not found" */
	SYSERR1("couldn't read %s", filename);
	return;
    } else {
	/* File not found: check in TRAINS_BASE/etc */
	if ((s = getenv("TRAINS_BASE")) == NULL) {
	    s = TRAINS_BASE;
	}
	sprintf(fullname, "%s/etc/%s", s, filename);
	if ((fd = open(fullname, O_RDONLY)) >= 0) {
	    /* Yup */
	    DEBUG1("reading %s", fullname);
	} else if (errno != ENOENT) {
	    /* Error other than "file not found" */
	    SYSERR1("couldn't read %s", filename);
	    return;
	} else {
	    /* Nope: so forget it */
	    DEBUG0("couldn't open init file");
	    return;
	}
    }
    /* New read KQML from the init file until EOF */
    while (trlibInput(fd, TRLIB_BLOCK, receiveMsg) > 0) {
	/*empty*/
    }
    /* Close init file */
    close(fd);
    DEBUG0("done");
}
