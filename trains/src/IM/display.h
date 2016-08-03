/*
 * display.h
 *
 * George Ferguson, ferguson@cs.rochester.edu, 26 Feb 1996
 * Time-stamp: <96/10/09 14:40:20 ferguson>
 */

#ifndef _display_h_gf
#define _display_h_gf

#include "client.h"
#include "KQML/KQML.h"

extern void displayInit(int argc, char **argv);
extern void displayProcessEvents(void);
extern void displayHideWindow(void);
extern void displayShowWindow(void);
extern void displayDoLayout(void);
extern void displayRedraw(void);
extern void displayStatus(Client *c);
extern void displayMessageRecv(Client *from, KQMLPerformative *perf);
extern void displayMessageSend(Client *to, KQMLPerformative *perf);

#endif
