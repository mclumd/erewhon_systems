/*
 * sphinx.c : Link between SphinxII and TRAINS interface
 *
 * George Ferguson, ferguson@cs.rochester.edu, 16 Jan 1995.
 *
 * The functions provided here are all required by Sphinx. They basically
 * provide the link between Sphinx and the more complicated routines
 * in utt.c and sp_input.c.
 */
#include <stdio.h>
#include "sphinx.h"
#include "init.h"
#include "input.h"
#include "utt.h"

/*
 * Functions from Sphinx
 */

/* ringger - changed search_*result() functions to provide more info. */
extern void search_partial_result(char **h_str, int **h_sfrm, int **h_efrm, int **h_ascr_norm);
extern void search_result(char **h_str, int **h_sfrm, int **h_efrm, int **h_ascr_norm);

extern int searchCurrentFrame(void);

/*
 * Functions defined here:
 */
int ui_init(char *arg);
int ui_speaking(void);
int ui_update(void);
int ui_finish_utt(void);
void ui_error(long code);
void ui_event_loop(void);
void be_init(void);
void be_next_utt(void);
void be_update(void);

/*	-	-	-	-	-	-	-	-	*/

int
ui_init(char *arg)
{
    initialize(arg);
    return 0;
}

/* should return 1 if the user wishes to speak and
   0 otherwise.  This is called "continuously" after
   the user signals that he or she wants to speak */

#define UI_SPEAKING_INTERVAL 10

int
ui_speaking(void)
{
    static count = 0;

    /* Every so often, check the input for a message (maybe "stop") */
    if (++count % UI_SPEAKING_INTERVAL == 0) {
	if (input(SPEECH_INPUT_NO_HANG) < 0) {
	    exit(-2);
	}
    }
    /* Then tell Sphinx whether we're still going or not */
    return speaking;
}

/* This called after every frame is sent to the decoder.
   This could be used to update some status information
   on the user's screen. */

#define UI_UPDATE_INTERVAL 25

int
ui_update(void)
{
    static count = 0;
    /* ringger - more info. */
    char *h_str;
    int *h_sfrm;
    int *h_efrm;
    int *h_ascr_norm;

    /* Every so often, update the display */
    if (++count % UI_UPDATE_INTERVAL == 0) {
        search_partial_result(&h_str, &h_sfrm, &h_efrm, &h_ascr_norm);
	uttUpdate(h_str, h_sfrm, h_efrm, h_ascr_norm, searchCurrentFrame());
    }

    return 0;
}

int
ui_finish_utt(void)
{
    /* ringger - more info. */
    char *h_str;
    int *h_sfrm;
    int *h_efrm;
    int *h_ascr_norm;

    search_result(&h_str, &h_sfrm, &h_efrm, &h_ascr_norm);
    uttDone(h_str, h_sfrm, h_efrm, h_ascr_norm);

    return 0;
}

void
ui_error(long code)
{
    /* This is never actually used by sphinx, which just dribbles to
     * stdout or stderr or wherever it wants to.
     */
}

/* this is called after the decoder is initialized */
void
ui_event_loop(void)
{
    int ret;

    /* Wait for a message to arrive and start the processing */
    while ((ret = input(SPEECH_INPUT_BLOCK)) > 0) {
	/*EMPTY*/
    }
    exit(ret);
}

/*	-	-	-	-	-	-	-	-	*/
/*
 * Although these functions are supposed to support a "back end", in
 * fact they are not really used properly. Furthermore, there is no
 * be_finish_utt() to be called at the end of an utterance. So that
 * means we have to use ui_finish_utt(), so we just do it all in there.
 * I also don't think be_update() is ever called...
 */

/*
 * One time initialization
 */
void
be_init(void)
{
}

/*
 * At the end of each utt.
 */
void
be_next_utt(void)
{
}

/*
 * Within an utt, whenver a new partial decoded output is available
 */
void be_update (void)
{
    /* Handled by display, nothing to do here. */
}
