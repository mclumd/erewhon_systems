/*
 * utt.c
 *
 * George Ferguson, ferguson@cs.rochester.edu, 31 Jan 1996
 * Time-stamp: <96/10/22 15:35:09 ferguson>
 */
#include <stdio.h>
#include <sys/param.h>
#include "util/memory.h"
#include "util/error.h"
#include "util/debug.h"
#include "utt.h"
#include "bcast.h"
#include "wordbuf.h"
#include "init.h"
extern void live_utt_proc(void);		/* From Sphinx */
extern void print_back_trace(FILE *fp);
extern void search_dump_profile(FILE *fp);
extern void gf_main_dump_sphinx_info(FILE *fp);
extern void gf_kb_dump_sphinx_info(FILE *fp);

/*
 * Functions defined here:
 */
void uttStart(void);
void uttStop(void);

/* ringger - changed uttUpdate() & uttDone() functions to provide more info. */
void uttUpdate(char *result, int *h_sfrm, int *h_efrm, int *h_ascr_norm, int frame);
void uttDone(char *result, int *h_sfrm, int *h_efrm, int *h_ascr_norm);

void uttReset(void);
void uttChdir(char *dir);
char *gf_next_output_filename(void);

/*
 * Data defined here:
 */
int speaking = 0;
static int uttnum = 0;
static char *logdir = NULL;

/*	-	-	-	-	-	-	-	-	*/

void
uttStart(void)
{
    char content[32];

    DEBUG0("");
    uttnum += 1;
    DEBUG1("uttnum=%d", uttnum);
    sprintf(content, "(start :uttnum %d)", uttnum);
    broadcast(content);
    wordbufReset();
    speaking = 1;
    DEBUG0("calling live_utt_proc");
    live_utt_proc();
}


void
uttStop(void)
{
    char content[32];

    DEBUG0("");
    speaking = 0;
    sprintf(content, "(input-end :uttnum %d)", uttnum);
    broadcast(content);
    DEBUG0("done");
}

void
uttUpdate(char *result, int *h_sfrm, int *h_efrm, int *h_ascr_norm, int frame)
{
    DEBUG2("result=\"%s\", frame=%d", result, frame);
    wordbufOutput(result, h_sfrm, h_efrm, h_ascr_norm, uttnum, 0);
    DEBUG0("done");
}

void
uttDone(char *result, int *h_sfrm, int *h_efrm, int *h_ascr_norm)
{
    FILE *fp;
    char str[MAXPATHLEN];

    DEBUG1("result=\"%s\"", result);
    /* Send final words for this utt */
    wordbufOutput(result, h_sfrm, h_efrm, h_ascr_norm, uttnum, 1);
    /* Write the .out file for this utterance */
    if (logdir != NULL) {
	sprintf(str, "%s/%s.%03d.out", logdir, basename, uttnum);
    } else {
	sprintf(str, "%s.%03d.out", basename, uttnum);
    }
    if ((fp = fopen(str, "w")) == NULL) {
	SYSERR1("couldn't write .out file \"%s\"", str);
    } else {
	fprintf(fp, "%03d: %s\n", uttnum, result);
	fprintf(fp, "\n");
	if (*result) {
	    print_back_trace(fp);
	    fprintf(fp, "\n");
	    search_dump_profile(fp);
	} else {
	    fprintf(fp, "Empty final hypothesis!\n");
	}
	fclose(fp);
    }
    /* Ok, say we're done with the utt */
    sprintf(str, "(end :uttnum %d)", uttnum);
    broadcast(str);
    DEBUG0("done");
}

void
uttReset(void)
{
    DEBUG0("resetting uttnum to 0");
    uttnum = 0;
    DEBUG0("done");
}

void
uttChdir(char *dir)
{
    FILE *fp;
    char filename[MAXPATHLEN];

    /* Free old logdir and save new one */
    gfree(logdir);
    logdir = gnewstr(dir);
    /* Open new log file */
    if (dir) {
	sprintf(filename, "%s/sphinx.log", dir);
    } else {
	strcpy(filename, "sphinx.log");
    }
    if ((fp=fopen(filename, "w")) == NULL) {
	/* Error, oh well */
	SYSERR1("couldn't write %s", filename);
	return;
    } else {
	/* Open ok, close old logfile */
	close(debugfp);
	debugfp = fp;
	/* Write info about sphinx to new logfile */
	gf_main_dump_sphinx_info(debugfp);
	gf_kb_dump_sphinx_info(debugfp);
	fflush(debugfp);
    }
    /* Reset uttnum also for new directory */
    uttnum = 0;
}

/*	-	-	-	-	-	-	-	-	*/
/*
 * A call to this function was added deep in the depths of sphinx
 * (fe_start_utt() in src/libfe/fe.c) and is called at the start of each
 * utterance.
 */
char *
gf_next_output_filename(void)
{
    static char filename[MAXPATHLEN];

    if (logdir != NULL) {
	sprintf(filename, "%s/%s.%03d.au", logdir, basename, uttnum);
    } else {
	sprintf(filename, "%s.%03d.au", basename, uttnum);
    }
    return filename;
}
