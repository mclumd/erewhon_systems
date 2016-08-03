/* this function provides an interface to the SHOP2 code base (in particular,
 * the theorem-prover module) via UNIX domain sockets. 
 *
 * How it works:
 * it spawns an allegro CL process that sets up the domain info (methods, ops, etc)
 * and calls a function that waits for the next planning-problem instance for it to
 * return method instances.
 */

#ifndef LISP_INTERFACE_H
#define LISP_INTERFACE_H

#define LISP_SERVER_SOCKET_FILE "./bindings-socket-file"
#define MAX_CHARS_PER_MSG 4096

#include <sys/socket.h>
#include <string>
#include <sstream>

using namespace std;

class Lisp_Interface {
    private:
        int sockfd;

    public:
        Lisp_Interface ();
        int connect_to_lisp_server (); 
        int send_msg_to_server (string msg);
        void recv_msg_from_server (stringstream &msg);
        int unlink_socket ();
};

#endif
