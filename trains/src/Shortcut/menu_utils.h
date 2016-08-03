/*
 * menu_utils.h : Menu creation utility routines
 *
 * George Ferguson, ferguson@cs.rochester.edu, 15 Aug 1996
 * Time-stamp: <96/08/15 17:12:39 ferguson>
 */

#ifndef _menu_utils_h
#define _menu_utils_h

#define MENU_ITEM_CALLBACK(NAME) \
	void NAME(Widget w, XtPointer client_data, XtPointer call_data)

typedef enum {
    MI_PUSHBUTTON, MI_TOGGLE, MI_SEPARATOR, MI_END
} MenuItemType;

typedef struct _MenuItemInfo_s {
    MenuItemType type;
    char *name;
    char *label;
    char key;
    MENU_ITEM_CALLBACK((*callback));
    Widget *widget_ret;
} MenuItemInfo;

extern Widget createMenu(Widget menubar, char *name, char *label, char key,
			 MenuItemInfo items[], Widget *cascade_ret);

#endif
