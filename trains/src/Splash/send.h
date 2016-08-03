/*
 * send.h
 *
 * George Ferguson, ferguson@cs.rochester.edu,  8 Feb 1996
 * Time-stamp: <Thu Nov 14 17:06:37 EST 1996 ferguson>
 */

#ifndef _send_h_gf
#define _send_h_gf

extern void sendReadyMsg(void);
extern void sendChdirMsg(char *dir);
extern void sendPracticeMsg(void);
extern void sendStartMsg(char *name, char *lang, char *sex,
			 char *intro, char *goals, char *scoring);
extern void sendIMExitMsg(void);

#endif
