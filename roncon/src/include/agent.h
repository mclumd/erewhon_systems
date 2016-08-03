#ifndef RC_AGENT_BASE
#define RC_AGENT_BASE

#include <string>
#include <list>

#include "umbc/text_utils.h"
#include "umbc/command_grammar.h"
#include "umbc/settings.h"
#include "mixin_classes.h"
#include "arguments.h"
#include "messages.h"

#include "pthread.h"

namespace raccoon {
  namespace controllers { class controller; };
  using namespace controllers;
  using namespace std;

  namespace agents {

    class agent : public message_passer, public mixins::has_name, 
      public umbc::publishes_grammar {
    public:
      agent(string nm) : has_name(nm),my_status("created") {};
      virtual ~agent() {};

      virtual bool initialize()=0;
      virtual bool monitor()=0;
      virtual bool shutdown()=0;

      virtual string query  (string q)=0;
      virtual string command(string c)=0;

      virtual string status()
	{ return my_status; };
      virtual void   set_status(string s)
	{ my_status=s; };

      virtual controller* get_controller(string nm)=0;
      virtual void        add_controller(controller* c)=0;
      virtual bool start_controller(controller* c)=0;
      virtual bool start_controller(controller* c,arguments& cargo)=0;
      virtual bool stop_controller(controller* c)=0;

      virtual string describe()=0;

    private:
      string my_status;

    };

    class agent_basic : public agent {
    public:
    agent_basic(string nm) : agent(nm),server_thread((pthread_t)NULL),
	alive(true),running(false) {};
      virtual ~agent_basic();

      virtual bool initialize();
      virtual bool monitor();
      virtual bool shutdown();
      virtual string query  (string q);
      virtual string command(string c);

      virtual controller* get_controller(string nm);
      virtual void add_controller(controller* c) 
	{ available_controllers.push_back(c); };

      virtual bool start_controller(controller* c);
      virtual bool start_controller(controller* c,arguments& cargo);
      virtual bool stop_controller(controller* c);

      virtual string grammar_commname() 
	{ return get_name(); };
      virtual bool publish_grammar(umbc::command_grammar& cg);

      void kill_update_thread() { alive=false; };
      void set_running(bool s) { running=s; };
      bool is_alive() { return alive; };
      bool is_running() { return running; };

      virtual string describe();

    protected:
      list<controller*> available_controllers;
      list<controller*> active_controllers;
      pthread_t server_thread;
      bool alive,running;

      bool monitor_thread_detach();

    };

    static string okay_msg(string m) { 
      if ((m == "") &&
	  (umbc::settings::getSysPropertyString("reply","none") == "prolog"))
	return "ok(1)";
      else return "ok("+m+")"; 
    };
    static string fail_msg(string m) {
      if ((m == "") &&
	  (umbc::settings::getSysPropertyString("reply","none") == "prolog"))
	return "fail(1)";
      else return "fail("+m+")"; 
    }
    static string ignore_msg(string m) {
      if ((m == "") &&
	  (umbc::settings::getSysPropertyString("reply","none") == "prolog"))
	return "ignore(1)"; 
      else return "ignore("+m+")"; 
    }

    static bool is_okay_msg(string msg)
      { return (msg.substr(0,2) == "ok"); };
    static bool is_fail_msg(string msg)
      { return (msg.substr(0,4) == "fail"); };
    static bool is_ignore_msg(string msg)
      { return (msg.substr(0,6) == "ignore"); };

    static string prologify(string msg) { 
      return "term(af("+umbc::textFunctions::substChar(msg,'.',' ')+"))."; 
    }
    
  };
};

#endif
