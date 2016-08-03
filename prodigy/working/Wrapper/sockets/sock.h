/*
 * FILE:	sock.h
 *		Declarations for handling socket (TCP/IP) communications
 *
 * Author:	Bev Schwartz
 * Date:	August 17, 1994
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
 * $Header: /tmp_mnt/net/panda/u14/plum/rcs/clibsrc/libsock/sock.h,v 1.1 1995/09/01 15:12:32 dbikel Exp $
 */

/* In sock.c: */
extern int sock_server_init(int);
extern int sock_accept_conn(int);
extern int sock_client_init(char *, int);
extern void sock_close(int);
