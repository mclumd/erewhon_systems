/*
 * orientation.h
 *
 * George Ferguson, ferguson@cs.rochester.edu, 18 Apr 1995
 * Time-stamp: <96/04/11 16:56:04 ferguson>
 */

#ifndef _orientation_h_gf
#define _orientation_h_gf

typedef enum {
    O_NONE, O_NORTH, O_NORTHEAST, O_EAST, O_SOUTHEAST, O_SOUTH,
    O_SOUTHWEST, O_WEST, O_NORTHWEST, O_CENTER, O_LEFT, O_RIGHT
} Orientation;

extern Orientation stringToOrientation(char *str);

#endif
