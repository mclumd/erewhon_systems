/*
 * color.c : Color allocation
 *
 * George Ferguson, ferguson@cs.rochester.edu, 21 Dec 1994
 * Time-stamp: <96/04/23 13:26:42 ferguson>
 * 
 * We need this because repeated calls to XAllocNamedColor() will screw
 * up the reference counting, not that I care, but also it requires
 * a round-trip to the server. It also handles switching to a private
 * colormap if necessary, which is nice.
 */

#include <X11/Intrinsic.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#undef DEBUG
#include "util/error.h"
#include "util/debug.h"
#include "displayP.h"
#include "color.h"

/*
 * Functions defined here
 */
int stringToColor(char *name, Color *colorp);
int colorToRGB(Color color, int *redp, int *greenp, int *bluep);
void cleanupColors(void);

/*
 * Data defined here:
 */
typedef struct _ColorName_s {
    char *name;
    Color color;
    unsigned short red, green, blue;
    struct _ColorName_s *next;
} ColorName;

static ColorName *colorList;

/* true if we have a private colormap */
static privateCmap = 0;

/*	-	-	-	-	-	-	-	-	*/

int
stringToColor(char *name, Color *colorp)
{
    Colormap cmap;
    XColor color,exact;
    ColorName *p;

    DEBUG1("name=%s", name);
    /* First check our cache */
    for (p=colorList; p != NULL; p=p->next) {
	if (strcasecmp(name,p->name) == 0) {
	    *colorp = p->color;
	    DEBUG1("cached *colorp=%u", *colorp);
	    return 0;
	}
    }
    /* Not found, have to allocate a new color */
    if (!XAllocNamedColor(display,colormap,name,&color,&exact)) {
#ifdef attempt_to_use_new_colormap_which_never_worked
	/* Failed, so try switching colormaps if we haven't already */
	if (!privateCmap &&
	    (cmap = XCopyColormapAndFree(display,colormap)) &&
	    XAllocNamedColor(display,colormap,name,&color,&exact)) {
	    /* Ok, got it with new colormap */
	    privateCmap = 1;
	    colormap = cmap;
	    /* Should maybe be setting this on other windows under toplevel */
	    XSetWindowColormap(display,canvas,colormap);
	} else {
	    /* Failed again, bogus */
	    ERROR1("couldn't allocate color: %s", name);
	    return -1;
	}
#else
	ERROR1("couldn't allocate color: %s", name);
	return -1;
#endif
    }
    /* Got it, now store it in our cache */
    if ((p = (ColorName*)malloc(sizeof(ColorName))) == NULL) {
	SYSERR0("ColorName");
	return -1;
    }
    if ((p->name = malloc(strlen(name)+1)) == NULL) {
	SYSERR0("name");
	return -1;
    }
    strcpy(p->name,name);
    p->color = color.pixel;
    p->red = color.red;
    p->green = color.green;
    p->blue = color.blue;
    p->next = colorList;
    colorList = p;
    /* Set the color and return OK */
    *colorp = p->color;
    DEBUG1("returning *colorp=%u", *colorp);
    return 0;
}

int
colorToRGB(Color color, int *redp, int *greenp, int *bluep)
{
    ColorName *p;

    for (p=colorList; p != NULL; p=p->next) {
	if (p->color == color) {
	    *redp = (int)(p->red);
	    *greenp = (int)(p->green);
	    *bluep = (int)(p->blue);
	    return 0;
	}
    }
    return -1;
}

void
cleanupColors(void)
{
    ColorName *p,*q;
    unsigned long pixel;

    for (p=colorList; p != NULL; p=q) {
	q = p;
	pixel = p->color;
	XFreeColors(display,colormap,&pixel,1,0);
	free((char*)p);
    }
    if (privateCmap) {
	/* Should we set the colormap of the canvas to something meaningful? */
	XFreeColormap(display,colormap);
    }
}
