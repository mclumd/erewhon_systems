/*
 * mouse.c
 *
 * George Ferguson, ferguson@cs.rochester.edu, 18 Jun 1995
 * Time-stamp: <96/10/22 10:17:20 ferguson>
 */
#include <stdio.h>
#include "util/buffer.h"
#include "util/error.h"
#include "mouse.h"
#include "object.h"
#include "send.h"

#define NEARNESS 5

/*
 * Functions defined here:
 */
void buttonPress(int button, int x, int y);
void buttonMotion(int x, int y);
void buttonRelease(int button, int x, int y);

/*
 * Data defined here:
 */
static int buttonx, buttony;
static Object *buttonobj;

/*	-	-	-	-	-	-	-	-	*/

void
buttonPress(int button, int x, int y)
{
    Object **objs;

    buttonx = x;
    buttony = y;
    /* Should consider keeping entire list here, but who cares */
    if ((buttonobj=findObjectByCoords(buttonx, buttony, 1)) == NULL) {
	if ((objs=findObjectsNearCoords(buttonx,buttony,NEARNESS,1)) == NULL) {
	    buttonobj = NULL;
	} else {
	    buttonobj = objs[0];
	}
    }
}

void
buttonMotion(int x, int y)
{
    /* Eventually want to redraw the buttonobj here */
}

void
buttonRelease(int button, int x, int y)
{
    static Buffer *txtbuf = NULL;
    static char nul = '\0';
    Object *dstobj = findObjectByCoords(x, y, 1);
    Object **others = findObjectsNearCoords(x, y, NEARNESS, 1);
    int i;

    /* Initialize buffer to contain message */
    if (txtbuf == NULL) {
	if ((txtbuf = bufferCreate()) == NULL) {
	    SYSERR0("couldn't create txtbuf");
	}
    }
    bufferErase(txtbuf);
    bufferAddString(txtbuf,"(MOUSE ");
    /* If we haven't moved, then this is a select, otherwise drag */
    if (dstobj == buttonobj) {
	bufferAddString(txtbuf, ":SELECT ");
	bufferAddString(txtbuf, buttonobj ? buttonobj->any.name : "NIL");
	if (others != NULL) {
	    for (i=0; others[i] != NULL; i++) {
		if (others[i] != buttonobj) {
		    bufferAddString(txtbuf, " ");
		    bufferAddString(txtbuf, others[i]->any.name);
		}
	    }
	}
    } else {
	/* We have moved, so this a drag */
	bufferAddString(txtbuf, ":DRAG ");
	bufferAddString(txtbuf, buttonobj ? buttonobj->any.name : "NIL");
	bufferAddString(txtbuf, " :FROM ");
	if (buttonobj != NULL &&
	    buttonobj->any.type == OBJ_ENGINE ||
	    buttonobj->any.type == OBJ_PLANE) {
	    bufferAddString(txtbuf, buttonobj->engine.atcity ?
			    buttonobj->engine.atcity->name : "NIL");
	} else {
	    bufferAddString(txtbuf, buttonobj ? buttonobj->any.name : "NIL");
	}
	bufferAddString(txtbuf, " :TO (");
	bufferAddString(txtbuf, dstobj ? dstobj->any.name : "NIL");
	if (others != NULL) {
	    for (i=0; others[i] != NULL; i++) {
		if (others[i] != dstobj) {
		    bufferAddString(txtbuf, " ");
		    bufferAddString(txtbuf, others[i]->any.name);
		}
	    }
	}
	bufferAddString(txtbuf, ")");
    }
    bufferAddString(txtbuf, ")");
    bufferAdd(txtbuf, &nul, 1);
    /* Done, send the message */
    sendMsg(bufferData(txtbuf));
}

