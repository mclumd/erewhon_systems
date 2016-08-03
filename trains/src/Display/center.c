/*
 * center.c: Center one widget within another
 *
 * George Ferguson, ferguson@cs.rochester.edu, 14 Apr 1995
 * Time-stamp: <95/04/14 15:42:42 ferguson>
 */
#include <X11/Intrinsic.h>
#include <X11/StringDefs.h>

void
centerWidget(Widget widget, Widget pwidget)
{
    Window rwin, child;
    int x, y, px, py;
    unsigned int w, h, pw, ph, bw, d;

    /* Get child size */
    XGetGeometry(XtDisplay(widget), XtWindow(widget),
		 &rwin, &x, &y, &w, &h, &bw, &d);
    /* Get parent size, position */
    XGetGeometry(XtDisplay(pwidget), XtWindow(pwidget),
		 &rwin, &px, &py, &pw, &ph, &bw, &d);
    /* Need position in root window coords, don't ask me why */
    XTranslateCoordinates(XtDisplay(widget), XtWindow(pwidget), rwin,
			  px, py, &x, &y, &child);
    px = x;
    py = y;
    /* Compute child position */
    x = px + pw/2 - w/2;
    if (x < 0)
	x = 0;
    else if (x > WidthOfScreen(XtScreen(widget))-w)
	x = WidthOfScreen(XtScreen(widget))-w;
    y = py + ph/2 - h/2;
    if (y < 0)
	y = 0;
    else if (y > HeightOfScreen(XtScreen(widget))-h)
	y = WidthOfScreen(XtScreen(widget))-h;
    /* Set child position */
    XtVaSetValues(widget, XtNx, x, XtNy, y, NULL);
}
