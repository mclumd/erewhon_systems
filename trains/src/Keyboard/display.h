/*
 * display.h
 *
 * George Ferguson, ferguson@cs.rochester.edu,  1 Feb 1996
 * Time-stamp: <Sat Nov 16 11:13:59 EST 1996 ferguson>
 */

#ifndef _display_h_gf
#define _display_h_gf

extern void displayInit(int argc, char **argv);
extern void displayEventLoop(void);
extern void displayClose(void);
extern void displayReset(void);
extern void displayHideWindow(void);
extern void displayShowWindow(void);
extern void displayGrabKeyboard(void);
extern void displayUngrabKeyboard(void);
extern void displayAddText(char *text);

#endif
