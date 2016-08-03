/*
 * display.h
 *
 * George Ferguson, ferguson@cs.rochester.edu,  5 Feb 1996
 * Time-stamp: <96/04/04 18:15:35 ferguson>
 */

#ifndef _display_h_gf
#define _display_h_gf

extern void displayInit(int argc, char **argv);
extern void displayEventLoop(void);
extern void displayExit(void);
extern void displayHideWindow(void);
extern void displayShowWindow(void);

#endif
