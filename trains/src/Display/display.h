/*
 * display.h : Functions for modules that don't need to know about X
 *
 * George Ferguson, ferguson@cs.rochester.edu, 21 Dec 1994
 * Time-stamp: <96/04/11 13:34:32 ferguson>
 */

#ifndef _display_h_gf
#define _display_h_gf

extern void displayInit(int *argcp, char **argv);
extern void displayReadMapFile(void);
extern void displayEventLoop(void);
extern void displayClose(void);
extern void displayRedraw(void);
extern void displayRestart(void);
extern void displaySay(char *str);
extern void displaySetCanvas(char *name, int width, int height, char *bgfile);
extern void displayGetCanvasAttrs(char **name, int *widthp, int *heightp,
				  int *xdpip, int *ydpip);
extern void displayFlushText(void);

typedef unsigned long TimerId;
typedef void (*TimerCallbackProc)(void *data, TimerId *id);
extern TimerId displayStartTimer(unsigned long millisecs,
				 TimerCallbackProc proc, void *data);
extern void displayStopTimer(TimerId id);

extern void displayHideWindow(void);
extern void displayUnhideWindow(void);

#endif
