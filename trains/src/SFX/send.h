/*
 * send.h
 *
 * George Ferguson, ferguson@cs.rochester.edu, 12 Jan 1996
 * Time-stamp: <96/09/04 15:04:14 ferguson>
 */

#ifndef _send_h_gf
#define _send_h_gf

#include "KQML/KQML.h"

extern void sendReadyMsg(void);
extern void sendDoneReply(KQMLPerformative *perf);

#endif
