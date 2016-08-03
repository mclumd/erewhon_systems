/*
 * sphinx.h
 *
 * George Ferguson, ferguson@cs.rochester.edu, 31 Jan 1996
 * Time-stamp: <96/02/13 14:26:58 ferguson>
 */

#ifndef _sphinx_h_gf
#define _sphinx_h_gf

extern int ui_init(char *arg);
extern int ui_speaking(void);
extern int ui_update(void);
extern int ui_finish_utt(void);
extern void ui_error(long code);
extern void ui_event_loop(void);
extern void be_init(void);
extern void be_next_utt(void);
extern void be_update(void);

#endif
