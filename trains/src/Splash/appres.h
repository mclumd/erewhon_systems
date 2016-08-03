/*
 * appres.h
 *
 * George Ferguson, ferguson@cs.rochester.edu, 20 Jun 1996
 * Time-stamp: <Mon Nov 11 18:31:25 EST 1996 ferguson>
 */

#ifndef _appres_h_gf
#define _appres_h_gf

#ifndef XtSpecificationRelease
typedef char *String;
typedef char Boolean;
#endif

typedef struct _AppResources_s {
    String pixmap;
    String logdir;
#ifndef NO_USER_PANEL
    String username;
    String userlang;
    String usersex;
    Boolean intro;
    Boolean goals;
    Boolean scoring;
#endif
    Boolean asksave;
} AppResources;
extern AppResources appres;

#endif
