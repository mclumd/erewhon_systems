/*
 * menu_utils.c : Menu creation utility routines
 *
 * George Ferguson, ferguson@cs.rochester.edu, 15 Aug 1996
 * Time-stamp: <96/08/15 17:13:02 ferguson>
 */

#include <stdio.h>
#include <X11/Intrinsic.h>
#include <Xm/Xm.h>
#include <Xm/RowColumn.h>
#include <Xm/PushB.h>
#include <Xm/CascadeB.h>
#include <Xm/ToggleB.h>
#include <Xm/Separator.h>
#include "menu_utils.h"

/*
 * Functions defined here:
 */
Widget createMenu(Widget menubar, char *name, char *label, char key,
		  MenuItemInfo items[], Widget *cascade_ret);
static Widget addItemToMenu(Widget menu, char *name, char *label, char key,
			    XtCallbackProc callback);
static Widget addToggleItemToMenu(Widget menu, char *name, char *label,
				  char key, XtCallbackProc callback);
static Widget addSeparatorToMenu(Widget menu, char *name);
static Widget addMenuToMenuBar(Widget menubar, Widget menu,
			       char *label, char key);

/*	-	-	-	-	-	-	-	-	*/

Widget
createMenu(Widget menubar, char *name, char *label, char key,
	   MenuItemInfo items[], Widget *cascade_ret)
{
    Widget menu, item, cascade;
    int i;

    menu = XmCreatePulldownMenu(menubar, name, NULL, 0);
    for (i=0; items[i].type != MI_END; i++) {
	switch (items[i].type) {
	  case MI_PUSHBUTTON:
	    item = addItemToMenu(menu, items[i].name, items[i].label,
				 items[i].key, items[i].callback);
	    break;
	  case MI_TOGGLE:
	    item = addToggleItemToMenu(menu, items[i].name, items[i].label,
				       items[i].key, items[i].callback);
	    break;
	  case MI_SEPARATOR:
	    item = addSeparatorToMenu(menu, items[i].name);
	    break;
	}
	if (items[i].widget_ret) {
	    *(items[i].widget_ret) = item;
	}
    }		      
    cascade = addMenuToMenuBar(menubar, menu, label, key);
    if (cascade_ret) {
	*cascade_ret = cascade;
    }
    return menu;
}

/*	-	-	-	-	-	-	-	-	*/

static Widget
addItemToMenu(Widget menu, char *name, char *label, char key,
	      XtCallbackProc callback)
{
    Widget button;
    char acc[16];
    unsigned char *labstr, *accstr;
    Arg args[4];
    int n = 0;

    labstr = XmStringCreate(label, XmSTRING_DEFAULT_CHARSET);
    XtSetArg(args[n], XmNlabelString, labstr); n++;
    XtSetArg(args[n], XmNmnemonic, key); n++;
#ifdef undef
    /* This code adds some text to the right edge of the menu item */
    sprintf(acc,"M+%c", key);
    accstr = XmStringCreate(acc, XmSTRING_DEFAULT_CHARSET);
    XtSetArg(args[n], XmNacceleratorText, accstr); n++;
#endif
    sprintf(acc,"Meta<Key>%c:", key);
    XtSetArg(args[n], XmNaccelerator, acc); n++;
    button = XmCreatePushButton(menu, name, args, n);
    XtManageChild(button);
    XtAddCallback(button, XmNactivateCallback, callback, NULL);
    XmStringFree(labstr);
#ifdef undef
    XmStringFree(accstr);
#endif
    return button;
}

static Widget
addToggleItemToMenu(Widget menu, char *name, char *label, char key,
		    XtCallbackProc callback)
{
    Widget button;
    char acc[16];
    unsigned char *labstr, *accstr;
    Arg args[5];
    int n = 0;

    labstr = XmStringCreate(label, XmSTRING_DEFAULT_CHARSET);
    XtSetArg(args[n], XmNlabelString, labstr); n++;
    XtSetArg(args[n], XmNmnemonic, key); n++;
#ifdef undef
    /* This code adds some text to the right edge of the menu item */
    sprintf(acc,"Meta+%c", key);
    accstr = XmStringCreate(acc, XmSTRING_DEFAULT_CHARSET);
    XtSetArg(args[n], XmNacceleratorText, accstr); n++;
#endif
    sprintf(acc,"Meta<Key>%c:", key);
    XtSetArg(args[n], XmNaccelerator, acc); n++;
    button = XmCreateToggleButton(menu, name, args, n);
    XtManageChild(button);
    XtAddCallback(button, XmNvalueChangedCallback, callback, NULL);
    XmStringFree(labstr);
#ifdef undef
    XmStringFree(accstr);
#endif
    return button;
}

static Widget
addSeparatorToMenu(Widget menu, char *name)
{

    Widget sep;

    sep = XmCreateSeparator(menu, "separator", NULL, 0);
    XtManageChild(sep);
    return sep;
}

static Widget
addMenuToMenuBar(Widget menubar, Widget menu, char *label, char key)
{
    Widget cascade;
    unsigned char *labstr;
    Arg args[3];
    int n = 0;

    labstr = XmStringCreate(label, XmSTRING_DEFAULT_CHARSET);
    XtSetArg(args[n], XmNlabelString, labstr); n++;
    XtSetArg(args[n], XmNmnemonic, key); n++;
    XtSetArg(args[n], XmNsubMenuId, menu); n++;
    cascade = XmCreateCascadeButton(menubar, label, args, n);
    XtManageChild(cascade);
    XmStringFree(labstr);
    return cascade;
}

