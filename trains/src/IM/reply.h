/*
 * reply.h
 *
 * George Ferguson, ferguson@cs.rochester.edu, 30 Jan 1996
 * Time-stamp: <96/08/01 15:34:56 ferguson>
 */

#ifndef _reply_h_gf
#define _reply_h_gf

#include "KQML/KQML.h"
#include "client.h"

extern void errorReply(KQMLPerformative *perf, int code, char *comment);
extern void statusReply(KQMLPerformative *perf, Client *c);
extern void statusReplyClass(KQMLPerformative *perf, ClientClass *class);

#endif
