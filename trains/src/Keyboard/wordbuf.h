/*
 * wordbuf.h : Incremental word output from the speech recognizer
 *
 * George Ferguson, ferguson@cs.rochester.edu,  9 Feb 1995
 */

#ifndef _wordbuf_h_gf
#define _wordbuf_h_gf

extern void wordbufOutput(char *new, int final);
extern void wordbufReset(void);
extern void wordbufSetBufferLen(int count);

#endif
