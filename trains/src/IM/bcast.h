/*
 * bcast.h
 *
 * George Ferguson, ferguson@cs.rochester.edu, 7 Nov 1995
 * Time-stamp: <96/07/30 16:57:28 ferguson>
 */

#ifndef _bcast_h_gf
#define _bcast_h_gf

#include "client.h"
#include "KQML/KQML.h"

extern void broadcastPerformative(Client *sender, KQMLPerformative *perf);
extern void broadcastPerformativeToListeners(Client *sender, KQMLPerformative *perf);

#endif
