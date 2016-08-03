#include "lisp_interface.h"
#include <sys/socket.h>
#include <netinet/in.h>
#include <string.h>
#include <arpa/inet.h>
#include <string>
#include <iostream>
#include <cerrno>
#include <sys/un.h>
#include <unistd.h>
#include <sstream>
#include <algorithm>

using namespace std;

Lisp_Interface::Lisp_Interface () {
    connect_to_lisp_server (); 
}

int Lisp_Interface::connect_to_lisp_server () {
    struct sockaddr_un server;
    
    // now create a socket
    sockfd = socket (AF_UNIX, SOCK_STREAM, 0);
    //sockfd = socket (AF_INET, SOCK_STREAM, 0);

    if (sockfd == -1) {
        cerr << "socket could not be created to communicate with lisp server " << errno << endl;
        exit (1);
    }

    memset (&server, 0, sizeof (server));

    // setting server attributes to connect to
    server.sun_family = AF_UNIX;
    strcpy (server.sun_path, LISP_SERVER_SOCKET_FILE);
    cout << "socket file: " << server.sun_path << endl;

    // now connect
    int len = sizeof (server.sun_family) + strlen (server.sun_path);
    int c_res = connect (sockfd, (struct sockaddr *) &server, len);
    if (c_res == -1) {
        cerr << "could not connect to lisp server " << errno << " " << EACCES << endl;
        exit (1);
    }

    return c_res;
}

int Lisp_Interface::send_msg_to_server (string msg) {
    int len = send (sockfd, msg.data (), msg.size (), 0);
    cout << "sent " << len << " bytes of " << msg << endl;
    
    return len;
}

void Lisp_Interface::recv_msg_from_server (stringstream &msg) {
    char buffer [MAX_CHARS_PER_MSG];

    int bytes_received = 0;

    do {
        bytes_received = recv (sockfd, buffer, MAX_CHARS_PER_MSG, 0);
        buffer [bytes_received] = '\0';
        msg << buffer;

    } while (bytes_received == MAX_CHARS_PER_MSG);

    cout << "msg received from server is: " << msg.str () << endl;
    cout << "length of msg is: " << msg.str ().size () << endl << endl;
}

int Lisp_Interface::unlink_socket () {
    return unlink (LISP_SERVER_SOCKET_FILE);
}
