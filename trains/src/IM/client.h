/*
 * client.h
 *
 * George Ferguson, ferguson@cs.rochester.edu,  9 Nov 1995
 * Time-stamp: <96/09/11 20:52:31 ferguson>
 */

#ifndef _client_h_gf
#define _client_h_gf

typedef enum {
    IM_DEAD = 0, IM_LISTENING, IM_CONNECTED, IM_READY, IM_EOF
} ClientState;

#ifndef NO_DISPLAY
typedef struct _Point_s {
    int short x,y;
} Point;
#endif

typedef struct _ClientListItem_s {
    struct _Client_s *client;
    char *client_data;
    struct _ClientListItem_s *next;
} ClientListItem;
typedef ClientListItem *ClientList;

typedef struct _Client_s {
    char *name;				/* Name of client */
    int fd;				/* File descriptor to read/write */
    ClientState state;			/* Client state */	
    ClientList listeners;		/* List of listening modules */
    ClientList monitors;		/* List of monitoring modules */
    struct _ClientClassListItem_s *classes;
#ifndef NO_DISPLAY
    int x, y;				/* Position on display */
    int r;				/* Size of circle */
    Point linePts[2];			/* Spoke from client to IM */
    Point recvPts[3];			/* Arrow from client to IM */
    Point sendPts[3];			/* Arrow from IM to client */
    int recvCount, sendCount;		/* Used for delayed erasing */
#endif
    struct _Client_s *next, *prev;	/* Linked list of all clients */
} Client;

typedef struct _ClientClassListItem_s {
    struct _ClientClass_s *class;
    struct _ClientClassListItem_s *next;
} ClientClassListItem;
typedef ClientClassListItem *ClientClassList;

typedef struct _ClientClass_s {
    char *name;
    struct _ClientClass_s *superclass;
    ClientList clients;
    ClientList listeners;
    ClientList monitors;
    ClientClassList subclasses;
    struct _ClientClass_s *next, *prev;	/* Linked list of all classes */
} ClientClass;

/*	-	-	-	-	-	-	-	-	*/

extern Client *newClient(char *name, int fd);
extern void deleteClient(Client *this);
extern Client *findClientInList(Client *this, ClientListItem *list);
extern void addClientToList(Client *this, ClientListItem **list, char *client_data);
extern void deleteClientFromList(Client *this, ClientListItem **list);

extern ClientClass *newClientClass(char *name, ClientClass *super);
extern void addClientToClass(Client *this, ClientClass *class);
extern void deleteClientFromClass(Client *this, ClientClass *class);
extern void deleteClientFromClasses(Client *this);

extern Client *findClientByName(char *name);
extern Client *findOrCreateClient(char *name);
extern Client *findClientByFd(int fd);
extern void clientSetFd(Client *this, int fd);
extern ClientClass *findClientClassByName(char *name);
extern char *clientStatusString(Client *client);
extern void dumpClients(FILE *fp);

extern Client *clientList;
extern ClientClass *clientClassList;
extern ClientClass *AnyClass;

#endif
