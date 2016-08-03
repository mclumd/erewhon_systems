/*
 * xpm.c
 *
 * George Ferguson, ferguson@cs.rochester.edu,  5 Feb 1996
 * Time-stamp: <96/04/10 13:38:53 ferguson>
 *
 */
#include <stdio.h>
#include <string.h>
#include <sys/param.h>
#include <X11/Intrinsic.h>
#include <X11/xpm.h>
#include "util/debug.h"
#include "util/error.h"
#include "xpm.h"
#include "main.h"

/*
 * Functions defined here:
 */
Pixmap readXpmFile(Display *display, char *filename, Colormap *cmap);
static int readXpmFile2(Display *display, char *filename,
			Pixmap *pixmap, XpmAttributes *attrs);
static void reportXpmError(int err, char *filename);

/*	-	-	-	-	-	-	-	-	*/

Pixmap
readXpmFile(Display *display, char *filename, Colormap *cmap)
{
    Pixmap pixmap;
    XpmAttributes attrs;
    int result;

    DEBUG1("filename=\"%s\"", filename);
    /* Default is no new colormap (unless needed) */
    *cmap = (Colormap)0;
    /* Handle special names */
    if (strcmp(filename, "None") == 0) {
	return None;
    }
    if (strcmp(filename, "ParentRelative") == 0) {
	return ParentRelative;
    }
    /* First try to read the file with the default colormap */
    attrs.closeness = 40000;
    attrs.valuemask = XpmCloseness;
    result = readXpmFile2(display, filename, &pixmap, &attrs);
    switch (result) {
      case XpmSuccess:
	DEBUG0("read file ok");
	return pixmap;
      case XpmColorError:
	/* Try allocating a new colormap */
	DEBUG0("creating new colormap");
	*cmap = XCreateColormap(display, DefaultRootWindow(display),
				DefaultVisual(display, DefaultScreen(display)),
				AllocNone);
	attrs.colormap = *cmap;
	attrs.valuemask |= XpmColormap;
	result = readXpmFile2(display, filename, &pixmap, &attrs);
	if (result == XpmSuccess) {
	    DEBUG0("read file ok with new cmap");
	    return pixmap;
	}
	/* else fall through to report error */
      default:
	reportXpmError(result, filename);
	return None;
    }	
}

static int
readXpmFile2(Display *display, char *filename,
	     Pixmap *pixmap, XpmAttributes *attrs)
{
    char fullname[MAXPATHLEN];
    int result;

    DEBUG1("filename=%s", filename);
    /* Try to read from given filename first */
    result = XpmReadFileToPixmap(display, DefaultRootWindow(display),
				 filename, pixmap, NULL, attrs);
    if (result == XpmOpenFailed) {
	/* Failed, so try in TRAINS_BASE */
	DEBUG1("trying in TRAINS_BASE=%s/etc", trains_base);
	sprintf(fullname, "%s/etc/%s", trains_base, filename);
	result = XpmReadFileToPixmap(display, DefaultRootWindow(display),
				     fullname, pixmap, NULL, attrs);
    }
    /* Done */
    DEBUG1("done, result=%d", result);
    return result;
}

static void
reportXpmError(int err, char *filename)
{
    switch (err) {
      case XpmSuccess:
	break;
      case XpmColorError:
	ERROR1("couldn't allocate exact colors for XPM file: \"%s\"",filename);
	break;
      case XpmOpenFailed:
	ERROR1("couldn't open XPM file: \"%s\"", filename);
	break;
      case XpmFileInvalid:
 	ERROR1("invalid XPM file: \"%s\"",filename);
	break;
      case XpmNoMemory:
	ERROR1("no memory for XPM file: \"%s\"",filename);
	break;
      case XpmColorFailed:
	ERROR1("couldn't allocate colors for XPM file: \"%s\"",filename);
	break;
      default:
	ERROR1("unknown XPM error: \"%s\"",filename);
	break;
    }	
}
