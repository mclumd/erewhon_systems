#ifndef RC_CONTROLLER_BASE
#define RC_CONTROLLER_BASE

#include <libplayerc++/playerc++.h>
#include "umbc/command_grammar.h"
#include "arguments.h"
#include "mixin_classes.h"
#include "messages.h"

namespace raccoon {
  namespace agents { class agent; class agent_player; };
  
  namespace controllers {
    
    class controller : 
      public mixins::has_name, public message_passer, public umbc::publishes_grammar {
      
      public:
      controller(string nm,agents::agent* a);

      virtual bool is_valid()=0;
      virtual bool initialize()=0;
      virtual bool start()=0;
      virtual bool start(arguments& cargo)=0;
      virtual bool monitor()=0;
      virtual bool stop()=0;
      virtual bool abort()=0;
      virtual bool shutdown()=0;
      virtual bool is_running()=0;
      virtual bool self_deactivate()=0;
      virtual bool self_deactivated()=0;
      virtual bool extern_deactivate()=0;
      virtual bool extern_deactivated()=0;

      virtual agents::agent* agent_of() { return my_agent; };
      
      private:
      agents::agent* my_agent;
      
    };
    
    using namespace PlayerCc;

    class player_controller : public controller {
    public:
      player_controller(string nm,agents::agent_player* ape);

      // agent object now required...
      // player_controller(string nm,PlayerClient& client) : 
      // controller(nm),my_client(client),run(false) {};

      virtual bool is_running() { return run; };

      bool start() 
            { self_deac = false; needs_deac = false; start_guts(); };
      bool start(arguments& cargo) 
            { self_deac = false; needs_deac=false; start_guts(cargo);};

      virtual bool start_guts() {};
      virtual bool start_guts(arguments& cargo) {};

      virtual bool self_deactivate() { self_deac=true; };
      virtual bool self_deactivated() { return self_deac; };
      virtual bool extern_deactivate() { needs_deac = true; };
      virtual bool extern_deactivated() { return needs_deac; };

    protected:
      PlayerClient* my_client;
      bool run,self_deac,needs_deac;

    };
    
  };
};

#endif
