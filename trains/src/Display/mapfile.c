/*
 * mapfile.c : Map file processing
 *
 * George Ferguson, ferguson@cs.rochester.edu, 18 Apr 1995
 * Time-stamp: <96/04/23 15:34:05 ferguson>
 *
 * Map files are just files containing commands identical to those normally
 * received from the IM (recv.c).
 *
 * Map files are searched for in the current directory, then in
 * TRAINS_BASE/etc/maps.
 */
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/param.h>
#include "KQML/KQML.h"
#include "util/error.h"
#include "util/debug.h"
#include "mapfile.h"
#include "recv.h"
KQMLPerformative *HackedKQMLRead(int fd, KQMLError *errorp, char **txtp);

#ifndef TRAINS_BASE
A default for TRAINS_BASE must be defined!
#endif

/*
 * Functions defined here:
 */
void readMapFile(char *filename);
static int openMapFile(char *filename);

/*	-	-	-	-	-	-	-	-	*/

void
readMapFile(char *filename)
{
    char fullname[MAXPATHLEN], *s;
    int fd;
    KQMLPerformative *perf;
    KQMLError error;

    if (filename == NULL) {
	return;
    }
    DEBUG1("filename=%s", filename);
    /* Try current directory first */
    if ((fd = openMapFile(filename)) < 0) {
	/* Then with .map suffix */
	sprintf(fullname, "%s.map", filename);
	if ((fd = openMapFile(fullname)) < 0) {
	    /* Then in TRAINS_BASE/etc/maps */
	    if ((s = getenv("TRAINS_BASE")) == NULL) {
		s = TRAINS_BASE;
	    }
	    sprintf(fullname, "%s/etc/maps/%s", s, filename);
	    if ((fd = openMapFile(fullname)) < 0) {
		/* Then with .map suffix */
		sprintf(fullname, "%s/etc/maps/%s.map", s, filename);
		if ((fd = openMapFile(fullname)) < 0) {
		    ERROR1("couldn't find map file: %s", filename);
		    return;
		}
	    }
	}
    }
    /* Now read KQML from the init file until EOF */
    /* This is based in trlib/input.c, but we need to call the version of
     * KQMLRead() that works reasonably on files. Piece of crap.
     */
    while (1) {
	DEBUG1("calling KQMLRead with fd=%d", fd);
	perf = HackedKQMLRead(fd, &error, NULL);
	if (error < 0) {
	    ERROR2("KQML error %d (%s)", error, KQMLErrorString(error));
	    if (error <= KQML_ERROR_SYSTEM_ERROR) {
		break;
	    }
	} else if (error == 0) {
	    DEBUG0("EOF!");
	    break;
	} else if (perf != NULL) {
	    /* Read complete */
	    DEBUG0("processing msg");
	    receiveMsg(perf);
	    /* Free performative */
	    KQMLFreePerformative(perf);
	}
    }
    /* Close init file */
    close(fd);
    DEBUG0("done");
}

static int
openMapFile(char *filename)
{
    int fd;

    if ((fd = open(filename, O_RDONLY)) >= 0) {
	DEBUG1("opened %s", filename);
	return fd;
    } else if (errno != ENOENT) {
	/* Error other than "file not found" */
	SYSERR1("couldn't read %s", filename);
    }
    return -1;
}
