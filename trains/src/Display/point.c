/*
 * point.c
 *
 * George Ferguson, ferguson@cs.rochester.edu, 18 Apr 1995
 * Time-stamp: <95/04/18 11:12:20 ferguson>
 */

#include <stdlib.h>
#include "point.h"

Point *
createPoint(int x, int y)
{
    Point *p = (Point*)malloc(sizeof(Point));
    p->x = x;
    p->y = y;
    return p;
}

void
destroyPoint(Point *p)
{
    if (p) free((char*)p);
}
