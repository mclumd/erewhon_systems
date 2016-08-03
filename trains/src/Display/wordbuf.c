/*
 * wordbuf.c : Incremental word output from the typed input
 *
 * George Ferguson, ferguson@cs.rochester.edu,  9 Feb 1995
 * Time-stamp: <96/04/24 17:51:08 ferguson>
 *
 * This code incrementally outputs text typed in the display textin window.
 * Each time its called, it compares what it has previously sent, backs
 * up if necessary, and sends new words. It does not send the last `bufnum'
 * words recognized so far, on the grounds that they are likely to change.
 * Of course, since that word has to get out sometime, the FINAL flag
 * is provided to force it out.
 *
 * NOTE: Indexes represent the positions *between* words, as in
 *        hello I'm confused about indices
 *       1     2 3 4        5     6       7
 * NOTE: The parser considers words with an apostrophe or hyphen to be
 * two words. We have to remember this when generating :index tags for the
 * output.
 */

#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include "util/debug.h"
#include "wordbuf.h"
#include "send.h"

/*
 * Functions defined here:
 */
void wordbufOutput(char *new, int final);
static int countSpecials(char *s);
void wordbufSetBufferLen(int len);
void wordbufReset(void);

/*
 * Data defined here:
 */
static int bufnum = 2;

#define MAX_WORDS	64
#define MAX_WORD_LEN	32
static char oldWords[MAX_WORDS][MAX_WORD_LEN];
static char newWords[MAX_WORDS][MAX_WORD_LEN];
static int numOld, numNew;

/*	-	-	-	-	-	-	-	-	*/

void
wordbufOutput(char *new, int final)
{
    int index, diffpos, i, n;
    char content[64];

    DEBUG2("new=\"%s\", final=%d",new,final);
    /* Split into words */
    numNew = 0;
    while (*new && *new != '\n') {
	/* Skip whitespace */
	while (*new && (*new == ' ' || *new == '\n')) {
	    new += 1;
	}
	if (!*new) {
	    break;
	}
	/* Copy this word into newWords[] */
	i = 0;
	while (*new && *new != ' ' && *new != '\n') {
	    newWords[numNew][i++] = *new++;
	}
	newWords[numNew][i] = '\0';
	DEBUG2("newWords[%d] = \"%s\"", numNew, newWords[numNew]);
	/* Increment count of newWords[] */
	numNew += 1;
    }
    /* Parser indices start at 1 and count apostrophe as splitting a word */
    index = 1;
    /* Compare new words to old to find where they differ */
    for (diffpos=0; diffpos < numNew && diffpos < numOld; diffpos++) {
	DEBUG4("%d: new=\"%s\", old=\"%s\", index=%d",
	       diffpos, newWords[diffpos], oldWords[diffpos], index);
	if (strcmp(newWords[diffpos], oldWords[diffpos]) != 0) {
	    /* Words differ */
	    break;
	} else {
	    /* Words are the same, just adjust index */
	    index += 1 + countSpecials(newWords[diffpos]);
	}
    }
    DEBUG4("numOld = %d, numNew=%d, diffpos=%d, index=%d",
	   numOld, numNew, diffpos, index);
    /* Maybe some old words need to be backed up */
    if (diffpos < numOld) {
	DEBUG1("backto %d", index);
	sprintf(content, "(backto :index %d)", index);
	sendMsg(content);
	numOld = diffpos;
    } else {
	DEBUG0("don't need to backup");
    }
    /* Unless this is a "final" output, throw away the buffered words */
    if (!final) {
	numNew -= bufnum;
	if (numNew <= 0) {
	    DEBUG0("done (nothing to output) --------");
	    return;
	}
	DEBUG2("bufnum=%d, numNew now=%d", bufnum, numNew);
    }
    /* Maybe some new words need to be added */
    if (diffpos < numNew) {
	DEBUG0("outputting new words...");
	for (i=diffpos; i < numNew; i++) {
	    /* Parser's indices start from 1 */
	    if ((n = countSpecials(newWords[i])) == 0) {
		sprintf(content, "(word \"%s\" :index %d)",
			newWords[i], index);
	    } else {
		sprintf(content, "(word \"%s\" :index (%d %d))",
			newWords[i], index, 1+index+n);
	    }
	    sendMsg(content);
	    index += 1 + n;
	    /* And save the new word for next time */
	    strcpy(oldWords[i], newWords[i]);
	}
	/* And save the number of new words for next time */
	numOld = numNew;
	for (i=0; i < numOld; i++) {
	    DEBUG2("oldWords[%d] = \"%s\"", i, oldWords[i]);
	}
    } else {
	DEBUG0("don't need to add words");
    }
    DEBUG0("done ----------------------------");
}

static int
countSpecials(char *s)
{
    int n = 0;

    while (*s) {
	if (!isalnum(*s)) {
	    n += 1;
	}
	s += 1;
    }
    return n;
}


/*	-	-	-	-	-	-	-	-	*/

void
wordbufSetBufferLen(int len)
{
    bufnum = len;
}

void
wordbufReset(void)
{
    numOld = 0;
}
