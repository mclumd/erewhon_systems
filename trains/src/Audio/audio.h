/*
 * audio.h
 *
 * George Ferguson, ferguson@cs.rochester.edu,  6 Aug 1996
 * Time-stamp: <96/08/19 12:01:19 ferguson>
 */

#ifndef _audio_h_gf
#define _audio_h_gf

typedef enum {
    AUDIO_INPUT, AUDIO_OUTPUT, AUDIO_MONITOR
} AudioDirection;

typedef enum {
    AUDIO_INPUT_MIC, AUDIO_INPUT_LINEIN,
    AUDIO_OUTPUT_SPEAKER, AUDIO_OUTPUT_PHONES, AUDIO_OUTPUT_LINEOUT
} AudioPort;

extern int audioInit(char *name);
extern void audioSetMeter(int state);
extern void audioSetLevel(AudioDirection dir, int level);
extern void audioSetPort(AudioPort port, int state);
extern int audioGetLevel(AudioDirection dir);
extern int audioGetPort(AudioPort port);

#endif
