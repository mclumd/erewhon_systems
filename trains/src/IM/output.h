/*
 * output.h
 *
 * George Ferguson, ferguson@cs.rochester.edu,  7 Apr 1995
 * Time-stamp: <96/07/30 17:05:57 ferguson>
 */

#ifndef _output_h_gf
#define _output_h_gf

extern void output(int fd, char *msg, int msglen);
extern void outputCallback(int fd);
extern void outputFlush(int fd);

#endif
