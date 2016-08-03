/*
 * wordbuf.h
 *
 * George Ferguson, ferguson@cs.rochester.edu, 19 Jan 1996
 * Time-stamp: <96/05/21 14:56:47 ringger>
 */

#ifndef _wordbuf_h_gf
#define _wordbuf_h_gf

/* ringger - changed wordbufOutput function to provide more info. */
extern void wordbufOutput(char *str, int *h_sfrm, int *h_efrm, int *h_ascr_norm, int uttnum, int final);

extern void wordbufSetBufferLen(int len);
extern void wordbufReset(void);

#endif
