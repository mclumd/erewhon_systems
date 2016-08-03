/*
 * display.h
 *
 * George Ferguson, ferguson@cs.rochester.edu, 22 Mar 1996
 * Time-stamp: <96/08/16 11:01:05 ferguson>
 */

#ifndef _display_h_gf
#define _display_h_gf

extern void displayInit(int argc, char **argv);
extern void displayEventLoop(void);
extern void displayClose(void);
extern void displayHideWindow(void);
extern void displayShowWindow(void);
extern void displayNewMessage(char *label, char *content);
extern void displayReplaceMessage(int num, char *label, char *content);

#endif
