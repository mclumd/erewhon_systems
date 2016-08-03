/*
 * send.h
 *
 * George Ferguson, ferguson@cs.rochester.edu, 12 Jan 1996
 * Time-stamp: <96/03/12 13:33:27 ferguson>
 */

#ifndef _send_h_gf
#define _send_h_gf

#include "KQML/KQML.h"

extern void sendMonitorMsg(void);
extern void sendOpenMsg(void);
extern void sendReadyMsg(void);
extern void sendDrainMsg(KQMLPerformative *perf);
extern void sendIndexReply(KQMLPerformative *perf, int value);
extern void sendDoneReply(KQMLPerformative *perf);

#endif
