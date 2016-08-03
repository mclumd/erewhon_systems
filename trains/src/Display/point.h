/*
 * point.h
 *
 * George Ferguson, ferguson@cs.rochester.edu, 18 Apr 1995
 * Time-stamp: <95/04/18 11:12:29 ferguson>
 */

#ifndef _point_h_gf
#define _point_h_gf

typedef struct _Point_s {
    short x,y;				/* chosen to be like XPoint */
} Point;

extern Point *createPoint(int x, int y);
extern void destroyPoint(Point *p);

#endif
