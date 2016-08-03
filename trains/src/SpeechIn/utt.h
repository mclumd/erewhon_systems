/*
 * utt.h
 *
 * George Ferguson, ferguson@cs.rochester.edu, 31 Jan 1996
 * Time-stamp: <96/05/21 14:56:47 ringger>
 */

#ifndef _utt_h_gf
#define _utt_h_gf

extern void uttStart(void);
extern void uttStop(void);

/* ringger - changed uttUpdate() & uttDone() functions to provide more info. */
extern void uttUpdate(char *result, int *h_sfrm, int *h_efrm, int *h_ascr_norm, int frame);
extern void uttDone(char *result, int *h_sfrm, int *h_efrm, int *h_ascr_norm);

extern void uttReset(void);
extern void uttChdir(char *dir);
extern char *gf_next_output_filename(void);

extern int speaking;

#endif
