/*
 * save.c
 *
 * George Ferguson, ferguson@cs.rochester.edu,  8 Feb 1996
 * Time-stamp: <96/10/10 11:56:20 ferguson>
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
#include "util/error.h"
#include "util/debug.h"
#include "save.h"
#include "email.h"
extern Widget toplevel;

/*
 * Functions defined here:
 */
void popupSavePanel(char *dir);
static void createDialog(void);
static void saveNoneCB(Widget w, XtPointer client_data,XtPointer call_data);
static void saveAllCB(Widget w, XtPointer client_data,XtPointer call_data);
static void saveSomeCB(Widget w, XtPointer client_data,XtPointer call_data);
static void doneCB(Widget w, XtPointer client_data,XtPointer call_data);
static void emailCB(Widget w,XtPointer client_data,XtPointer call_data);

/*
 * Data defined here:
 */
static Widget dialogW;
static Widget dirW, noneW, allW, someW;
static Widget compressW, transW, speechW, logW;
static char *saveDir;

/*	-	-	-	-	-	-	-	-	*/

void
popupSavePanel(char *dir)
{
    char *s;
    XmString labstr;

    /* Create the panel if needed */
    if (dialogW == NULL) {
	createDialog();
    }
    /* Get basename of directory name */
    if ((s = strrchr(dir, '/')) != NULL) {
	s += 1;
    } else {
	s = dir;
    }
    /* And set label on panel with it */
    labstr = XmStringCreate(s, XmSTRING_DEFAULT_CHARSET);
    XtVaSetValues(dirW, XmNlabelString, labstr, NULL);
    XmStringFree(labstr);
    /* Save the directory name for later use */
    saveDir = dir;
    /* Popup the panel */
    XtManageChild(dialogW);
}

static void
createDialog()
{
    Widget saverc, rc, sep, button;
    Arg args[6];
    XmString labstr;
    int n;

    /* Form Dialog (not managed until ready to popup) */
    n = 0;
    XtSetArg(args[n], XmNdialogStyle, XmDIALOG_APPLICATION_MODAL); n++;
    XtSetArg(args[n], XmNautoUnmanage, False); n++;
    XtSetArg(args[n], XmNtitle, "Save TRAINS Dialogue?"); n++;
    dialogW = XmCreateFormDialog(toplevel, "save", args, n);
    /* Session name info */
    n = 0;
    XtSetArg(args[n], XmNtopAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNleftAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNorientation, XmHORIZONTAL); n++;
    rc = XmCreateWorkArea(dialogW, "rc", args, n);
    XtManageChild(rc);
    n = 0;
    labstr = XmStringCreate("Save data from session:",
			    XmSTRING_DEFAULT_CHARSET);
    XtSetArg(args[n], XmNlabelString, labstr); n++;
    XtManageChild(XmCreateLabel(rc, "label", args, n));
    XmStringFree(labstr);
    n = 0;
    labstr = XmStringCreate("", XmSTRING_DEFAULT_CHARSET);
    XtSetArg(args[n], XmNlabelString, labstr); n++;
    dirW = XmCreateLabel(rc, "label", args, n);
    XtManageChild(dirW);
    XmStringFree(labstr);
    /* Radio Box for save options */
    n = 0;
    XtSetArg(args[n], XmNtopAttachment, XmATTACH_WIDGET); n++;
    XtSetArg(args[n], XmNtopWidget, rc); n++;
    XtSetArg(args[n], XmNleftAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNorientation, XmVERTICAL); n++;
    rc = saverc = XmCreateRadioBox(dialogW, "rc", args, n);
    XtManageChild(rc);
    n = 0;
    XtSetArg(args[n], XmNset, False); n++;
    noneW = XmCreateToggleButton(rc, "Save Nothing", args, n);
    XtManageChild(noneW);
    XtAddCallback(noneW, XmNvalueChangedCallback, saveNoneCB, NULL); 
    n = 0;
    XtSetArg(args[n], XmNset, True); n++;
    allW = XmCreateToggleButton(rc, "Save Everything", args, n);
    XtManageChild(allW);
    XtAddCallback(allW, XmNvalueChangedCallback, saveAllCB, NULL); 
    n = 0;
    XtSetArg(args[n], XmNset, False); n++;
    someW = XmCreateToggleButton(rc, "Save Something", args, n);
    XtAddCallback(someW, XmNvalueChangedCallback, saveSomeCB, NULL); 
    XtManageChild(someW);
    /* Toggle button for compress option */
    n = 0;
    XtSetArg(args[n], XmNtopAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNtopOffset, 52); n++;
    XtSetArg(args[n], XmNleftAttachment, XmATTACH_WIDGET); n++;
    XtSetArg(args[n], XmNleftWidget, saverc); n++;
    rc = XmCreateWorkArea(dialogW, "rc", args, n);
    n = 0;
    XtSetArg(args[n], XmNset, False); n++;
    compressW = XmCreateToggleButton(rc, "Compress", args, n);
    XtManageChild(compressW);
    XtManageChild(rc);
    /* Toggle Box for "save something" options */
    n = 0;
    XtSetArg(args[n], XmNtopAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNtopOffset, 81); n++;
    XtSetArg(args[n], XmNleftAttachment, XmATTACH_WIDGET); n++;
    XtSetArg(args[n], XmNleftWidget, saverc); n++;
    XtSetArg(args[n], XmNorientation, XmVERTICAL); n++;
    rc = XmCreateWorkArea(dialogW, "rc", args, n);
    XtManageChild(rc);
    n = 0;
    XtSetArg(args[n], XmNset, True); n++;
    transW = XmCreateToggleButton(rc, "Transcript", args, n);
    XtManageChild(transW);
    n = 0;
    XtSetArg(args[n], XmNset, False); n++;
    speechW = XmCreateToggleButton(rc, "Speech data", args, n);
    XtManageChild(speechW);
    n = 0;
    XtSetArg(args[n], XmNset, True); n++;
    logW = XmCreateToggleButton(rc, "Logs", args, n);
    XtManageChild(logW);
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
    /* Send Email */
    n = 0;
    XtSetArg(args[n], XmNtopAttachment, XmATTACH_WIDGET); n++;
    XtSetArg(args[n], XmNtopWidget, sep); n++;
    XtSetArg(args[n], XmNbottomAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNleftAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNleftOffset, 75); n++;
    button = XmCreatePushButton(dialogW, "Send Email", args, n);
    XtManageChild(button);
    XtAddCallback(button, XmNactivateCallback, emailCB, NULL);
    /* OK */
    n = 0;
    XtSetArg(args[n], XmNtopAttachment, XmATTACH_WIDGET); n++;
    XtSetArg(args[n], XmNtopWidget, sep); n++;
    XtSetArg(args[n], XmNbottomAttachment, XmATTACH_FORM); n++;
    XtSetArg(args[n], XmNrightAttachment, XmATTACH_FORM); n++;
    button = XmCreatePushButton(dialogW, " OK ", args, n);
    XtManageChild(button);
    XtAddCallback(button, XmNactivateCallback, doneCB, (XtPointer)1);
    XtSetArg(args[0], XmNdefaultButton, button);
    XtSetValues(dialogW, args, 1);
    /* Set initial sensitivity: Save All is default */
    XtSetSensitive(transW, False);
    XtSetSensitive(speechW, False);
    XtSetSensitive(logW, False);
}

