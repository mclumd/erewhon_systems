/*
 * streq.h
 *
 * George Ferguson, ferguson@cs.rochester.edu,  7 Nov 1995
 * Time-stamp: <96/02/16 13:55:53 ferguson>
 */

#ifndef _streq_h_gf
#define _streq_h_gf

#include "util_timestamp.h"

/*
 * The KQML spec isn't clear about case-sensitivity. Although I would
 * expect that it should be case-sensitive, I suspect that it probably
 * isn't, since Lisp isn't. Anyway, making this be strcasecmp(3) makes
 * the parser case-insensitive; making this strcmp(3) makes it case-
 * sensitive.
 */
#define STREQ(S1,S2)	(strcasecmp(S1, S2) == 0)

#endif
