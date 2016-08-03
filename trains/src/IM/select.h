/*
 * select.h:
 *
 * George Ferguson, ferguson@cs.rochester.edu,  9 Nov 1995
 * Time-stamp: <Wed Nov 13 15:44:02 EST 1996 ferguson>
 */

#ifndef _select_h_gf
#define _select_h_gf

typedef enum {
    IM_NOP = 0,
    IM_READ = 1,
    IM_WRITE = 2,
    IM_RDWR = 3,
    IM_ACCEPT = 4,
    IM_ALL = 7,
#ifndef NO_DISPLAY
    IM_DISPLAY = 8
#endif
} IMOp;

extern int doSelect(void);
extern void registerFd(int fd, int flags);
extern void unregisterFd(int fd, int flags);
extern void selectSetTimeout(int usec);

#endif
