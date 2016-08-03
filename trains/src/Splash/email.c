/*
 * email.c
 *
 * George Ferguson, ferguson@cs.rochester.edu, 18 Sep 1996
 * Time-stamp: <96/10/24 13:37:02 ferguson>
 */
#include <stdio.h>
#include <stdlib.h>
#include <sys/param.h>			/* MAXPATHLEN */
#include <fcntl.h>			/* O_RDONLY */
#include <Xm/Xm.h>
#include <Xm/Form.h>
#include <Xm/RowColumn.h>
#include <Xm/Label.h>
#include <Xm/PushB.h>
#include <Xm/ToggleB.h>
#include <Xm/Separator.h>
#include <Xm/Text.h>
#include <Xm/TextF.h>
#include "util/error.h"
#include "util/debug.h"
#include "email.h"
extern Widget toplevel;

/*
 * Functions defined here:
 */
void popupEmailPanel(char *dir);
static void createDialog(void);
static void doneCB(Widget w, XtPointer client_data,XtPointer call_data);
static void insertCB(Widget w, XtPointer client_data, XtPointer call_data);
static Boolean InsertFileNamed(Widget tw, char *str);

/*
 * Data defined here:
 */
static Widget dialogW;
static Widget othersW, subjectW, bodyW;
static char *saveDir;
/*
 * User info for email recipients
 */
static struct _recipients_s { 
    char *name;
    int set;
    Widget widget;
} recipients[] = {
    { "james",		1 },
    { "ferguson" },
    { "ringger" },
    { "stent" },
};

/*	-	-	-	-	-	-	-	-	*/

static Widget dialogW, othersW, subjectW, bodyW;

void
popupEmailPanel(char *dir)
{
    DEBUG0("");
    /* Create the panel if needed */
    if (dialogW == NULL) {
	createDialog();
    }
    /* And set subject of msg to save directory */
    XmTextFieldSetString(subjectW, dir);
    /* Clear previous message body */
    XmTextSetString(bodyW, "");
    /* Save the directory name for later use */
    saveDir = dir;
    /* Popup the panel */
    XtManageChild(dialogW);
    DEBUG0("done");
}

static void
createDialog(void)
{
    Widget rc, subrc, button, sep;
    Arg args[8];
    XmString labstr;
    int n, i;

    /* Form Dialog (not managed until ready to popup) */
    n = 0;
    XtSetArg(args[n], XmNdialogStyle, XmDIALOG_APPLICATION_MODAL); n++;
    XtSetArg(args[n], XmNautoUnmanage, False); n++;
    XtSetArg(args[n], XmNtitle, "Send TRAINS email"); n++;
    dialogW = XmCreateFormDialog(toplevel, "email", args, n);
    /* Vert RC */
    n = 0;
    XtSetArg(args[n], XmNorientation, XmVERTICAL); n++;
    rc = XmCreateWorkArea(dialogW, "rc", args, n);
    XtManageChild(rc);
    /* Recipients (toggles and a text item) */
    n = 0;
    XtSetArg(args[n], XmNorientation, XmHORIZONTAL); n++;
    subrc = XmCreateWorkArea(rc, "to", args, n);
    XtManageChild(subrc);
    n = 0;
    labstr = XmStringCreate("To:", XmSTRING_DEFAULT_CHARSET);
    XtSetArg(args[n], XmNlabelString, labstr); n++;
    XtManageChild(XmCreateLabel(subrc, "label", args, n));
    XmStringFree(labstr);
    for (i=0; i < XtNumber(recipients); i++) {
	n = 0;
	XtSetArg(args[n], XmNset, recipients[i].set); n++;
	recipients[i].widget =
	    XmCreateToggleButton(subrc, recipients[i].name, args, n);
	XtManageChild(recipients[i].widget);
    }
    n = 0;
    XtSetArg(args[n], XmNcolumns, 20); n++;
    othersW = XmCreateTextField(subrc, "others", args, n);
    XtManageChild(othersW);
    /* Subject (label and textfield) */
    n = 0;
    XtSetArg(args[n], XmNorientation, XmHORIZONTAL); n++;
    subrc = XmCreateWorkArea(rc, "subject", args, n);
    XtManageChild(subrc);
    n = 0;
    labstr = XmStringCreate("Subject:", XmSTRING_DEFAULT_CHARSET);
    XtSetArg(args[n], XmNlabelString, labstr); n++;
    XtManageChild(XmCreateLabel(subrc, "label", args, n));
    XmStringFree(labstr);
    n = 0;
    XtSetArg(args[n], XmNcolumns, 40); n++;
    subjectW = XmCreateTextField(subrc, "subject", args, n);
    XtManageChild(subjectW);
    XmStringFree(labstr);
    /* Body of message */
    n = 0;
    XtSetArg(args[n], XmNrows, 20); n++;
    XtSetArg(args[n], XmNcolumns, 80); n++;
    XtSetArg(args[n], XmNeditMode, XmMULTI_LINE_EDIT); n++;
    bodyW = XmCreateScrolledText(rc, "body", args, n);
    XtManageChild(bodyW);
    /* Separator */
    n = 0;
    XtSetArg(args[n], XmNtopAttachment, XmATTACH_WIDGET); n++;
    XtSetArg(args[n], XmNtopWidget, rc); n++;
    XtSetArg(args[n], XmNleftAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNrightAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNorientation, XmHORIZONTAL); n++;
    sep = XmCreateSeparator(dialogW, "sep", args, n);
    XtManageChild(sep);
    /* Cancel */
    n = 0;
    XtSetArg(args[n], XmNtopAttachment, XmATTACH_WIDGET); n++;
    XtSetArg(args[n], XmNtopWidget, sep); n++;
    XtSetArg(args[n], XmNbottomAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNleftAttachment, XmATTACH_FORM); n++;
    button = XmCreatePushButton(dialogW, "Cancel", args, n);
    XtManageChild(button);
    XtAddCallback(button, XmNactivateCallback, doneCB, (XtPointer)0);
    XtSetArg(args[0], XmNcancelButton, button);
    XtSetValues(dialogW, args, 1);
    /* Insert transcript */
    n = 0;
    XtSetArg(args[n], XmNtopAttachment, XmATTACH_WIDGET); n++;
    XtSetArg(args[n], XmNtopWidget, sep); n++;
    XtSetArg(args[n], XmNbottomAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNleftAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNleftOffset, 250); n++;
    button = XmCreatePushButton(dialogW, "Insert Transcript", args, n);
    XtManageChild(button);
    XtAddCallback(button, XmNactivateCallback, insertCB, NULL);
    /* OK */
    n = 0;
    XtSetArg(args[n], XmNtopAttachment, XmATTACH_WIDGET); n++;
    XtSetArg(args[n], XmNtopWidget, sep); n++;
    XtSetArg(args[n], XmNbottomAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNrightAttachment, XmATTACH_FORM); n++;
    button = XmCreatePushButton(dialogW, "Send", args, n);
    XtManageChild(button);
    XtAddCallback(button, XmNactivateCallback, doneCB, (XtPointer)1);
    XtSetArg(args[0], XmNdefaultButton, button);
    XtSetValues(dialogW, args, 1);
}

