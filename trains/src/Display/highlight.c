/*
 * highlight.c : Object highlighting
 *
 * George Ferguson, ferguson@cs.rochester.edu, 28 Feb 1995
 * Time-stamp: <96/05/23 14:47:50 ferguson>
 */
#include <stdio.h>
#include <stdlib.h>
#include "display.h"
#include "object.h"
#include "shape.h"
#include "color.h"
#include "highlight.h"
#include "util/error.h"

extern double sqrt(double);

/*
 * Functions defined here:
 */
void objectHighlight(Object *obj, HighlightType htype,
		     Color color, int flashes);

void objectUnhighlight(Object *obj, HighlightType htype,
		       Color *colorp, int *flashesp);

static Highlight *highlightCreate(HighlightType htype, Color color,
				  Shape *shape, int flashes);
static void highlightDestroy(Highlight *this);
void highlightListDestroy(Highlight *list);
void highlightListDisplay(Highlight *list);

HighlightType stringToHighlightType(char *str);

/*	-	-	-	-	-	-	-	-	*/

typedef struct _Flash_s {
    Object *obj;
    Highlight *highlight;
    int state;
    int count;
    Color origcolor;
    Color origfillcolor;
    struct _Flash_s *next;
} Flash;
static Flash *flashList;
static TimerId flashTimer;

static void highlightAddFlasher(Object *obj, Highlight *highlight);
static void flashCallback(void *data, TimerId *id);
/*	-	-	-	-	-	-	-	-	*/

void
objectHighlight(Object *this, HighlightType htype, Color color, int flashes)
{
    Highlight *highlight;
    Shape *hshape;
    int x,y,w,h;

    /* If entire object highlighted, just set its color */
    if (htype == HI_OBJECT) {
	hshape = shapeCopy(this->any.shape);
	shapeSetColor(hshape, color);
	shapeSetFillColor(hshape, color);
    } else {
	/* Otherwise make shape from object's bounding box */
	if (!shapeBoundingBox(this->any.shape,&x,&y,&w,&h)) {
	    /* Can't do non-object highlighting for some objects */
	    return;
	}
	switch (htype) {
	  case HI_CIRCLE:
	    w /= 2;
	    h /= 2;
	    hshape = shapeCreate(SH_CIRCLE, color, 1, 0, 0,
				 x+w, y+h, (int)(sqrt(w*w+h*h)+0.5));
	    break;
	  case HI_RECTANGLE:
	    hshape = shapeCreate(SH_RECTANGLE, color, 1, 0, 0,
				 x-1, y-1, w+2, h+2);
	    break;
	}
    }
    /* Create highlight entry */
    if ((highlight = highlightCreate(htype,color,hshape,flashes)) == NULL) {
	shapeDestroy(hshape);
	return;
    }
    /* Add to list of highlights for this object */
    highlight->next = this->any.highlights;
    this->any.highlights = highlight;
    /* For flashing highlights, add an entry to the list of flashers */
    if (flashes != 0) {
	highlightAddFlasher(this,highlight);
    }
    /* Better redraw this guy now */
    objectDisplay(this);
}

/*	-	-	-	-	-	-	-	-	*/

void
objectUnhighlight(Object *this, HighlightType htype,
		  Color *colorp, int *flashesp)
{
    Highlight *h,*last,*next;

    /* For each highlight on this object... */
    for (h=this->any.highlights; h != NULL; h=next) {
	next = h->next;
	/* If we are clearing all highlights or this highlight matches... */
	if ((htype == HI_NONE || htype == h->type) &&
	    (!colorp || *colorp == h->color) &&
	    (!flashesp || *flashesp == h->flashes)) {
	    /* Remove from list of highlights */
	    if (h == this->any.highlights) {
		this->any.highlights = next;
	    } else {
		last->next = next;
	    }
	    /* Remove from the flash list if flashing */
	    if (h->flashes != 0) {
		Flash *p,*lastp,*nextp;
		for (p=flashList; p != NULL; p=nextp) {
		    nextp = p->next;
		    if (p->highlight == h) {
			if (p == flashList) {
			    flashList = nextp;
			} else {
			    lastp->next = nextp;
			}
			free((char*)p);
			break;
		    } else {
			lastp = p;
		    }
		}
	    }
	    /* And free the highlight rec */
	    highlightDestroy(h);
	} else {
	    /* Otherwise leave this highlight alone */
	    last = h;
	}
    }
    /* Better redraw this guy now */
    objectDisplay(this);
}

