/*
 * send.h
 *
 * George Ferguson, ferguson@cs.rochester.edu,  8 Apr 1995
 * Time-stamp: <96/07/30 17:09:39 ferguson>
 */

#ifndef _send_h_gf
#define _send_h_gf

#include "KQML/KQML.h"
#include "client.h"

extern void sendPerformative(Client *dst, KQMLPerformative *perf);
extern void sendPerformativeNoLog(Client *dst, KQMLPerformative *perf);

#endif
