#include "/fs/metacog/group/systems/quintus3.5/generic/qplib3.5/IPC/TCP/tcp.h"
#include <errno.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

/* eek() is a crude little error handler */

#define MAXINP 2048

void eek(s)
char *s;
{
    perror(s);
    exit(errno);
}

main(argc, argv)
int argc;
char *argv[];
{
    int Port;
    char *TheHostName;
    int PassiveSocket;
    char buf[MAXINP];
    char newbuf[MAXINP];
    int FD;
    char *Host;
    int i;

    if (argc != 2) {
	printf("Usage: %s ServerFile\n", argv[0]);
	exit(1);
    }

      /* if(tcp_create_listener(0, &Port, &Host, &PassiveSocket)) exit(errno);
	 if(tcp_address_to_file(argv[1], Port, Host)) exit(errno);*/
      /*  printf("Passive socket %d created on %s, port number %d\n",
	  PassiveSocket, Host, Port);*/
      PassiveSocket = tcp_listen(argv[1], &Port, &Host);
      if (PassiveSocket == -1) 
	fprintf(stderr, "Error in creating a channel.\n");

    for (;;) {
	switch (tcp_select(tcp_BLOCK, 0.0, &FD)) {
	  case tcp_ERROR:
	    exit(errno);
	  case tcp_SUCCESS:
	    if (FD == PassiveSocket) {
		if((FD = tcp_accept(PassiveSocket)) == -1) exit(errno);
		printf("Connection to %d accepted\n", FD);
	    } else {
		int n;
		n = read(FD, buf, MAXINP);
		if (!strncmp(buf,"quit",n))
		  exit(1);
		switch (n) {
		  case -1:
		    eek("c_server.read");
		  case 0:
		    if (tcp_shutdown(FD) == -1)
			exit(errno);
		    break;
		  default:
		    if (write(1, buf, n) != n)
			eek("c_server.write");
		    else {
		      printf("\n");
		    }

		}
		strcpy(newbuf,"term(af(ok(1))).\n");
		write(FD, newbuf, strlen(newbuf));
	    }
	}
    }

}



