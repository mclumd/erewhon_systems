/*
 * utt.c
 *
 * George Ferguson, ferguson@cs.rochester.edu,  6 Mar 1996
 * Time-stamp: <96/08/27 16:29:58 ferguson>
 */
#include <stdio.h>
#include "util/streq.h"
#include "util/memory.h"
#include "util/error.h"
#include "util/debug.h"
#include "utt.h"
#include "display.h"

/*
 * Functions defined here:
 */
void uttStart(char *sender, int uttnum);
void uttWord(char *sender, char *word, int start, int end, int uttnum);
void uttEnd(char *sender, int uttnum);
void uttReset(void);

/*
 * data defined here:
 */
#define MAX_WORDS 256
static char *words[MAX_WORDS];
static int seenSpeechPP = 0;

/*	-	-	-	-	-	-	-	-	*/

void
uttStart(char *sender, int uttnum)
{
    DEBUG1("uttnum=%d", uttnum);
    /* Wipe the word arrays */
    uttReset();
    /* If this is speech-pp, remember it so we ignore speech-in */
    seenSpeechPP = STREQ(sender, "speech-pp");
    DEBUG0("done");
}

/*
 * Note: This currently assumes that if SPEECH-PP is running, that its
 * output always comes after SPEECH_IN's. That's probably not always true,
 * and we should put in a flag that resets words[] at the first word from
 * SPEECH-PP, and subsequently ignores SPEECH-IN for this utt.
 */
void
uttWord(char *sender, char *word, int start, int end, int uttnum)
{
    int i;

    DEBUG4("sender=%s, word=\"%s\", start=%d, end=%d",
	   sender, (word ? word : "<null>"), start, end);
    /* If we've heard from the speech-pp this utt, then ignore others */
    if (seenSpeechPP && !STREQ(sender, "speech-pp")) {
	DEBUG0("ignoring since not from speech-pp");
	return;
    }
    /* Parser indices start at 1 */
    if (start < 1) {
	ERROR1("bad start: %d", start);
	return;
    }
    start -= 1;
    end -= 1;
    if (start >= MAX_WORDS) {
	ERROR1("too many words, start=%d", start);
	start = MAX_WORDS;
    }
    if (end >= MAX_WORDS) {
	ERROR1("too many words, end=%d", end);
	end = MAX_WORDS;
    }
    /* Save given word at starting index */
    if (word == NULL) {
	/* BACKTO */
	for (i=start; words[i] != NULL; i++) {
	    DEBUG1("deleting at index %d", i);
	    gfree(words[i]);
	    words[i] = NULL;
	}
    } else {
	/* New word(s) */
	DEBUG2("saving word \"%s\" at index %d", word, start);
	gfree(words[start]);
	words[start] = gnewstr(word);
	/* Blank out other "positions" occupied by this word */
	for (i=start+1; i < end; i++) {
	    DEBUG1("erasing at index %d", i);
	    gfree(words[i]);
	    words[i] = gnewstr("");
	}
    }
    DEBUG0("done");
}

void
uttEnd(char *sender, int uttnum)
{
    char **w = words;
    char tag[16];
    int i;

    DEBUG1("uttnum=%d", uttnum);
    /* If we've heard from the speech-pp this utt, then ignore others */
    if (seenSpeechPP && !STREQ(sender, "speech-pp")) {
	DEBUG0("ignoring since not from speech-pp");
	return;
    }
    /* Add tag for utterance */
    if (uttnum > 0) {
	sprintf(tag, "USR %03d ", uttnum);
    } else {
	sprintf(tag, "USR txt ");
    }
    displayAndLog(tag);
    /* Add each word of the utterance */
    for (w=words; *w != NULL; w++) {
	/* Don't add tokens like "<SIL>" to transcript (for now) */
	if (**w && **w != '<') {
	    displayAndLog(*w);
	    displayAndLog(" ");
	}
    }
    displayAndLog("\n");
    /* Wipe the word arrays (in case we don't get a START next time) */
    uttReset();
    /* Reset for next utterance */
    seenSpeechPP = 0;
    DEBUG0("done");
}

void
uttReset(void)
{
    int i;

    for (i=0; i < MAX_WORDS; i++) {
	gfree(words[i]);
	words[i] = NULL;
    }
}
