/*
 * display.c
 *
 * George Ferguson, ferguson@cs.rochester.edu, 26 Jan 1996
 * Time-stamp: <Tue Nov 12 12:02:16 EST 1996 ferguson>
 */
#include <stdio.h>
#include <Xm/Xm.h>
#include <Xm/MainW.h>
#include <Xm/Form.h>
#include <Xm/RowColumn.h>
#include <Xm/LabelG.h>
#include <Xm/Scale.h>
#include <Xm/PushBG.h>
#include <Xm/ToggleBG.h>
#include <Xm/SeparatoG.h>
#include <Xm/Frame.h>
#include <Xm/CascadeB.h>
#include "trlib/input.h"
#include "util/error.h"
#include "util/debug.h"
#include "display.h"
#include "VU.h"
#include "audio.h"
#include "recv.h"

/*
 * Functions defined here:
 */
void displayInit(int argc, char **argv);
void displayEventLoop(void);
void displayClose(void);
void displayHideWindow(void);
void displayShowWindow(void);
void displaySetMeter(AudioDirection dir, int value);
void displaySetLevel(AudioDirection dir, int level);
void displaySetPort(AudioPort port, int state);
void displayEnableMeter(int state);

static void initGraphics(int argc, char **argv);
static void initWidgets(void);
static void initInputMenu(Widget menubar);
static void initOutputMenu(Widget menubar);
static void scaleCB(Widget w, XtPointer client_data, XtPointer call_data);
static void portCB(Widget w, XtPointer client_data, XtPointer call_data);
static void meterCB(Widget w, XtPointer client_data, XtPointer call_data);
static void stdinCB(XtPointer client_data, int *source, XtInputId *id);
static Widget displayCreateLabel(Widget parent, char *label, int width);

/*
 * Data defined here:
 */
XtAppContext appcon;		/* not static - used in audio.c */
static Widget toplevel;
static Widget inL, inLevelW, inMeterW, outL, outMeterW, outLevelW, monLevelW;
static Widget meterW, micW, lineinW, speakerW, phonesW, lineoutW;
static Widget meterButtonW;

/* Resources */
typedef struct _AppResources_s {
    XtOrientation orientation;
    int inputLevel, outputLevel;
    
    Boolean mic, linein, speaker, phones, lineout;
    Boolean meterRunning;
} AppResources;
static AppResources appres;

static XtResource resources[] = {
    { "orientation", "Orientation", XtROrientation, sizeof(XtOrientation),
      XtOffsetOf(AppResources,orientation), XtRImmediate,
	  					(XtPointer)XtorientVertical },
    { "inputLevel", "Level", XtRInt, sizeof(int),
      XtOffsetOf(AppResources,inputLevel), XtRImmediate, (XtPointer)-1 },
    { "outputLevel", "Level", XtRInt, sizeof(int),
      XtOffsetOf(AppResources,outputLevel), XtRImmediate, (XtPointer)-1 },
    { "mic", "Input", XtRBoolean, sizeof(Boolean),
      XtOffsetOf(AppResources,mic), XtRImmediate, (XtPointer)-1 },
    { "linein", "Input", XtRBoolean, sizeof(Boolean),
      XtOffsetOf(AppResources,linein), XtRImmediate, (XtPointer)-1 },
    { "speaker", "Output", XtRBoolean, sizeof(Boolean),
      XtOffsetOf(AppResources,speaker), XtRImmediate, (XtPointer)-1 },
    { "phones", "Output", XtRBoolean, sizeof(Boolean),
      XtOffsetOf(AppResources,phones), XtRImmediate, (XtPointer)-1 },
    { "lineout", "Output", XtRBoolean, sizeof(Boolean),
      XtOffsetOf(AppResources,lineout), XtRImmediate, (XtPointer)-1 },
    { "meterRunning", "MeterRunning", XtRBoolean, sizeof(Boolean),
      XtOffsetOf(AppResources,meterRunning), XtRImmediate, (XtPointer)True },
};
static XrmOptionDescRec options[] = {
    { "-orientation",	".orientation",	XrmoptionSepArg },
    { "-input",		".inputLevel",	XrmoptionSepArg },
    { "-output",	".outputLevel",	XrmoptionSepArg },
    { "-mic",		".mic",		XrmoptionSepArg },
    { "-linein",	".linein",	XrmoptionSepArg },
    { "-speaker",	".speaker",	XrmoptionSepArg },
    { "-phones",	".phones",	XrmoptionSepArg },
    { "-lineout",	".lineout",	XrmoptionSepArg },
    { "-meterRunning",	".meterRunning",XrmoptionSepArg },
};
static String fallbackResources[] = {
    "*title:			TRAINS Audio Manager",
    "*geometry:			-0-0",
    "*background:		grey75",
    "*FontList:			*helvetica-bold-r-*-*-12*",
    "*VU.width:			15",
    "*VU.length:		250",
    "*VU.peakTimeOut:		1000",
    "*Scale.length:		250",
    NULL
};

