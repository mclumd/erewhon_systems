/*
 * audio.c : AudioFile version of audio driver
 *
 * George Ferguson, ferguson@cs.rochester.edu,  7 Aug 1996
 * Time-stamp: <Tue Nov 12 11:53:13 EST 1996 ferguson>
 */
#include <stdio.h>
#include <stdlib.h>
#include <X11/Intrinsic.h>
#include <AF/AFlib.h>
#include "util/error.h"
#include "util/debug.h"
#include "audio.h"
#include "display.h"
extern XtAppContext appcon;

/*
 * Functions defined here:
 */
int audioInit(char *name);
void audioSetMeter(int state);
void audioSetLevel(AudioDirection dir, int level);
void audioSetPort(AudioPort port, int state);
static void audioSetInputPort(AudioPort port, int state);
static void audioSetOutputPort(AudioPort port, int state);
int audioGetLevel(AudioDirection dir);
int audioGetPort(AudioPort port);
static void meterCB(XtPointer client_data, XtIntervalId *timer);

/*
 * Data defined here:
 */
static AFAudioConn *server;
static AC ac;
static int inputMin, inputMax, outputMin, outputMax;	/* Gains */
XtIntervalId meterTimeOut;

/*	-	-	-	-	-	-	-	-	*/

int
audioInit(char *name)
{
    ADevice device = 3;			/* For Asparc, this is mono/both */
    AFSetACAttributes attrs;
    unsigned long attrmask;

    DEBUG1("opening connection to audio server: \"%s\"",
	   name ? name : "<null>");
    /* Open audio server (will look for AUDIOFILE if NULL) */
    if ((server = AFOpenAudioConn(name)) == NULL) {
	ERROR1("couldn't connect to audio server: \"%s\"",
	       name ? name :
	         getenv("AUDIOFILE") ? getenv("AUDIOFILE") : "<null>");
	exit(-1);
    }
    DEBUG0("creating audio context");
    attrmask = 0L;
    ac = AFCreateAC(server, device, attrmask, &attrs);
    AFSync(server, 0);	/* Make sure we confirm encoding type support. */
    /* Get a few attributes of the device that don't change */
    AFQueryInputGain(ac, &inputMin, &inputMax);
    AFQueryOutputGain(ac, &outputMin, &outputMax);
    DEBUG0("done");
    return 0;
}

void
audioClose(void)
{
    DEBUG0("closing connection to audio server");
    AFCloseAudioConn(server);
    DEBUG0("done");
}

#define NUM_SAMPLES 256
#define SAMPLE_SIZE sizeof(short)

static void
meterCB(XtPointer client_data, XtIntervalId *timer)
{
    static short buf[NUM_SAMPLES];
    ATime start, end;
    int len, sum, num, value, i;

    start = AFGetTime(ac) - NUM_SAMPLES;
    end = AFRecordSamples(ac, start,
			   NUM_SAMPLES*SAMPLE_SIZE, (unsigned char*)buf,
			   ANoBlock);
    len = end - start;
    DEBUG1("read %d samples from audio server", len);
    if (len > 0) {
	sum = num = 0;
	for (i=0; i < len; i += 16) {
	    /* Running total of absolute value */
	    sum += buf[i] < 0 ? -buf[i] : buf[i];
	    num += 1;
	}
	/* Average value scaled for meter */
	value = sum / num / 128;
	DEBUG1("value=%d", value);
	displaySetMeter(AUDIO_INPUT, value);
    }
    /* Reschedule (timeout in millisecs) */
    meterTimeOut = XtAppAddTimeOut(appcon, (unsigned long)50, meterCB, NULL);
}

/*	-	-	-	-	-	-	-	-	*/

void
audioSetMeter(int state)
{
    static int currentState = 0;
    DEBUG1("meter state=%d", state);
    if (state != currentState) {
	if (state) {
	    meterTimeOut =
		XtAppAddTimeOut(appcon, (unsigned long)100, meterCB, NULL);
	} else {
	    XtRemoveTimeOut(meterTimeOut);
	}
	currentState = state;
    }
    DEBUG0("done");
    
}

/*
 * Levels are 0-100
 */