static void
saveNoneCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    XmToggleButtonCallbackStruct *info = 
	(XmToggleButtonCallbackStruct*)call_data;

    DEBUG0("NONE");
    XtSetSensitive(compressW, !(info->set));
}

static void
saveAllCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    XmToggleButtonCallbackStruct *info = 
	(XmToggleButtonCallbackStruct*)call_data;

    DEBUG0("ALL");
    XtSetSensitive(compressW, info->set);
}

static void
saveSomeCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    XmToggleButtonCallbackStruct *info = 
	(XmToggleButtonCallbackStruct*)call_data;

    DEBUG0("SOME");
    XtSetSensitive(transW, info->set);
    XtSetSensitive(speechW, info->set);
    XtSetSensitive(logW, info->set);
    XtSetSensitive(compressW, info->set);
}

static void
doneCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    int ok = (int)client_data;
    char cmd[MAXPATHLEN];
    Boolean doit;

    DEBUG0("");
    if (ok) {
	if (XmToggleButtonGetState(noneW)) {
	    /* Saving nothing: delete entire directory */
	    sprintf(cmd, "rm %s/*; rmdir %s", saveDir, saveDir);
	    doit = True;
	} else {
	    /* Saving all or some */
	    doit = False;
	    sprintf(cmd, "cd %s; ", saveDir);
	    if (XmToggleButtonGetState(someW)) {
		/* Only saving some: delete the rest */
		strcat(cmd, "rm -f ");
		if (!XmToggleButtonGetState(transW)) {
		    strcat(cmd, "transcript ");
		    doit = True;
		}
		if (!XmToggleButtonGetState(speechW)) {
		    strcat(cmd, "utt* ");
		    doit = True;
		}
		if (!XmToggleButtonGetState(logW)) {
		    strcat(cmd, "*.log ");
		    doit = True;
		}
		strcat(cmd, ";");
	    }
	    /* Do compression (of all or of remaining) */
	    if (XmToggleButtonGetState(compressW)) {
		strcat(cmd, "/usr/staff/bin/gzip *");
		doit = True;
	    }
	}
	if (doit) {
	    DEBUG1("cmd=\"%s\"", cmd);
	    system(cmd);
	}
    }
    /* Unmanage child to pop it down */
    XtUnmanageChild(dialogW);
    DEBUG0("done");
}

static void
emailCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    DEBUG0("");
    popupEmailPanel(saveDir);
    DEBUG0("done");
}
