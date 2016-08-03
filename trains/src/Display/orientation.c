/*
 * orientation.c
 *
 * George Ferguson, ferguson@cs.rochester.edu, 11 Apr 1996
 * Time-stamp: <96/04/11 17:10:31 ferguson>
 */
#include <stdio.h>
#include "util/streq.h"
#include "orientation.h"

/*
 * Functions defined here:
 */
Orientation stringToOrientation(char *str);

/*	-	-	-	-	-	-	-	-	*/

Orientation
stringToOrientation(char *str)
{
    if (STREQ(str, "north")) {
	return O_NORTH;
    } else if (STREQ(str, "northeast")) {
	return O_NORTHEAST;
    } else if (STREQ(str, "east")) {
	return O_EAST;
    } else if (STREQ(str, "southeast")) {
	return O_SOUTHEAST;
    } else if (STREQ(str, "south")) {
	return O_SOUTH;
    } else if (STREQ(str, "southwest")) {
	return O_SOUTHWEST;
    } else if (STREQ(str, "west")) {
	return O_WEST;
    } else if (STREQ(str, "northwest")) {
	return O_NORTHWEST;
    } else {
	return O_NONE;
    }
}
