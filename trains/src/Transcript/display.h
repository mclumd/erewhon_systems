/*
 * display.h
 *
 * George Ferguson, ferguson@cs.rochester.edu,  5 Mar 1996
 * Time-stamp: <96/10/22 16:12:19 ferguson>
 */

#ifndef _display_h_gf
#define _display_h_gf

extern void displayInit(int *argcp, char **argv);
extern void displayEventLoop(void);
extern void displayClose(void);
extern void displayReset(void);
extern void displayHideWindow(void);
extern void displayShowWindow(void);
extern void displayString(char *s);
extern void displayAndLog(char *s);

extern int writeTranscript;

#endif
