/*
 * utt.h
 *
 * George Ferguson, ferguson@cs.rochester.edu,  7 Mar 1996
 * Time-stamp: <96/03/08 11:29:30 ferguson>
 */

#ifndef _utt_h_gf
#define _utt_h_gf

extern void uttStart(char *sender, int uttnum);
extern void uttWord(char *sender, char *word, int start, int end, int uttnum);
extern void uttEnd(char *sender, int uttnum);
extern void uttReset(void);

#endif
