/*
 * send.h
 *
 * George Ferguson, ferguson@cs.rochester.edu, 17 Jul 1996
 * Time-stamp: <96/10/08 14:04:20 ferguson>
 */

#ifndef _send_h_gf
#define _send_h_gf

extern void sendReadyMsg(void);
extern void sendSpeechMsg(char *content);
extern void sendMsg(char *content);

#endif
