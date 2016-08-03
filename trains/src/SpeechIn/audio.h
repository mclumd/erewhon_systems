/*
 * audio.h
 *
 * George Ferguson, ferguson@cs.rochester.edu, 19 Jan 1996
 * Time-stamp: <96/08/13 14:50:05 ferguson>
 */

#ifndef _audio_h_gf
#define _audio_h_gf

extern int ad_init(void);
extern int ad_start_utt(void);
extern int ad_finish_utt(void);
extern int ad_get_samples(short **s, int min);
extern void ad_pop_samples(int n);
extern int ad_close(void);

#endif
