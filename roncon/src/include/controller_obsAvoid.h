#ifndef RC_CONTROLLER_OBSAVOID
#define RC_CONTROLLER_OBSAVOID

#include "controller.h"

namespace raccoon { 
  namespace agents { class agent_player; };
  
  namespace controllers {

    using namespace PlayerCc;
    
    class obs_avoid : public player_controller {
    public:
      obs_avoid(agents::agent_player* ape);
      // obs_avoid(PlayerClient& client, Position2dProxy& pp, LaserProxy& lp) :
      // player_controller("obsAvoid",client),my_pp(pp),my_lp(lp),speed(0),turnrate(0) {};

      virtual bool is_valid();
      virtual bool initialize();
      virtual bool start_guts();
      virtual bool start_guts(arguments& cargo);
      virtual bool monitor();
      virtual bool abort();
      virtual bool stop() { return abort(); };
      virtual bool shutdown();
      
      virtual string class_name() { return "obsAvoid"; };
      virtual string grammar_commname() { return get_name(); };
      virtual bool   publish_grammar(umbc::command_grammar& cg);
      
    protected:
      Position2dProxy* my_pp;
      LaserProxy*      my_lp;
      double speed, turnrate ;

    };

  };
};


#endif
