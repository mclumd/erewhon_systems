/*
 * mouse.h
 *
 * George Ferguson, ferguson@cs.rochester.edu, 18 Jun 1995
 * Time-stamp: <96/10/22 10:12:50 ferguson>
 */

#ifndef _mouse_h_gf
#define _mouse_h_gf

extern void buttonPress(int button, int x, int y);
extern void buttonMotion(int x, int y);
extern void buttonRelease(int button, int x, int y);

#endif
