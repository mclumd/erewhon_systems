/*
 * display.h
 *
 * George Ferguson, ferguson@cs.rochester.edu, 23 May 1996
 * Time-stamp: <Tue Nov 12 11:06:57 EST 1996 ferguson>
 */

#ifndef _display_h_gf
#define _display_h_gf

extern void displayInit(int argc, char **argv);
extern void displayEventLoop(void);
extern void displayClose(void);
extern void displayHideWindow(void);
extern void displayShowWindow(void);
extern void displayNewButton(char *label, char *content);
extern void displayEndConversation(void);
extern void displaySetInitialScenario(void);

#endif