/*	-	-	-	-	-	-	-	-	*/

void
displayInit(int argc, char **argv)
{
    DEBUG0("initializing display");
    initGraphics(argc, argv);
    initWidgets();
    XtRealizeWidget(toplevel);
    /* Start meter if asked to do so */
    if (appres.meterRunning) {
	displayEnableMeter(1);
    }
    DEBUG0("done");
}

void
displayEventLoop(void)
{
    DEBUG0("initializing audio device from resources");
    /* Don't touch what's not set by user! */
    if (appres.mic == True || appres.mic == False) {
	audioSetPort(AUDIO_INPUT_MIC, appres.mic);
    }
    if (appres.linein == True || appres.linein == False) {
	audioSetPort(AUDIO_INPUT_LINEIN, appres.linein);
    }
    if (appres.speaker == True || appres.speaker == False) {
	audioSetPort(AUDIO_OUTPUT_SPEAKER, appres.speaker);
    }
    if (appres.phones == True || appres.phones == False) {
	audioSetPort(AUDIO_OUTPUT_PHONES, appres.phones);
    }
    if (appres.lineout == True || appres.lineout == False) {
	audioSetPort(AUDIO_OUTPUT_LINEOUT, appres.lineout);
    }
    if (appres.inputLevel != -1) {
	audioSetLevel(AUDIO_INPUT, appres.inputLevel);
    }
    if (appres.outputLevel != -1) {
	audioSetLevel(AUDIO_OUTPUT, appres.outputLevel);
    }
    DEBUG0("initializing widgets from audio device");
    displaySetPort(AUDIO_INPUT_MIC, audioGetPort(AUDIO_INPUT_MIC));
    displaySetPort(AUDIO_INPUT_LINEIN, audioGetPort(AUDIO_INPUT_LINEIN));
    displaySetPort(AUDIO_OUTPUT_SPEAKER, audioGetPort(AUDIO_OUTPUT_SPEAKER));
    displaySetPort(AUDIO_OUTPUT_PHONES, audioGetPort(AUDIO_OUTPUT_PHONES));
    displaySetPort(AUDIO_OUTPUT_LINEOUT, audioGetPort(AUDIO_OUTPUT_LINEOUT));
    displaySetLevel(AUDIO_INPUT, audioGetLevel(AUDIO_INPUT));
    displaySetLevel(AUDIO_OUTPUT, audioGetLevel(AUDIO_OUTPUT));
    DEBUG0("registering stdin");
    /* Register to be called back when input available */
    XtAppAddInput(appcon, 0, (XtPointer)XtInputReadMask, stdinCB, NULL);
    DEBUG0("calling XtAppMainLoop...");
    XtAppMainLoop(appcon);
    DEBUG0("done");
}

