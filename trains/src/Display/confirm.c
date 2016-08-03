/*
 * confirm.c: Blocking Yes/No confirmer
 *
 * George Ferguson, ferguson@cs.rochester.edu, 5 Jul 1995
 * Time-stamp: <96/04/18 15:24:52 ferguson>
 */
#include <stdio.h>
#include <X11/Intrinsic.h>
#include <X11/StringDefs.h>
#include <X11/Shell.h>
#include <X11/Xaw/Dialog.h>
#include <X11/Xaw/Command.h>
#include "util/memory.h"
#include "util/error.h"
#include "confirm.h"
#include "send.h"
#include "center.h"
extern Widget toplevel;

/*
 * Functions defined here:
 */
int popupConfirmer(char *prompt, char *tag);
static void doneCB(Widget w, XtPointer client_data, XtPointer call_data);

/*	-	-	-	-	-	-	-	-	*/

int
popupConfirmer(char *prompt, char *tag)
{
    Widget panel, dialog, button;

    /* Save copy of tag for future use */
    tag = gnewstr(tag);
    /* Create widgets */
    panel = XtVaCreatePopupShell("confirm", transientShellWidgetClass,toplevel,
				 NULL);
    dialog = XtVaCreateManagedWidget("dialog", dialogWidgetClass, panel,
				     XtNlabel, prompt,
				     NULL);
    button = XtVaCreateManagedWidget("cancel", commandWidgetClass, dialog,
				     XtNlabel, "Cancel",
				     NULL);
    XtAddCallback(button, XtNcallback, doneCB, (XtPointer)tag);
    button = XtVaCreateManagedWidget("ok", commandWidgetClass, dialog,
				     XtNlabel, "OK",
				     NULL);
    XtAddCallback(button, XtNcallback, doneCB, (XtPointer)tag);
    XtRealizeWidget(panel);
    /* Center it on the display */
    centerWidget(panel, toplevel);
    /* Pop it up */
    XtPopup(panel, XtGrabExclusive);
}

static void
doneCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    char *tag = (char*)client_data;
    char content[256];

    /* Was this called from `ok' or `cancel'? */
    if (*(XtName(w)) == 'o') {
	sprintf(content, "(confirm %s t)", tag);
    } else {
	sprintf(content, "(confirm %s nil)", tag);
    }
    /* Send reply */
    sendMsg(content);
    /* Free copy of tag allocated above */
    gfree(tag);
    /* Find Shell parent of widget in order to pop it down and destroy it */
    while ((w = XtParent(w)) != NULL && !XtIsShell(w)) {
	/*empty*/
    }
    if (w == NULL) {
	ERROR0("yow! couldn't find shell parent!");
    } else {
	XtPopdown(w);
	XtDestroyWidget(w);
    }
}
