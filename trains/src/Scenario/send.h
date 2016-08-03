/*
 * send.h
 *
 * George Ferguson, ferguson@cs.rochester.edu, 23 May 1996
 * Time-stamp: <Tue Nov 12 11:05:29 EST 1996 ferguson>
 */

#ifndef _send_h_gf
#define _send_h_gf

extern void sendReadyMsg(void);
extern void sendUnmonitorMsg(void);
extern void sendRequestToDM(char *content);

#endif