void
displayClose(void)
{
    XtDestroyApplicationContext(appcon);
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

void
displaySetMeter(AudioDirection dir, int value)
{
    if (dir == AUDIO_INPUT) {
	VUSetValue(inMeterW, value);
    } else {
#ifdef OUT_METER
	VUSetValue(outMeterW, value);
#endif
    }
}

void
displaySetLevel(AudioDirection dir, int level)
{
    Arg args[1];
    Widget w;

    switch (dir) {
      case AUDIO_INPUT:	  w = inLevelW; break;
      case AUDIO_OUTPUT:  w = outLevelW; break;
    }
    XtSetArg(args[0], XmNvalue, level);
    XtSetValues(w, args, 1);
}

void
displaySetPort(AudioPort port, int state)
{
    Widget w;

    switch (port) {
      case AUDIO_INPUT_MIC:
	w = micW; break;
      case AUDIO_INPUT_LINEIN:
	w = lineinW; break;
      case AUDIO_OUTPUT_SPEAKER:
	w = speakerW; break;
      case AUDIO_OUTPUT_PHONES:
	w = phonesW; break;
      case AUDIO_OUTPUT_LINEOUT:
	w = lineoutW; break;
    }
    XmToggleButtonGadgetSetState(w, state ? True : False, True);
}

void
displayEnableMeter(int state)
{
    XmString labstr;

    DEBUG1("state=%d", state);
    audioSetMeter(state);
    XtSetSensitive(inMeterW, state ? True : False);
    if (state) {
	labstr = XmStringCreate("Meter Off", XmSTRING_DEFAULT_CHARSET);
    } else {
	labstr = XmStringCreate("Meter On", XmSTRING_DEFAULT_CHARSET);
    }
    XtVaSetValues(meterButtonW, XmNlabelString, labstr, NULL);
    XmStringFree(labstr);
    DEBUG0("done");
}

/*	-	-	-	-	-	-	-	-	*/

static void
initGraphics(int argc, char **argv)
{
    toplevel = XtVaAppInitialize(&appcon, "TRAINS",
				 options, XtNumber(options),
				 &argc, argv, fallbackResources,
				 NULL);
    XtGetApplicationResources(toplevel, (XtPointer)&appres,
			      resources, XtNumber(resources), NULL, 0);
}

/*	-	-	-	-	-	-	-	-	*/
/*
 * Widgets
 */
static void
initWidgets(void)
{
    Widget mainW, menubarW, panel, frame;
    Arg args[3];
    int n;

    /* Main window */
    n = 0;
    XtSetArg(args[n], XmNshowSeparator, True); n++;
    mainW = XmCreateMainWindow(toplevel, "main", args, n);
    XtManageChild(mainW);
    /* Menu bar */
    n = 0;
    XtSetArg(args[n], XmNmarginHeight, 0); n++;
    XtSetArg(args[n], XmNmarginWidth, 0); n++;
    XtSetArg(args[n], XmNshadowThickness, 0); n++;
    menubarW = XmCreateMenuBar(mainW, "menubar", args, n);
    XtManageChild(menubarW);
    initInputMenu(menubarW);
    initOutputMenu(menubarW);
    /* Main Panel RC is horizontal */
    n = 0;
    XtSetArg(args[n], XmNorientation, XmHORIZONTAL); n++;
    panel = XmCreateWorkArea(mainW, "panel", args, n);
    XtManageChild(panel);
    /* Input level */
    n = 0;
    XtSetArg(args[n], XmNorientation, XmVERTICAL); n++;
    inLevelW = XmCreateScale(panel, "inLevel", args, n);
    XtManageChild(inLevelW);
    XtAddCallback(inLevelW, XmNvalueChangedCallback,
		  scaleCB, (XtPointer)AUDIO_INPUT);
    /* Input meter */
    frame = XmCreateFrame(panel, "frame", NULL, 0);
    XtManageChild(frame);
    n = 0;
    XtSetArg(args[n], XtNorientation, XtorientVertical); n++;
    inMeterW = XtCreateWidget("inMeter", vuWidgetClass, frame, args, n);
    XtManageChild(inMeterW);
    /* Separator */
    n = 0;
    XtSetArg(args[n], XmNorientation, XmVERTICAL); n++;
    XtSetArg(args[n], XmNseparatorType, XmSHADOW_ETCHED_OUT); n++;
    XtManageChild(XmCreateSeparatorGadget(panel, "sep", args, n));
    /* Horizontal spacer */
    n = 0;
    XtSetArg(args[n], XmNorientation, XmVERTICAL); n++;
    XtSetArg(args[n], XmNseparatorType, XmNO_LINE); n++;
    XtSetArg(args[n], XmNwidth, 10); n++;
    XtManageChild(XmCreateSeparatorGadget(panel, "sep", args, n));
    /* Output level */
    n = 0;
    XtSetArg(args[n], XmNorientation, XmVERTICAL); n++;
    outLevelW = XmCreateScale(panel, "outLevel", args, n);
    XtManageChild(outLevelW);
    XtAddCallback(outLevelW, XmNvalueChangedCallback,
		  scaleCB, (XtPointer)AUDIO_OUTPUT);
    /* Set children of main window */
    XmMainWindowSetAreas(mainW, menubarW, NULL, NULL, NULL, panel);
}

static void
initInputMenu(Widget menubar)
{
    Widget menu, button;
    unsigned char *labstr;
    Arg args[3];
    int n;

    /* Input menu */
    n = 0;
    XtSetArg(args[n], XmNradioBehavior, True); n++;
    menu = XmCreatePulldownMenu(menubar, "input", args, n);
    /* Meter (off by default) */
    labstr = XmStringCreate("Meter On", XmSTRING_DEFAULT_CHARSET);
    n = 0;
    XtSetArg(args[n], XmNlabelString, labstr); n++;
    meterButtonW = XmCreatePushButtonGadget(menu, "meter", args, n);
    XtManageChild(meterButtonW);
    XtAddCallback(meterButtonW, XmNactivateCallback, meterCB, NULL);
    XmStringFree(labstr);
    /* Mic */
    labstr = XmStringCreate("Microphone", XmSTRING_DEFAULT_CHARSET);
    n = 0;
    XtSetArg(args[n], XmNlabelString, labstr); n++;
    XtSetArg(args[n], XmNmnemonic, 'M'); n++;
    micW = XmCreateToggleButtonGadget(menu, "mic", args, n);
    XtManageChild(micW);
    XtAddCallback(micW, XmNvalueChangedCallback,
		  portCB, (XtPointer)AUDIO_INPUT_MIC);
    XmStringFree(labstr);
    /* LineIn */
    labstr = XmStringCreate("Line In", XmSTRING_DEFAULT_CHARSET);
    n = 0;
    XtSetArg(args[n], XmNlabelString, labstr); n++;
    XtSetArg(args[n], XmNmnemonic, 'L'); n++;
    lineinW = XmCreateToggleButtonGadget(menu, "linein", args, n);
    XtManageChild(lineinW);
    XtAddCallback(lineinW, XmNvalueChangedCallback,
		  portCB, (XtPointer)AUDIO_INPUT_LINEIN);
    XmStringFree(labstr);
    /* Add to menubar */
    labstr = XmStringCreate("Input", XmSTRING_DEFAULT_CHARSET);
    n = 0;
    XtSetArg(args[n], XmNlabelString, labstr); n++;
    XtSetArg(args[n], XmNmnemonic, 'I'); n++;
    XtSetArg(args[n], XmNsubMenuId, menu); n++;
    button = XmCreateCascadeButton(menubar, "input", args, n);
    XtManageChild(button);
    XmStringFree(labstr);
}

static void
initOutputMenu(Widget menubar)
{
    Widget menu, button;
    unsigned char *labstr;
    Arg args[3];
    int n;

    /* Output menu */
    menu = XmCreatePulldownMenu(menubar, "output", NULL, 0);
    /* Speaker */
    labstr = XmStringCreate("Speaker", XmSTRING_DEFAULT_CHARSET);
    n = 0;
    XtSetArg(args[n], XmNlabelString, labstr); n++;
    XtSetArg(args[n], XmNmnemonic, 'S'); n++;
    speakerW = XmCreateToggleButtonGadget(menu, "speaker", args, n);
    XtManageChild(speakerW);
    XtAddCallback(speakerW, XmNvalueChangedCallback,
		  portCB, (XtPointer)AUDIO_OUTPUT_SPEAKER);
    XmStringFree(labstr);
    /* Phones */
    labstr = XmStringCreate("Headphones", XmSTRING_DEFAULT_CHARSET);
    n = 0;
    XtSetArg(args[n], XmNlabelString, labstr); n++;
    XtSetArg(args[n], XmNmnemonic, 'H'); n++;
    phonesW = XmCreateToggleButtonGadget(menu, "phones", args, n);
    XtManageChild(phonesW);
    XtAddCallback(phonesW, XmNvalueChangedCallback,
		  portCB, (XtPointer)AUDIO_OUTPUT_PHONES);
    XmStringFree(labstr);
    /* LineOut */
    labstr = XmStringCreate("Line Out", XmSTRING_DEFAULT_CHARSET);
    n = 0;
    XtSetArg(args[n], XmNlabelString, labstr); n++;
    XtSetArg(args[n], XmNmnemonic, 'L'); n++;
    lineoutW = XmCreateToggleButtonGadget(menu, "lineout", args, n);
    XtManageChild(lineoutW);
    XtAddCallback(lineoutW, XmNvalueChangedCallback,
		  portCB, (XtPointer)AUDIO_OUTPUT_LINEOUT);
    XmStringFree(labstr);
    /* Add to menubar */
    labstr = XmStringCreate("Output", XmSTRING_DEFAULT_CHARSET);
    n = 0;
    XtSetArg(args[n], XmNlabelString, labstr); n++;
    XtSetArg(args[n], XmNmnemonic, 'O'); n++;
    XtSetArg(args[n], XmNsubMenuId, menu); n++;
    button = XmCreateCascadeButton(menubar, "output", args, n);
    XtManageChild(button);
    XmStringFree(labstr);
}

static void
scaleCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    XmScaleCallbackStruct *info = (XmScaleCallbackStruct*)call_data;
    int value = info->value;
    AudioDirection dir = (AudioDirection)client_data;

    DEBUG1("value=%d", value);
    audioSetLevel(dir, value);
    DEBUG0("done");
}

