/*
 * log.h
 *
 * George Ferguson, ferguson@cs.rochester.edu,  9 Jan 1996
 * Time-stamp: <96/07/30 17:03:50 ferguson>
 */

#ifndef _log_h_gf
#define _log_h_gf

extern void openLog(void);
extern void logInput(int fd, char *txt);
extern void logOutput(int fd, char *txt, int len);
extern void logGarbage(int fd, char *txt, char *errtxt);
extern void logChdir(char *dir);

#endif