static void
doneCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    int ok = (int)client_data;
    char cmd[256], *str;
    FILE *fp;
    int i, doit, status;

    DEBUG0("");
    if (ok) {
	/* Command to send mail */
	strcpy(cmd, "/usr/ucb/mail ");
	/* Subject (if any) */
	strcat(cmd, "-s '");
	str = XmTextFieldGetString(subjectW);
	if (str && *str) {
	    strcat(cmd, str);
	} else {
	    strcat(cmd, "<no subject>");
	}
	strcat(cmd, "' ");
	/* Now recipients (check that there are some) */
	doit = 0;
	for (i=0; i < XtNumber(recipients); i++) {
	    if (XmToggleButtonGetState(recipients[i].widget)) {
		strcat(cmd, recipients[i].name);
		strcat(cmd, " ");
		doit = 1;
	    }
	}
	str = XmTextFieldGetString(othersW);
	if (str && *str) {
	    strcat(cmd, str);
	    doit = 1;
	}
	XtFree(str);
	/* No recipients? */
	if (!doit) {
	    DEBUG0("no recipients");
	    XBell(XtDisplay(w), 0);
	    return;
	}
	/* Open pipe to mail command */
	DEBUG1("cmd=\"%s\"\n", cmd);
	if ((fp = popen(cmd, "w")) == NULL) {
	    SYSERR1("couldn't popen cmd \"%s\"", cmd);
	    return;
	}
	/* Get body of message... */
	str = XmTextGetString(bodyW);
	/* ...And send it to mail command */
	fputs(str, fp);
	XtFree(str);
	/* Finish the mail command */
	if ((status=pclose(fp)) != 0) {
	    ERROR1("mail cmd returned %d", status);
	}
    }
    /* Unmanage child to pop it down */
    XtUnmanageChild(dialogW);
    DEBUG0("done");
}

static void
insertCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    char filename[MAXPATHLEN];

    DEBUG0("insert transcript");
    if (saveDir != NULL) {
	sprintf(filename, "%s/transcript", saveDir);
    } else {
	strcpy(filename, "transcript");
    }
    InsertFileNamed(bodyW, filename);
    DEBUG0("done");
}

/*	-	-	-	-	-	-	-	-	*/

static Boolean
InsertFileNamed(Widget tw, char *str)
{
    int fid, nread;
    char buf[BUFSIZ+1];
    XmTextPosition pos;

    if (str == NULL || *str == 0 || (fid = open(str, O_RDONLY)) < 0) {
	return(FALSE);
    }
    pos = XmTextGetInsertionPosition(tw);
    while ((nread=read(fid, buf, BUFSIZ)) > 0) {
	buf[nread] = '\0';
	XmTextInsert(tw, pos, buf);
	pos += nread;
    }
    (void) close(fid);
    XmTextSetInsertionPosition(tw, pos);
    return(TRUE);
}
