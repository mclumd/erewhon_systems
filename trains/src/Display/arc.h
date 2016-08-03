/*
 * arc.h
 *
 * George Ferguson, ferguson@cs.rochester.edu, 18 Apr 1995
 * Time-stamp: <95/04/18 10:58:59 ferguson>
 */

#ifndef _arc_h_gf
#define _arc_h_gf

#include "point.h"

typedef struct _Arc_s {
    Point start;
    Point end;
    int radius;
} Arc;

#endif
