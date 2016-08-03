/*
 * bitops.h : Bit operations
 *
 * George Ferguson, ferguson@cs.rochester.edu,  8 Apr 1995
 * Time-stamp: <96/02/16 13:54:41 ferguson>
 */

#ifndef _bitops_h_gf
#define _bitops_h_gf

#include "util_timestamp.h"

#define BITSET(B,N)	(B) |= (1 << (N))
#define BITCLR(B,N)	(B) &= ~(1 << (N))
#define BITTST(B,N)	((B) & (1 << (N)))

#endif
