/*
 * audio.c : AudioFile version of "standard" audio interface for sphinx_ii
 *
 * George Ferguson, ferguson@cs.rochester.edu, 20 Aug 1996
 * Time-stamp: <96/10/22 15:00:09 ferguson>
 *
 * TODO: -audio passed into ad_init???
 */
#include <stdio.h>
#include <stdlib.h>
#include <AF/AFlib.h>
#include "util/error.h"
#include "util/debug.h"
#include "audio.h"
#include "init.h"

#ifdef DEBUG
#undef DEBUG0
#undef DEBUG1
#undef DEBUG2
#undef DEBUG3
#undef DEBUG4
#define DEBUG0(S) \
	fprintf(stderr,_DFMT S "\n",_DFUNC)
#define DEBUG1(S,A1) \
	fprintf(stderr,_DFMT S "\n",_DFUNC,A1)
#define DEBUG2(S,A1,A2) \
	fprintf(stderr,_DFMT S "\n",_DFUNC,A1,A2)
#define DEBUG3(S,A1,A2,A3) \
	fprintf(stderr,_DFMT S "\n",_DFUNC,A1,A2,A3)
#define DEBUG4(S,A1,A2,A3,A4) \
	fprintf(stderr,_DFMT S "\n",_DFUNC,A1,A2,A3,A4)
#endif
/*
 * Functions defined here:
 */
int ad_init(void);
int ad_start_utt(void);
int ad_finish_utt(void);
int ad_get_samples(short **s, int min);
void ad_pop_samples(int n);
int ad_close(void);

/*
 * Data defined here:
 */
static AFAudioConn *server;
static AC ac;
static ATime lasttime;			/* time of last sample read */
static int recording = 0;		/* TRUE iff currently recording */

/* This is for sphinx's data buffer (see ad_get_samples()) */
#define SAMPLE_SIZE	(sizeof(short))		/* 16-bit samples */
#define AD_BUFSIZE	(16*1024)
static short *samples;		/* raw AD samples buffer */
static int buf_free;		/* first free sample position in buffer */
static int buf_start;		/* first avail. unconsumed sample in buffer */

/*	-	-	-	-	-	-	-	-	*/

int
ad_init(void)
{
    ADevice device = 3;			/* For Asparc, this is mono/both */
    AFSetACAttributes attrs;
    unsigned long attrmask;

    DEBUG1("opening connection to audio server: \"%s\"",
	   audio_server ? audio_server : "<null>");
    /* Open audio server (will look for AUDIOFILE if NULL) */
    if ((server = AFOpenAudioConn(audio_server)) == NULL) {
	ERROR1("couldn't connect to audio server: \"%s\"",
	       audio_server ? audio_server :
	         getenv("AUDIOFILE") ? getenv("AUDIOFILE") : "<null>");
	exit(-1);
    }
    DEBUG0("creating audio context");
    attrmask = 0L;
    ac = AFCreateAC(server, device, attrmask, &attrs);
    AFSync(server, 0);	/* Make sure we confirm encoding type support. */
    /* Allocate sphinx data buffer */
    if ((samples = (short *) calloc(AD_BUFSIZE, SAMPLE_SIZE)) == NULL) {
	SYSERR0("couldn't calloc for samples");
	return -1;
    }
    DEBUG0("done");
    return 0;
}

int
ad_start_utt(void)
{
    lasttime = AFGetTime(ac);
    recording = 1;
    DEBUG0("done");
    return 0;
}

int
ad_finish_utt(void)
{
    recording = 0;
    DEBUG0("done");
    return 0;
}

/*
 * This routine is straight out of Sphinx/src/libad_sun/audio.c. I take
 * no responsability for its disgustingness. -gf
 *
 * Put the available samples (at least min samples) into *s;
 * return the number of samples placed into the buffer;
 * return -1 if "EOF" (after "ad_finish_utt");
 * return -2 on error.
 */
int
ad_get_samples(short **s, int min)
{
    ATime newtime;
    int len;

    DEBUG1("min=%d", min);
    min -= buf_free - buf_start;
    if ((AD_BUFSIZE - buf_free) < min) {
	/* No space left in samples[]; reclaim already consumed space */
	if (buf_start < buf_free) {
	    memcpy(samples,samples+buf_start,(buf_free-buf_start)*SAMPLE_SIZE);
	}
	buf_free -= buf_start;
	buf_start = 0;
    }
    while (min > 0) {
	DEBUG1("trying to read %d bytes", (AD_BUFSIZE-buf_free)*SAMPLE_SIZE);
	newtime = AFRecordSamples(ac, lasttime,
				  (AD_BUFSIZE-buf_free)*SAMPLE_SIZE,
				  (unsigned char*)(samples+buf_free),
				  ANoBlock);
	len = newtime - lasttime;
	DEBUG3("lasttime=%lu, newtime=%lu, len=%d", lasttime, newtime, len);
	if (len <= 0) {
	    break;
	}
	buf_free += len;
	min -= len;
	lasttime = newtime;
    }
    *s = samples + buf_start;
    return (recording || (min <= 0)) ? (buf_free - buf_start) : 0;
}

/*
 * Pop samples off the sample buffer.  These have now been "consumed".
 */
void
ad_pop_samples(int n)
{
    DEBUG1("popping %d samples", n);
    buf_start += n;
}

/*
 * Clean up before exiting
 */
int
ad_close(void)
{
    DEBUG0("closing connection to audio server");
    AFCloseAudioConn(server);
    DEBUG0("done");
    return 0;
}
