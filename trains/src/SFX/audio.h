/*
 * audio.h
 *
 * George Ferguson, ferguson@cs.rochester.edu,  5 Aug 1996
 * Time-stamp: <96/08/14 12:59:11 ferguson>
 */

#ifndef _audio_h_gf
#define _audio_h_gf

extern int audioInit(char *name);
extern void audioWrite(char *bytes, int num_bytes);
extern void audioSync(void);

#endif