/*	-	-	-	-	-	-	-	-	*/

static Highlight *
highlightCreate(HighlightType type, Color color, Shape *shape, int flashes)
{
    Highlight *this = (Highlight*)malloc(sizeof(Highlight));

    if (this == NULL) {
	SYSERR0("this");
	return NULL;
    }
    this->type = type;
    this->color = color;
    this->shape = shape;
    this->flashes = flashes;
    return this;
}

static void
highlightDestroy(Highlight *this)
{
    if (this->shape)
	shapeDestroy(this->shape);
    free((char*)this);
}

void
highlightListDestroy(Highlight *list)
{
    Highlight *p;

    while (list) {
	p = list->next;
	highlightDestroy(list);
	list = p;
    }
}

void
highlightListDisplay(Highlight *list)
{
    while (list) {
	if (list->shape) {
	    shapeDisplay(list->shape);
	}
	list = list->next;
    }
}

/*	-	-	-	-	-	-	-	-	*/

static void
highlightAddFlasher(Object *obj, Highlight *highlight)
{
    Flash *this = (Flash*)malloc(sizeof(Flash));

    if (this == NULL) {
	SYSERR0("this");
	return;
    }
    this->obj = obj;
    this->highlight = highlight;
    this->state = 1;
    /* Original color is shape's color (possibly already highlighted!) */
    this->origcolor = this->obj->any.shape->any.color;
    this->origfillcolor = this->obj->any.shape->any.fillcolor;
    /* If finite flashing, adjust for on/off and already highlighted once */
    if (highlight->flashes > 0) {
	this->count = highlight->flashes * 2 - 1;
    } else {
	this->count = highlight->flashes;
    }
    /* Add to global list */
    this->next = flashList;
    flashList = this;
    /* Make sure timer is going */
    if (!flashTimer) {
	flashTimer = displayStartTimer(500,flashCallback,NULL);
    }
}

static void
flashCallback(void *data, TimerId *id)
{
    Flash *f,*last,*next;
    Highlight *h;
    int redraw = 0;

    for (last=f=flashList; f != NULL; f = next) {
	/* Save next pointer */
	next = f->next;
	/* Toggle highlight state */
	f->state = !f->state;
	/* Do highlighting appropriate for state */
	h = f->highlight;
	if (f->state) {
	    shapeSetColor(h->shape, h->color);
	    shapeSetFillColor(h->shape, h->color);
	} else {
	    shapeSetColor(h->shape, f->origcolor);
	    shapeSetFillColor(h->shape, f->origfillcolor);
	}
	shapeDisplay(h->shape);
	/* Decrement flash counter if given */
	if (f->count > 0) {
	    f->count -= 1;
	    /* If counter now zero, remove from global list */
	    if (f->count == 0) {
		if (f == flashList) {
		    flashList = next;
		} else {
		    last->next = next;
		}
		free((char*)f);
		/* Unhighlight to free storage, etc. */
		objectUnhighlight(f->obj,h->type,&(h->color),&(h->flashes));
		/* Flag that a full redraw is needed */
		redraw = 1;
	    } else {
		last = f;
	    }
	}
    }
    /* Reset timer if anything still flashing */
    if (flashList == NULL) {
	flashTimer = 0;
    } else {
	flashTimer = displayStartTimer(500,flashCallback,NULL);
    }
    if (redraw) {
	displayRedraw();
    }
}

/*	-	-	-	-	-	-	-	-	*/
    
HighlightType
stringToHighlightType(char *str)
{
    if (strcasecmp(str,"OBJECT") == 0) {
	return HI_OBJECT;
    } else if (strcasecmp(str,"CIRCLE") == 0) {
	return HI_CIRCLE;
    } else if (strcasecmp(str,"RECTANGLE") == 0) {
	return HI_RECTANGLE;
    } else {
	return HI_NONE;
    }
}
