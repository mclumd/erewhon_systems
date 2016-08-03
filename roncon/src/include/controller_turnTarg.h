#ifndef RC_CONTROLLER_90DEG
#define RC_CONTROLLER_90DEG

#include "controller.h"

namespace raccoon { 
  namespace agents { class agent_player; };

  namespace controllers {

    using namespace PlayerCc;
    
    class turn_to_target : public player_controller {
    public:

      turn_to_target(agents::agent_player* ape);

      //turn_to_target(PlayerClient& client, 
      // Position2dProxy& pp, Position2dProxy& vfh) :
      // player_controller("turnTarg",client),my_pp(pp),my_vfh(vfh),target(0) {};

      virtual bool is_valid();
      virtual bool initialize();
      virtual bool start_guts();
      virtual bool start_guts(arguments& cargo);
      virtual bool monitor();
      virtual bool stop() { return abort(); };
      virtual bool abort();
      virtual bool shutdown();
      
      virtual string class_name() { return "turn_targ"; };
      virtual string grammar_commname() { return get_name(); };
      virtual bool   publish_grammar(umbc::command_grammar& cg);      

    protected:
      Position2dProxy* my_pp,* my_vfh;
      int target;
      double target_rads;

    private:
      bool near_target();

    };

  };
};


#endif
