/*
 * input.h
 *
 * George Ferguson, ferguson@cs.rochester.edu, 19 Jan 1996
 * Time-stamp: <96/02/01 09:19:22 ferguson>
 */

#ifndef _input_h_gf
#define _input_h_gf

typedef enum {
    SPEECH_INPUT_BLOCK,
    SPEECH_INPUT_NO_HANG
} SpeechInputFlag;

extern int speechInput(SpeechInputFlag flag);

#endif
