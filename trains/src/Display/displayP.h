/*
 * displayP.h : Private declarations for modules that do know about X
 *
 * George Ferguson, ferguson@cs.rochester.edu, 21 Dec 1994
 * Time-stamp: <95/04/29 15:10:43 ferguson>
 */

#ifndef _displayP_h_gf
#define _displayP_h_gf

/* The declarations are for Xlib modules (ie., anyone) */
extern Display *display;
extern Screen *screen;
extern int screenum;
extern Colormap colormap;
extern Window root,canvas;

/* These declarations are only for modules using Xt/Xaw */
#ifdef XtSpecificationRelease
Widget toplevel, canvasW;
XtAppContext appcon;
#endif

#endif
