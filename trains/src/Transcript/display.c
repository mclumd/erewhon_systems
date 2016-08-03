/*
 * display.c
 *
 * George Ferguson, ferguson@cs.rochester.edu,  5 Mar 1996
 * Time-stamp: <96/10/22 16:12:44 ferguson>
 */
#include <stdio.h>
#include <Xm/Xm.h>
#include <Xm/Text.h>
#include "trlib/input.h"
#include "util/streq.h"
#include "util/memory.h"
#include "util/debug.h"
#include "display.h"
#include "log.h"
#include "recv.h"
#include "main.h"

/*
 * Functions defined here:
 */
void displayInit(int *argcp, char **argv);
void displayEventLoop(void);
void displayClose(void);
void displayReset(void);
static void stdinCB(XtPointer client_data, int *source, XtInputId *id);
void displayHideWindow(void);
void displayShowWindow(void);
void displayString(char *s);
void displayAndLog(char *s);

/*
 * Data defined here:
 */
static XtAppContext appcon;
static Widget toplevel;
static Widget textW;
int writeTranscript;

/* Resources */
typedef struct _AppResources_s {
    Boolean writeTranscript;
} AppResources;
static AppResources appres;

static XtResource resources[] = {
    { "writeTranscript", "writeTranscript", XtRBoolean, sizeof(Boolean),
      XtOffsetOf(AppResources,writeTranscript), XtRImmediate,(XtPointer)True },
};
static XrmOptionDescRec options[] = {
    { "-writeTranscript", ".writeTranscript",	XrmoptionSepArg },
};
static String fallbackResources[] = {
    "*title:			TRAINS Transcript",
    "*geometry:			400x150-0+290",
    "*background:		grey75",
    "*Text*font:		-*-courier-medium-r-*-*-12-*-*-*-*-*-*-*",
    NULL
};

/*	-	-	-	-	-	-	-	-	*/

void
displayInit(int *argcp, char **argv)
{
    Arg args[3];
    int n;

    toplevel = XtVaAppInitialize(&appcon, "TRAINS",
				 options, XtNumber(options),
				 (Cardinal *)argcp, argv, fallbackResources,
				 NULL);
    XtGetApplicationResources(toplevel, (XtPointer)&appres,
			      resources, XtNumber(resources), NULL, 0);
    /* Set globals */
    writeTranscript = appres.writeTranscript;
    /* Create text widget */
    n = 0;
    XtSetArg(args[n], XmNeditMode, XmMULTI_LINE_EDIT); n++;
    XtSetArg(args[n], XmNcursorPositionVisible, False); n++;
    XtSetArg(args[n], XmNautoShowCursorPosition, True); n++;
    textW = XmCreateScrolledText(toplevel, "text", args, n);
    XtManageChild(textW);
    XtRealizeWidget(toplevel);
}

void
displayEventLoop(void)
{
    /* And register to be called back when input available */
    XtAppAddInput(appcon, 0, (XtPointer)XtInputReadMask, stdinCB, NULL);
    /* Go process events */
    XtAppMainLoop(appcon);
}

void
displayClose(void)
{
    XtDestroyApplicationContext(appcon);
}


void
displayReset(void)
{
    XmTextSetString(textW, "");
}

void
displayHideWindow(void)
{
    XtVaSetValues(toplevel, XtNiconic, True, NULL);
}

void
displayShowWindow(void)
{
    XtVaSetValues(toplevel, XtNiconic, False, NULL);
}

/*	-	-	-	-	-	-	-	-	*/

void
displayString(char *s)
{
    XmTextPosition pos;

    pos = XmTextGetLastPosition(textW);
    XmTextInsert(textW, pos, s);
    /* Force it to be visible with autoShowCursorPosition */
    XmTextSetInsertionPosition(textW, pos);
}

void
displayAndLog(char *s)
{
    if (s != NULL) {
	displayString(s);
	logString(s);
    }
}

/*	-	-	-	-	-	-	-	-	*/
/*
 * This is called when there's something ready from the IM.
 */
static void
stdinCB(XtPointer client_data, int *source, XtInputId *id)
{
    int ret;

    if ((ret = trlibInput(*source, TRLIB_DONTBLOCK, receiveMsg)) <= 0) {
	programExit(ret);
    }
}
