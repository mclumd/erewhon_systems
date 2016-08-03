/*
 * listen.h
 *
 * George Ferguson, ferguson@cs.rochester.edu, 31 Jul 1996
 * Time-stamp: <96/07/31 15:02:26 ferguson>
 */

#ifndef _listen_h_gf
#define _listen_h_gf

#include "client.h"

extern void clientListenToClient(Client *this, Client *client);
extern void clientListenToClass(Client *this, ClientClass *class);
extern void clientListenToAny(Client *this);
extern void clientUnlistenToClient(Client *this, Client *client);
extern void clientUnlistenToClass(Client *this, ClientClass *class);
extern void clientUnlistenToAny(Client *this);

#endif
