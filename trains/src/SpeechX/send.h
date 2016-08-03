/*
 * send.h
 *
 * George Ferguson, ferguson@cs.rochester.edu,  1 Feb 1996
 * Time-stamp: <96/03/25 11:40:24 ferguson>
 */

#ifndef _send_h_gf
#define _send_h_gf

extern void sendReadyMsg(void);
extern void sendStartMsg(void);
extern void sendStopMsg(void);
extern void sendOfflineMsg(int state);

#endif
