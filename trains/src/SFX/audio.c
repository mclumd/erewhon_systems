/*
 * audio.c: AudioFile version of the audio driver
 *
 * George Ferguson, ferguson@cs.rochester.edu, 20 Aug 1996
 * Time-stamp: <96/10/22 14:45:05 ferguson>
 */
#include <stdio.h>
#include <stdlib.h>
#include <AF/AFlib.h>
#include "util/error.h"
#include "util/debug.h"
#include "audio.h"

/*
 * Functions defined here:
 */
int audioInit(char *name);
void audioWrite(char *bytes, int num_bytes);
void audioSync(void);

/*
 * Data defined here:
 */
static AFAudioConn *server;
static AC ac;
static ATime starttime;			/* time last utt started */
static int numsent = 0;			/* samples sent to server */

/*	-	-	-	-	-	-	-	-	*/

int
audioInit(char *name)
{
    ADevice device = 3;			/* For Asparc, this is mono/both */
    AFSetACAttributes attrs;
    unsigned long attrmask;

    DEBUG0("opening connection to audio server");
    /* Open audio server (will look for AUDIOFILE if NULL) */
    if ((server = AFOpenAudioConn(name)) == NULL) {
	ERROR1("couldn't connect to audio server: \"%s\"",
	       name ? name :
	         getenv("AUDIOFILE") ? getenv("AUDIOFILE") : "<null>");
	return -1;
    }
    DEBUG0("creating audio context");
    attrmask = 0L;
    ac = AFCreateAC(server, device, attrmask, &attrs);
    AFSync(server, 0);	/* Make sure we confirm encoding type support. */
    DEBUG0("done");
}

void
audioClose(void)
{
    DEBUG0("closing connection to audio server");
    AFCloseAudioConn(server);
    DEBUG0("done");
}

/*
 * This adds data to the buffer waiting to go to the audio server.
 */
void
audioWrite(char *bytes, int num_bytes)
{
    DEBUG1("sending %d bytes to audio server", num_bytes);
    /* If we're starting an utt, get the server timestamp */
    if (numsent == 0) {
	starttime = AFGetTime(ac);
    }
    /* Send data to server */
    AFPlaySamples(ac, starttime+numsent, num_bytes, bytes);
    /* Increment sample counter */
    numsent += num_bytes/2;
    DEBUG1("done, numsent=%d", numsent);
}

void
audioSync(void)
{
    DEBUG1("syncing to time %lu", starttime+numsent);
    while (AFGetTime(ac) < starttime+numsent) {
	usleep(20000);
    }
    numsent = 0;
    DEBUG0("done");
}
