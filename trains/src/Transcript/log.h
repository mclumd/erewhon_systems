/*
 * log.h
 *
 * George Ferguson, ferguson@cs.rochester.edu,  6 Mar 1996
 * Time-stamp: <96/03/07 14:38:07 ferguson>
 */

#ifndef _log_h_gf
#define _log_h_gf

extern void logOpen(void);
extern void logClose(void);
extern void logString(char *s);
extern void logChdir(char *dir);

#endif
