/*
 * highlight.h
 *
 * George Ferguson, ferguson@cs.rochester.edu, 28 Feb 1995
 * Time-stamp: <95/04/18 12:52:24 ferguson>
 */

#ifndef _highlight_h
#define _highlight_h

typedef enum {
    HI_NONE, HI_OBJECT, HI_CIRCLE, HI_RECTANGLE
} HighlightType;

typedef struct _Highlight_s {
    HighlightType type;
    Color color;
    Shape *shape;
    int flashes;
    struct _Highlight_s *next;
} Highlight;

extern void objectHighlight(Object *obj, HighlightType htype,
			    Color color, int flashes);
extern void objectUnhighlight(Object *obj, HighlightType htype,
			      Color *colorp, int *flashesp);

extern void highlightListDestroy(Highlight *list);
extern void highlightListDisplay(Highlight *list);

extern HighlightType stringToHighlightType(char *str);

#endif
