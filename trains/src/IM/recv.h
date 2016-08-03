/*
 * recv.h: Messages for the IM itself
 *
 * George Ferguson, ferguson@cs.rochester.edu,  8 Apr 1995
 * Time-stamp: <96/01/30 13:51:34 ferguson>
 */

#ifndef _recv_h_gf
#define _recv_h_gf

#include "KQML/KQML.h"

void imReceive(int fd, KQMLPerformative *perf);

#endif
