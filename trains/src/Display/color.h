/*
 * color.h
 *
 * George Ferguson, ferguson@cs.rochester.edu, 18 Apr 1995
 * Time-stamp: <95/04/18 11:00:06 ferguson>
 */

#ifndef _color_h_gf
#define _color_h_gf

typedef unsigned long Color;

extern int stringToColor(char *str, Color *colorp);
extern int colorToRGB(Color color, int *redp, int *greenp, int *bluep);
extern void cleanupColors(void);

#endif