static void
portCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    AudioPort port = (AudioPort)client_data;
    XmToggleButtonCallbackStruct *info =
	(XmToggleButtonCallbackStruct*)call_data;
    int state = (int)(info->set);

    DEBUG3("name=%s, port=%d, state=%d", XtName(w), port, state);
    audioSetPort(port, state);
    DEBUG0("done");
}

static void
meterCB(Widget w, XtPointer client_data, XtPointer call_data)
{
    int state = (int)client_data;

    displayEnableMeter(state);
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

/*	-	-	-	-	-	-	-	-	*/

static Widget
displayCreateLabel(Widget parent, char *label, int width)
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

/*	-	-	-	-	-	-	-	-	*/
/*
 * Grotty, but necessary to avoid getting a 5 sec. pause when the
 * keyboard manager has the keyboard focus. The real version of this
 * function tries 5 times with 1 sec pauses to grab the keyboard,
 * then reports and error if it fails. We do neither. Ha!
 * The linker doesn't let us do this under 4.1.3...
 */
#ifdef SOLARIS
int
_XmGrabKeyboard(Widget widget, Bool owner_events, int pointer_mode,
		int keyboard_mode, Time time)
{
    return XtGrabKeyboard(widget, owner_events,
			  pointer_mode, keyboard_mode, time);
}
#endif
