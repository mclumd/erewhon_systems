#include "player_configurer.h"
#include "umbc/logger.h"
#include "controller_obsAvoid.h"
#include "controller_turnTarg.h"
#include "controller_moveTarg.h"

using namespace raccoon;

string player_config::configure(agents::agent_player* a) {
  if ((a->get_name() == "marvin") ||
      (a->get_name() == "rogue")) {
    bool tv = a->add_laser(0);
    tv &= a->add_pp_vfh(0);
    a->add_controller(new controllers::obs_avoid(a));
    a->add_controller(new controllers::turn_to_target(a));
    a->add_controller(new controllers::move_to_target(a));
    if (tv)
      return "configured.";
    else 
      return "some part of configuration failed.";
  }
  else {
    umbc::uLog::annotate(umbc::UMBCLOG_WARNING,
			 "unable to configure \""+a->get_name()+"\"");
    return "not configured.";
  }
}

