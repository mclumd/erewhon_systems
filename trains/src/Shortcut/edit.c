/*
 * edit.c
 *
 * George Ferguson, ferguson@cs.rochester.edu, 16 Aug 1996
 * Time-stamp: <96/08/16 11:09:10 ferguson>
 */
#include <stdio.h>
#include <Xm/Xm.h>
#include <Xm/Xm.h>
#include <Xm/DialogS.h>
#include <Xm/Form.h>
#include <Xm/RowColumn.h>
#include <Xm/LabelG.h>
#include <Xm/Text.h>
#include <Xm/TextF.h>
#include <Xm/SeparatoG.h>
#include <Xm/PushBG.h>
#include "edit.h"
extern Widget toplevel;

/*
 * Functions defined here:
 */
void editMessage(int n, char *label, char *content);
static void createDialog(void);
static void doneCB(Widget w, XtPointer client_data, XtPointer call_data);
static Widget createLabelWidget(Widget parent, char *label, int width);
Widget createPushButtonWidget(Widget parent, char *name, char *label);

/*
 * Data defined here:
 */
static Widget dialogW, labelW, contentW;
static int messageNum;

/*	-	-	-	-	-	-	-	-	*/

void
editMessage(int n, char *label, char *content)
{
    if (dialogW == NULL) {
	createDialog();
    }
    messageNum = n;
    XmTextFieldSetString(labelW, label ? label : "");
    XmTextSetString(contentW, content ? content : "");
    /* Managing the form pops it up */
    XtManageChild(dialogW);
}

static void
createDialog(void)
{
    Widget panel, rc, subrc, button;
    Arg args[6];
    int n;

    /* Form Dialog (not managed until ready to popup) */
    n = 0;
    XtSetArg(args[n], XmNdialogStyle, XmDIALOG_FULL_APPLICATION_MODAL); n++;
    XtSetArg(args[n], XmNautoUnmanage, False); n++;
    XtSetArg(args[n], XmNtitle, "TRAINS Edit Shortcut"); n++;
    dialogW = XmCreateFormDialog(toplevel, "form", args, n);
    /* Vert RC */
    n = 0;
    XtSetArg(args[n], XmNorientation, XmVERTICAL); n++;
    rc = XmCreateWorkArea(dialogW, "rc", args, n);
    XtManageChild(rc);
    /* Horiz RC */
    n = 0;
    XtSetArg(args[n], XmNorientation, XmHORIZONTAL); n++;
    subrc = XmCreateWorkArea(rc, "subrc", args, n);
    XtManageChild(subrc);
    (void)createLabelWidget(subrc, "Label:", 0);
    n = 0;
    XtSetArg(args[n], XmNcolumns, 30); n++;
    labelW = XmCreateTextField(subrc, "labelText", args, n);
    XtManageChild(labelW);
    /* Main rc */
    (void)createLabelWidget(rc, "Content:", 0);
    n = 0;
    XtSetArg(args[n], XmNrows, 5); n++;
    XtSetArg(args[n], XmNcolumns, 80); n++;
    XtSetArg(args[n], XmNeditMode, XmMULTI_LINE_EDIT); n++;
    contentW = XmCreateScrolledText(rc, "contentText", args, n);
    XtManageChild(contentW);
    /* Form buttons */
    (void)XmCreateSeparatorGadget(dialogW, "sep", NULL, 0);
    button = createPushButtonWidget(dialogW, "ok", "OK");
    XtAddCallback(button, XmNactivateCallback, doneCB, (XtPointer)1);
    n = 0;
    XtSetArg(args[n], XmNtopAttachment, XmATTACH_WIDGET); n++;
    XtSetArg(args[n], XmNtopWidget, rc); n++;
    XtSetArg(args[n], XmNbottomAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNbottomOffset, 10); n++;
    XtSetArg(args[n], XmNleftAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNleftOffset, 10); n++;
    XtSetValues(button, args, n);
    XtSetArg(args[0], XmNdefaultButton, button);
    XtSetValues(dialogW, args, 1);
    button = createPushButtonWidget(dialogW, "cancel", "Cancel");
    XtAddCallback(button, XmNactivateCallback, doneCB, (XtPointer)0);
    n = 0;
    XtSetArg(args[n], XmNtopAttachment, XmATTACH_WIDGET); n++;
    XtSetArg(args[n], XmNtopWidget, rc); n++;
    XtSetArg(args[n], XmNbottomAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNbottomOffset, 10); n++;
    XtSetArg(args[n], XmNrightAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNrightOffset, 10); n++;
    XtSetValues(button, args, n);
    XtSetArg(args[0], XmNcancelButton, button);
    XtSetValues(dialogW, args, 1);
}    

static void
doneCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    int ok = (int)client_data;
    char *label, *content;

    if (ok) {
	label = XmTextFieldGetString(labelW);
	content = XmTextGetString(contentW);
	if (messageNum >= 0) {
	    displayReplaceMessage(messageNum, label, content);
	} else {
	    displayNewMessage(label, content);
	}
	XtFree(label);
	XtFree(content);
    }
    /* Unmanage child to pop it down */
    XtUnmanageChild(dialogW);
}

/*	-	-	-	-	-	-	-	-	*/

static Widget
createLabelWidget(Widget parent, char *label, int width)
{
    Widget w;
    Arg args[3];
    XmString labstr;
    int n;
    
    n = 0;
    labstr = XmStringCreate(label, XmSTRING_DEFAULT_CHARSET);
    XtSetArg(args[n], XmNlabelString, labstr); n++;
    if (width > 0) {
	XtSetArg(args[n], XmNwidth, width); n++;
	XtSetArg(args[n], XmNrecomputeSize, False); n++;
    }
    w = XmCreateLabelGadget(parent, "label", args, n);
    XtManageChild(w);
    XmStringFree(labstr);
    return w;
}

Widget
createPushButtonWidget(Widget parent, char *name, char *label)
{
    Widget w;
    Arg args[2];
    XmString labstr;
    int n;
    
    n = 0;
    labstr = XmStringCreate(label, XmSTRING_DEFAULT_CHARSET);
    XtSetArg(args[n], XmNlabelString, labstr); n++;
    XtSetArg(args[n], XmNalignment, XmALIGNMENT_CENTER); n++;
    w = XmCreatePushButtonGadget(parent, name, args, n);
    XtManageChild(w);
    XmStringFree(labstr);
    return w;
}
