/*
 * conv.c
 *
 * George Ferguson, ferguson@cs.rochester.edu,  8 Feb 1996
 * Time-stamp: <Mon Nov 11 18:34:24 EST 1996 ferguson>
 *
 * We broadcast CHDIR and START-CONVERSATION messages when a new conversation
 * is started.
 */
#include <stdio.h>
#include <sys/param.h>
#include "util/error.h"
#include "util/debug.h"
#include "conv.h"
#include "send.h"
#include "display.h"
#include "save.h"
#include "logdir.h"
#include "appres.h"

/*
 * Functions defined here:
 */
void convStart(char *name, char *lang, char *sex,
	       char *intro, char *goals, char *scoring);
void convEnd(void);
static void writeUserFile(char *name, char *lang, char *sex,
			  char *intro, char *scoring);

/*
 * Data defined here:
 */
static char *logdir = NULL;

/*	-	-	-	-	-	-	-	-	*/

void
convStart(char *name, char *lang, char *sex,
	  char *intro, char *goals, char *scoring)
{
    DEBUG0("starting new conversation");
    if ((logdir = newLogDirectory()) == NULL) {
	return;
    }
    sendChdirMsg(logdir);
    writeUserFile(name, lang, sex, intro, scoring);
    sendStartMsg(name, lang, sex, intro, goals, scoring);
    displayHideWindow();
    DEBUG0("done");
}

void
convEnd(void)
{
    DEBUG0("ending conversation");
    displayShowWindow();
    if (logdir != NULL && appres.asksave) {
	popupSavePanel(logdir);
    }
    DEBUG0("done");
}

static void
writeUserFile(char *name, char *lang, char *sex, char *intro, char *scoring)
{
    FILE *fp;
    char filename[MAXPATHLEN];

    if (logdir != NULL) {
	sprintf(filename, "%s/user", logdir);
    } else {
	strcpy(filename, "user");
    }
    if ((fp = fopen(filename, "w")) == NULL) {
	SYSERR1("couldn't write %s", filename);
	return;
    }
    fprintf(fp, "(tell :content (start-conversation");
    if (name != NULL) {
	fprintf(fp, " :name \"%s\"", name);
    }
    if (lang != NULL) {
	fprintf(fp, " :lang \"%s\"", lang);
    }
    if (sex != NULL) {
	fprintf(fp, " :sex \"%s\"", sex);
    }
    if (intro != NULL) {
	fprintf(fp, " :intro %s", intro);
    }
    if (scoring != NULL) {
	fprintf(fp, " :scoring %s", scoring);
    }
    fprintf(fp, "))\n");
    fclose(fp);
}
