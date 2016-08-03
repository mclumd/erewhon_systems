/*
 *  Matt's obstacle (or whatever) avoid wanderer program for
 *  The Pioneers.  Shamelessly based on /usr/local/share/player/examples
 *  /libplayerc++/laserobstacleavoid.cc
 */

#include "controller_obsAvoid.h"
#include "agent_player.h"
#include <iostream>

using namespace std;
using namespace raccoon;

controllers::obs_avoid::obs_avoid(agents::agent_player* ape) :
  player_controller("obsAvoid",ape),speed(0),turnrate(0) {
  my_lp = ape->get_laser();
  my_pp = ape->get_p2d();
}

bool controllers::obs_avoid::is_valid() {
    return my_lp != NULL && my_pp != NULL;
}

bool controllers::obs_avoid::initialize() {
  std::cout << "obs_avoid initializing for " << my_client << std::endl;
  
  speed = 0;
  turnrate = 0;

  return true;
}

bool controllers::obs_avoid::start_guts() {
  my_pp->SetMotorEnable (true);
  my_client->Read();
  return true;
}

bool controllers::obs_avoid::start_guts(arguments& cargo) { 
    return start_guts(); 
}

bool controllers::obs_avoid::monitor() {
  my_client->Read();

  // go into read-think-act loop
  double minR = my_lp->GetMinRight();
  double minL = my_lp->GetMinLeft();
  
  // laser avoid (stolen from esben's java example)
  std::cout << "minR: " << minR
	    << " minL: " << minL
	    << std::endl;
  
  //JOSH: Changed subtracted value from 100 to 200 in order
  //to get this working with latest versions of player/stage
  //(11/10/2010).
  double l = (1e5*minR)/500-250;
  double r = (1e5*minL)/500-250;
  
  cout << "Adjusted r: " << r << " l: " << l << endl;

  if (l > 100)
    l = 100;
  if (r > 100)
    r = 100;

  
  speed = (r+l)/1e3;
  
  //JOSH: Added multiplication by 10 to get this working with
  //latest version of player/stage (11/10/2010).
  turnrate = (r-l)*15;
  turnrate = limit(turnrate, -40.0, 40.0);
  turnrate = dtor(turnrate);
  
  std::cout << "speed: " << speed
	    << " turn: "  << turnrate
	    << std::endl;
  
  // write commands to robot
  my_pp->SetSpeed(speed, turnrate);
  
  return true;

}

bool controllers::obs_avoid::abort() {
  speed = 0;
  turnrate = 0;
  my_pp->SetSpeed(0, 0);
  return true;
}

bool controllers::obs_avoid::shutdown() {
  return true;
}

bool controllers::obs_avoid::publish_grammar(umbc::command_grammar& cg) {
  return true;
}
