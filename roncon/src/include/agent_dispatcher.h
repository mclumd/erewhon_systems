#ifndef RC_AGENT_TCP_DISPATCH
#define RC_AGENT_TCP_DISPATCH

#include "agent.h"
#include "pthread.h"

namespace raccoon {
  namespace controllers { class controller; };

  namespace agents {

    class agent_dispatcher_tcp : public agent {
    public:
      agent_dispatcher_tcp(string nm);
      agent_dispatcher_tcp(string nm, int port);
      virtual ~agent_dispatcher_tcp();

      virtual bool initialize();
      virtual bool monitor();
      virtual bool shutdown();

      virtual string query  (string q);
      virtual string command(string c);

      virtual string class_name() { return "tcp_dispatch"; };
      virtual string grammar_commname() { return "tcpd_command"; };
      virtual bool   publish_grammar(umbc::command_grammar& cg);

      int  port() { return my_port; };
      bool serve_p() { return serve; };

      string find_agent(string agentspec);
      agent* get_agent(string agent_name);
      string generate_grammar();

      static int DEFAULT_PORT;

      virtual controller* get_controller(string nm) { return NULL; };
      virtual void add_controller(controllers::controller* c) { return; };
      virtual bool start_controller(controller* c) { return false; };
      virtual bool start_controller(controller* c,arguments& cargo) 
	{ return false; };
      virtual bool stop_controller(controller* c) { return false; };

      virtual string describe() { return "<tcp dispatcher>"; };

    protected:
      int my_port;
      pthread_t server_thread;
      bool serve;
      list<agent*> agent_list;

    };

  };
};

#endif
