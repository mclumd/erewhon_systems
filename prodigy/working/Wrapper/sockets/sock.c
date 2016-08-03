/*
 * FILE:	sock.c
 *		Functions for handling socket (TCP/IP) communications
 *
 * Author:	Bev Schwartz
 * Date:	August 16, 1994
 *
 * Functionality:
 *	Initializes sockets connections on both server and client sides.
 *	Accepts new connections.  Closes sockets.
 *
 * Public Functions:
 *
 *	int sock_server_init(int port)
 *		Does socket intialization for a server.
 *
 *	int sock_accept_conn(int listen_socket)
 *		Accepts a socket connection from a client.
 *
 *	int sock_client_init(char *host, int port)
 *		Does socket initialization for a client.  Makes connection
 *		to a server.
 *
 *	void sock_close(int socket)
 *		Closes a socket.
 *
 * $Header: /net/panda/u14/plum/rcs/clibsrc/libsock/sock.c,v 1.4 1997/05/22 21:51:48 dbikel Exp $
 */

#include <stdio.h>
#include <fcntl.h>
#include <sys/types.h>
#ifndef WIN32
#  include <netdb.h>
#  include <netinet/in.h>
#  include <sys/socket.h>
#else
#  include <winsock.h>
#  define      WS_VERSION_REQD    0x0101
#  define      WS_VERSION_MAJOR   HIBYTE(WS_VERSION_REQD)
#  define      WS_VERSION_MINOR   LOBYTE(WS_VERSION_REQD)
#  define      MIN_SOCKETS_REQD   6

   WSADATA      wsaData;
#endif

#include <errno.h>
#include <signal.h>
#include <memory.h>

/* later in this file: */
static void sock_print_sys_error(void);

/*
 * int sock_server_init(int port)
 *	IN int port;		The port number we're listening on.
 *
 * Returns:
 *	The listening socket, if successful.
 *
 * Functionality:
 *	Do a socket call, a bind, and start listening.  If the bind
 *	fails, keep trying.  If anything else fails, write an
 *	appropriate error message and exit.
 */
	int
sock_server_init(int port)
{
	int sock;		/* The socket for listening */
	struct sockaddr_in server;	/* for binding the server */
	int rval;		/* return from bind */

#ifdef WIN32
	static int init = 1;
	if (init) {
		if (WSAStartup(WS_VERSION_REQD,&wsaData)) {
			fprintf (stderr, "WSAStartup error");
			exit (1);
		}
		init = 0;
	}
#endif

	/* get a socket */
	sock = socket(AF_INET, SOCK_STREAM, 0);
	if (sock == -1) 
		{
#ifndef WIN32
		fprintf(stderr, "sock_server_init: couldn't get socket");
#else
		DWORD i = GetLastError();
		fprintf(stderr, "sock_server_init: couldn't get socket, %d",i);
#endif
		sock_print_sys_error();
		exit(1);
		}

	/* set things up for the bind */
	server.sin_family = AF_INET;
	server.sin_addr.s_addr = INADDR_ANY;
	server.sin_port = htons(port);

	/* keep trying bind until success */
	do 
	    {
#ifdef SOLARIS
            rval = bind(sock, (struct sockaddr *)&server, sizeof(server));
#else
	    rval = bind(sock, &server, sizeof(server));
#endif
	    if (rval == -1)
		{
		fprintf(stderr, "sock_server_init: couldn't do bind");
		sock_print_sys_error();
		fprintf(stderr, "Will wait 30 seconds and try again.\n");
#ifndef WIN32
		sleep(30);
#else
		Sleep (30000);
#endif
		}
	    }
	while (rval == -1);

	/* listen for connections */
	rval = listen(sock, 1);
	if (rval == -1)
		{
		fprintf(stderr, "sock_server_init: listen failed");
		sock_print_sys_error();
		close(sock);
		exit(1);
		}

#ifndef WIN32
	/* ignore SIGPIPE signals */
	signal(SIGPIPE, SIG_IGN);
#endif

	/* success! */
	return sock;
}

/*
 * int sock_accept_conn(int listen_socket)
 *	IN int listen_sock;	The socket we're listening for connections.
 *
 * Returns:
 *	The new socket, if successful; -1 otherwise.
 *
 * Functionality:
 *	Accept the connection (will block until a connection is made).  
 */
	int
sock_accept_conn(int listen_sock)
{
	int sock;	/* the new socket */
	int i = 0;

	/* accept the connection... */
	/* since lisp barfs on the first call to accept, give this a
	 * try a few times if the reason for error is EINTR
	 * if it still fails, return -1 */
	do sock = accept(listen_sock, NULL, NULL), i++;
	while (sock == -1 && errno == EINTR && i < 4);

	if (sock == -1)
		{
		fprintf(stderr, "sock_accept_conn: accept failed");
		sock_print_sys_error();
		}

	/* and return it! */
	return sock;
}

/*
 * int sock_client_init(char *host, int port)
 *	IN char *host;		Name of the host to connect to.
 *	IN int port;		Port number of the connection.
 *
 * Returns:
 *	A socket, if successful; -1 if connect fails.
 *
 * Functionality:
 *	Gets a socket.  Sets up information about host to connect to.
 *	Tries to connect.  If the connect fails, then a -1 is returned.
 *	Otherwise the program gives an error message and exits.
 */
	int
sock_client_init(char *host, int port)
{
	int sock;		/* The socket we're trying to get */
	struct hostent *hp;	/* To get information about the host we're
				 * connecting to. */
	struct sockaddr_in server; /* address of host we're connecting to */
	int rval;		/* return from system functions */

	/* prepare the network address and port where we're connecting */
	hp = gethostbyname(host);
	if (hp == NULL)
		{
		fprintf(stderr, "sock_client_init: can't get hostname %s", 
									host);
		sock_print_sys_error();
		exit(1);
		}
	server.sin_family = AF_INET;
	memcpy(&server.sin_addr, hp->h_addr,  hp->h_length);
	server.sin_port = htons(port);
	
	/* get socket */
	sock = socket(AF_INET, SOCK_STREAM, 0);
	if (sock == -1) 
		{
		fprintf(stderr, "sock_client_init: can't get a socket");
		sock_print_sys_error();
		exit(1);
		}

	/* do the connect */
#ifdef SOLARIS
        rval = connect(sock, (struct sockaddr *)&server, sizeof(server));
#else
	rval = connect(sock, &server, sizeof(server));
#endif
	if (rval == -1)
		{
		/* clean up and return */
		close(sock);
		return -1;
		}

	/* success! */
	else return sock;
}

/*
 * void sock_close(int socket)
 *	IN int socket;		The socket to close.
 *
 * Functionality:
 *	Just close the socket!
 */
	void
sock_close(int socket)
{
	int rval;

	/* close it! */
	rval = close(socket);
	if (rval == -1)
		{
		fprintf(stderr, "sock_close: close failed");
		sock_print_sys_error();
		}
}

/*
 * void sock_print_sys_error(void)
 *
 * Functionality:
 *	Print the system error message
 */
	void
sock_print_sys_error(void)
{
	extern int errno, sys_nerr;
	extern char *sys_errlist[];

	/* if an error message exists, print it */
#ifndef WIN32
	if (errno > 0 && errno < sys_nerr)
		fprintf(stderr, ": %s (%d)\n", sys_errlist[errno], errno);
	else
#endif
		fprintf(stderr, ": error no %d\n", errno);
}