void
audioSetLevel(AudioDirection dir, int level)
{
    DEBUG2("dir=%d, level=%d", dir, level);
    switch (dir) {
      case AUDIO_INPUT:
	level = inputMin + (int)(((float)level/100) * (inputMax - inputMin));
	DEBUG1("setting input level=%d", level);
	AFSetInputGain(ac, level);
	AFSync(server, 0);
	break;
      case AUDIO_OUTPUT:
	level = outputMin + (int)(((float)level/100) * (outputMax-outputMin));
	DEBUG1("setting output level=%d", level);
	AFSetOutputGain(ac, level);
	AFSync(server, 0);
	break;
      case AUDIO_MONITOR:
	DEBUG0("not implemented");
	break;
    }
    DEBUG0("done");
}

int
audioGetLevel(AudioDirection dir)
{
    int level, min, max;

    DEBUG1("dir=%d", dir);
    switch (dir) {
      case AUDIO_INPUT:
	AFSync(server, 0);
	level = AFQueryInputGain(ac, &min, &max);
	break;
      case AUDIO_OUTPUT:
	AFSync(server, 0);
	level = AFQueryOutputGain(ac, &min, &max);
	break;
      case AUDIO_MONITOR:
	DEBUG0("not implemented");
	return 0;
    }
    level = (int)((float)(level - min) / (max - min) * 100);
    DEBUG1("done, level=%d", level);
    return level;
}

/*	-	-	-	-	-	-	-	-	*/
/*
 * Input ports are exclusive, output ports inclusive.
 */
void
audioSetPort(AudioPort port, int state)
{
    DEBUG2("port=%d, state=%d", port, state);
    switch (port) {
      case AUDIO_INPUT_MIC:
      case AUDIO_INPUT_LINEIN:
	audioSetInputPort(port, state);
	break;
      case AUDIO_OUTPUT_SPEAKER:
      case AUDIO_OUTPUT_PHONES:
      case AUDIO_OUTPUT_LINEOUT:
	audioSetOutputPort(port, state);
	break;
    }
    DEBUG0("done");
}

static void
audioSetInputPort(AudioPort port, int state)
{
    AMask mask, old, new;

    DEBUG2("port=%d, state=%d", port, state);
    switch (port) {
      case AUDIO_INPUT_MIC:
	mask = 1 << 0;
	break;
      case AUDIO_INPUT_LINEIN:
	mask = 1 << 1;
	break;
    }
    if (state) {
	AFEnableInput(ac, mask, &old, &new);
    } else {
	AFDisableInput(ac, mask, &old, &new);
    }
    DEBUG0("done");
}

static void
audioSetOutputPort(AudioPort port, int state)
{
    AMask mask, old, new;

    DEBUG2("port=%d, state=%d", port, state);
    switch (port) {
      case AUDIO_OUTPUT_SPEAKER:
	mask = 1 << 0;
	break;
      case AUDIO_OUTPUT_PHONES:
	mask = 1 << 1;
	break;
      case AUDIO_OUTPUT_LINEOUT:
	mask = 1 << 2;
	break;
    }
    if (state) {
	AFEnableOutput(ac, mask, &old, &new);
    } else {
	AFDisableOutput(ac, mask, &old, &new);
    }
    DEBUG0("done");
}

int
audioGetPort(AudioPort port)
{
    AMask old, new;
    int state;

    DEBUG1("port=%d", port);
    switch (port) {
      case AUDIO_INPUT_MIC:
      case AUDIO_INPUT_LINEIN:
	AFEnableInput(ac, (AMask)0, &old, &new);
	break;
      case AUDIO_OUTPUT_SPEAKER:
      case AUDIO_OUTPUT_PHONES:
      case AUDIO_OUTPUT_LINEOUT:
	AFEnableOutput(ac, (AMask)0, &old, &new);
	break;
    }
    switch (port) {
      case AUDIO_INPUT_MIC:
	  state = old & (1 << 0); break;
      case AUDIO_INPUT_LINEIN:
	  state = old & (1 << 1); break;
      case AUDIO_OUTPUT_SPEAKER:
	  state = old & (1 << 0); break;
      case AUDIO_OUTPUT_PHONES:
	  state = old & (1 << 1); break;
      case AUDIO_OUTPUT_LINEOUT:
	  state = old & (1 << 2); break;
    }
    DEBUG1("done, state=%d", state);
    return state;
}
