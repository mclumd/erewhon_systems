/*
 * monitor.h
 *
 * George Ferguson, ferguson@cs.rochester.edu, 31 Jul 1996
 * Time-stamp: <96/08/01 14:31:24 ferguson>
 */

#ifndef _monitor_h_gf
#define _monitor_h_gf

#include "client.h"

extern void clientMonitorClient(Client *this, Client *client, char *reply_with);
extern void clientMonitorClass(Client *this, ClientClass *class, char *reply_with);
extern void clientMonitorAny(Client *this, char *reply_with);
extern void clientUnmonitorClient(Client *this, Client *client);
extern void clientUnmonitorClass(Client *this, ClientClass *class);
extern void clientUnmonitorAny(Client *this);

#endif
