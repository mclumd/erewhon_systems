/*
 * send.c
 *
 * George Ferguson, ferguson@cs.rochester.edu,  8 Feb 1996
 * Time-stamp: <Thu Nov 14 17:10:40 EST 1996 ferguson>
 */
#include <stdio.h>
#include <sys/param.h>
#include "KQML/KQML.h"
#include "trlib/send.h"
#include "util/debug.h"
#include "send.h"
#include "main.h"

/*
 * Functions defined here:
 */
void sendReadyMsg(void);
void sendChdirMsg(char *dir);
void sendPracticeMsg(void);
void sendStartMsg(char *name, char *lang, char *sex,
		  char *intro, char *goals, char *scoring);
void sendIMExitMsg(void);

/*	-	-	-	-	-	-	-	-	*/

void
sendReadyMsg(void)
{
    KQMLPerformative *perf;

    DEBUG0("sending hide-window's");
    if ((perf = KQMLNewPerformative("request")) == NULL) {
	return;
    }
    KQMLSetParameter(perf, ":content", "(hide-window)");
    KQMLSetParameter(perf, ":receiver", "display");
    trlibSendPerformative(stdout, perf);
    KQMLSetParameter(perf, ":receiver", "speech-x");
    trlibSendPerformative(stdout, perf);
    KQMLSetParameter(perf, ":receiver", "transcript");
    trlibSendPerformative(stdout, perf);
    KQMLFreePerformative(perf);
    DEBUG0("sending ready to IM");
    if ((perf = KQMLNewPerformative("tell")) == NULL) {
	return;
    }
    KQMLSetParameter(perf, ":receiver", "IM");
    KQMLSetParameter(perf, ":content", "(ready)");
    trlibSendPerformative(stdout, perf);
    KQMLFreePerformative(perf);
    DEBUG0("done");
}

void
sendChdirMsg(char *dir)
{
    static char content[MAXPATHLEN];
    KQMLPerformative *perf;

    DEBUG1("broadcasting (chdir \"%s\")", dir);
    if ((perf = KQMLNewPerformative("broadcast")) == NULL) {
	return;
    }
    KQMLSetParameter(perf, ":receiver", "im");
    sprintf(content, "(request :content (chdir \"%s\"))", dir);
    KQMLSetParameter(perf, ":content", content);
    trlibSendPerformative(stdout, perf);
    KQMLFreePerformative(perf);
    DEBUG0("done");
}

void
sendPracticeMsg(void)
{
    char content[MAXPATHLEN];
    KQMLPerformative *perf;

    DEBUG0("starting practice session");
    if ((perf = KQMLNewPerformative("request")) == NULL) {
	return;
    }
    KQMLSetParameter(perf, ":receiver", "pm");
    sprintf(content, "(start :name practice :exec %s/bin/tpractice)",
	    trains_base);
    KQMLSetParameter(perf, ":content", content);
    trlibSendPerformative(stdout, perf);
    KQMLFreePerformative(perf);
    DEBUG0("done");
}

void
sendStartMsg(char *name, char *lang, char *sex,
	     char *intro, char *goals, char *scoring)
{
    static KQMLPerformative *perf = NULL;
    char content[1024];

    DEBUG0("broadcasting start-conversation");
    if (perf == NULL) {
	if ((perf = KQMLNewPerformative("broadcast")) == NULL) {
	    return;
	}
	KQMLSetParameter(perf, ":receiver", "im");
    }
    sprintf(content, "(tell :content (start-conversation");
    if (name != NULL) {
	sprintf(content+strlen(content), " :name \"%s\"", name);
    }
    if (lang != NULL) {
	sprintf(content+strlen(content), " :lang \"%s\"", lang);
    }
    if (sex != NULL) {
	sprintf(content+strlen(content), " :sex \"%s\"", sex);
    }
    if (intro != NULL) {
	sprintf(content+strlen(content), " :intro %s", intro);
    }
    if (intro != NULL) {
	sprintf(content+strlen(content), " :goals %s", goals);
    }
    if (scoring != NULL) {
	sprintf(content+strlen(content), " :scoring %s", scoring);
    }
    strcat(content, "))");
    KQMLSetParameter(perf, ":content", content);
    trlibSendPerformative(stdout, perf);
    DEBUG0("done");
}

void
sendIMExitMsg(void)
{
    KQMLPerformative *perf;

    DEBUG0("sending IM exit");
    if ((perf = KQMLNewPerformative("request")) == NULL) {
	return;
    }
    KQMLSetParameter(perf, ":receiver", "im");
    KQMLSetParameter(perf, ":content", "(exit 0)");
    trlibSendPerformative(stdout, perf);
    KQMLFreePerformative(perf);
    DEBUG0("done");
}
