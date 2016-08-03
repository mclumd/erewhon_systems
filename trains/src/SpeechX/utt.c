/*
 * utt.c
 *
 * George Ferguson, ferguson@cs.rochester.edu,  7 Mar 1996
 * Time-stamp: <Sat Nov 16 11:25:57 EST 1996 ferguson>
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
void uttStart(char *sender,int uttnum);
void uttWord(char *sender, char *word, int start, int end, int uttnum);
void uttEnd(char *sender, int uttnum);
void uttReset(void);
static void uttClear(int who);
static int senderIndex(char *sender);

/*
 * Data defined here:
 */
enum { SENDER_SPEECH_IN = 0, SENDER_SPEECH_PP, NUM_SENDERS };
#define MAX_WORDS 256
static char *words[NUM_SENDERS][MAX_WORDS];
static int lastUttnum[NUM_SENDERS];

/*	-	-	-	-	-	-	-	-	*/

void
uttStart(char *sender, int uttnum)
{
    DEBUG1("uttnum=%d", uttnum);
    displayClear();
    displayUttnum(uttnum);
    /* We will reset arrays in uttWord() */
    DEBUG0("done");
}

void
uttWord(char *sender, char *word, int start, int end, int uttnum)
{
    int i, who;

    DEBUG4("sender=%s, word=\"%s\", start=%d, end=%d",
	   sender, (word ? word : "<null>"), start, end);
    /* Determine which array to use for this sender */
    who = senderIndex(sender);
    /* New utterance? */
    if (uttnum != lastUttnum[who]) {
	/* Update display (there's only one of these....) */
	displayUttnum(uttnum);
	/* Wipe the word array for this sender (in case we didn't get START) */
	uttClear(who);
	/* Remember uttnum */
	lastUttnum[who] = uttnum;
    }
    /* Parser indices start at 1 */
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
	for (i=start; words[who][i] != NULL; i++) {
	    DEBUG1("deleting at index %d", i);
	    gfree(words[who][i]);
	    words[who][i] = NULL;
	}
    } else {
	/* New word(s) */
	DEBUG2("saving word \"%s\" at index %d", word, start);
	gfree(words[who][start]);
	words[who][start] = gnewstr(word);
	/* Blank out other "positions" occupied by this word */
	for (i=start+1; i < end; i++) {
	    DEBUG1("erasing at index %d", i);
	    gfree(words[who][i]);
	    words[who][i] = gnewstr("");
	}
    }
    displayWords(who, words[who]);
    DEBUG0("done");
}

void
uttEnd(char *sender, int uttnum)
{
    DEBUG1("uttnum=%d", uttnum);
    /* Nothing to do */
    DEBUG0("done");
}

void
uttReset(void)
{
    uttClear(SENDER_SPEECH_IN);
    uttClear(SENDER_SPEECH_PP);
}

static void
uttClear(int who)
{
    int i;

    for (i=0; i < MAX_WORDS; i++) {
	gfree(words[who][i]);
	words[who][i] = NULL;
    }
}

static int
senderIndex(char *sender)
{
    if (strncasecmp(sender, "speech-in", 9) == 0) {
	return SENDER_SPEECH_IN;
    } else {
	return SENDER_SPEECH_PP;
    }
}
