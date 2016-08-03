/*
 * dialog.h
 *
 * George Ferguson, ferguson@cs.rochester.edu, 31 May 1995
 * Time-stamp: <95/05/31 14:39:38 ferguson>
 */

#ifndef _dialog_h_gf
#define _dialog_h_gf

typedef enum {
    DIALOG_GOALS, DIALOG_PARSER
} DialogType;

extern void displayDialog(DialogType type, char *msg);

#endif
