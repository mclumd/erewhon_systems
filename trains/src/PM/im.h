/*
 * im.h
 *
 * George Ferguson, ferguson@cs.rochester.edu, 11 Dec 1995
 * Time-stamp: <96/04/05 14:53:22 ferguson>
 */

#ifndef _im_h_gf
#define _im_h_gf

extern int setIMAddr(char *hostname, int port);
extern char *getIMAddr(void);
extern int openIMSocket(void);

#define IM_DEFAULT_PORT 6200

#endif
