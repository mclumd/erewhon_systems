/*
 * display.h
 *
 * George Ferguson, ferguson@cs.rochester.edu,  1 Feb 1996
 * Time-stamp: <Sat Nov 16 11:25:33 EST 1996 ferguson>
 */

#ifndef _display_h_gf
#define _display_h_gf

extern void displayInit(int argc, char **argv);
extern void displayEventLoop(void);
extern void displayClose(void);
extern void displayReset(void);
extern void displayClear(void);
extern void displayHideWindow(void);
extern void displayShowWindow(void);
extern void displaySetButton(int on);
extern void displayWords(int who, char **words);
extern void displayUttnum(int uttnum);
extern void displayDone(int uttnum);

typedef enum {
    CLIENT_SPEECH_IN, CLIENT_SPEECH_PP
} XClient;
typedef enum {
    STATUS_RED, STATUS_YELLOW, STATUS_GREEN
} XStatus;
extern void displayShowStatus(XClient who, XStatus what);

extern char *listenTo, *sendTo;

#endif
