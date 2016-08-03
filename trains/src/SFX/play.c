/*
 * play.c
 *
 * George Ferguson, ferguson@cs.rochester.edu, 11 Mar 1996
 * Time-stamp: <96/09/04 15:05:35 ferguson>
 */
#include <stdio.h>
#include <fcntl.h>
#include "trlib/error.h"
#include "util/error.h"
#include "util/debug.h"
#include "play.h"
#include "audio.h"
#include "send.h"

/*
 * Functions defined here:
 */
void playFile(char *buf, KQMLPerformative *perf);

/*	-	-	-	-	-	-	-	-	*/

void
playFile(char *filename, KQMLPerformative *perf)
{
    static char buf[8*1024];
    int fd, num;

    DEBUG1("opening audio file \"%s\"", filename);
    if ((fd = open(filename, O_RDONLY)) < 0) {
	sprintf(buf, "%s: %s", filename, strerror(errno));
	SYSERR1("couldn't read %s", filename);
	trlibErrorReply(perf, ERR_BAD_VALUE, buf);
	return;
    }
    DEBUG0("playing audio file...");
    while ((num=read(fd, buf, sizeof(buf))) > 0) {
	DEBUG1("sending %d bytes to audio", num);
	audioWrite(buf, num);
    }
    DEBUG0("closing audio file");
    close(fd);
    DEBUG0("waiting for audio to finish");
    audioSync();
    DEBUG0("sending done reply");
    sendDoneReply(perf);
    DEBUG0("done");
}
    
