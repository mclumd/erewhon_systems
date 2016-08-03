/*
 * display.h
 *
 * George Ferguson, ferguson@cs.rochester.edu, 26 Jan 1996
 * Time-stamp: <Tue Nov 12 12:00:49 EST 1996 ferguson>
 */

#ifndef _display_h_gf
#define _display_h_gf

#include "audio.h"

extern void displayInit(int argc, char **argv);
extern void displayEventLoop(void);
extern void displayClose(void);
extern void displayHideWindow(void);
extern void displayShowWindow(void);
extern void displaySetMeter(AudioDirection dir, int value);
extern void displaySetLevel(AudioDirection dir, int level);
extern void displaySetPort(AudioPort port, int state);
extern void displayEnableMeter(int state);

#endif
