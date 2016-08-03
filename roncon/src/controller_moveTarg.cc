/*
 *  move_to_targ based off of Sam's turn90
 */

#include "arguments.h"
#include "controller_moveTarg.h"
#include "agent_player.h"
#include <iostream>

using namespace std;
using namespace raccoon;

#define RAYS 32

//We're using VFH instead of the standard position as the GoTo
//function is not supported for the pioneers.  However, VFH can be
//added on top of the p2os position proxy to support this.  Also note
//that this code assumes that gIndex 0 is the position proxy of the
//robot (in the config file, it'll be position2dproxy:0) and VFH is at
//position2dproxy:1, hence the "+1".

controllers::move_to_target::move_to_target(agents::agent_player* ape) :
  player_controller("moveTarg",ape),targetX(0),targetY(0),ramp_in(0) {
  my_client=ape->get_client();
  my_pp=ape->get_p2d();
  my_vfh=ape->get_vfh();
};

bool controllers::move_to_target::is_valid() {
    return my_pp != NULL && my_vfh != NULL;
}

bool controllers::move_to_target::initialize() {
  targetX=0;
  targetY=0;
  my_client->Read();
  my_vfh->SetOdometry(0,0,0);  
  run=false;
  return true;
}

namespace raccoon {
  assumed_dbl_arguments _controller_movetarg_defaults(1,1);
}

bool controllers::move_to_target::start_guts() {
    cout << "Calling through default arg wrapper." << endl;
  return start_guts(_controller_movetarg_defaults);
}

bool controllers::move_to_target::start_guts(arguments& cargo) {
  player_controller::start_guts(cargo);

  targetX=cargo.arg_as_dbl_by_index(0);
  targetY=cargo.arg_as_dbl_by_index(1);
  ramp_in=0;

  cout << " start_moveTarg args = " << cargo.describe() << endl;

  run=true;
  try
  {
    using namespace PlayerCc;

    std::cout << my_client << std::endl;
    // Got to turn the motors on.  ;-)
    my_pp->SetMotorEnable (true);

    //Just checking some values
    cout << "X is: " << my_pp->GetXPos() << " target=" << targetX << endl;
    cout << "Y is: " << my_pp->GetYPos() << " target=" << targetY << endl;
    my_client->Read();  //Refreshing data

    //Probably not necessary, but it doesn't hurt to make sure all the
    //motors are on.
    my_vfh->SetMotorEnable (true);

    //This fires off the -90 degree turn (note the args are x coord, y
    //coord, angle) also note that when the my_client fires up, it thinks
    //it's at (0,0,0) unless you call SetOdometry.
    my_vfh->GoTo(targetX,targetY,0);

    cout << "goto initiated." << endl;

  }
  catch (PlayerCc::PlayerError e)
  {
    std::cerr << e << std::endl;
    return false;
  }

  return true;
}

bool controllers::move_to_target::monitor() {
  if (!self_deactivated()) {
    try {
      using namespace PlayerCc;
      
      //Throw in some reads to burn some time as the motors spool up.
      //Normally this won't be needed, but it's such a simple program I
      //threw them in.  One could also spawn off boost threads (but
      //that's for later).
      
      my_client->Read();
      
      cout << "  X/Y : " << my_pp->GetXPos() << "/" << my_pp->GetYPos() 
	   << " tX/tY: " << dec << targetX << "/" << dec << targetY
	   << " dX/dY: " << my_pp->GetXSpeed() << "/" << my_pp->GetYSpeed() 
	   << endl;
      
      //If we've stopped moving, kill this loop.
      
      if ((my_pp->GetYSpeed() > -0.01) && (my_pp->GetYSpeed() < 0.01) &&
	  (my_pp->GetXSpeed() > -0.01) && (my_pp->GetXSpeed() < 0.01) &&
	  (my_pp->GetYawSpeed() > -0.01) && (my_pp->GetYawSpeed() < 0.01) &&
	  near_target()) {
	cout << " termination conditions met, ending controller" << endl;
	self_deactivate();
      }
      
    }
    catch (PlayerCc::PlayerError e)
      {
	std::cerr << e << std::endl;
	return false;
      }
  }
  return true;
}

bool controllers::move_to_target::shutdown() {
  try {
    my_client->Read();
    //Hooray!  Now to shut 'er down.
    cout << "All done!\n" ;
    my_pp->SetSpeed(0,0,0);
    my_pp->SetMotorEnable (false);
    my_vfh->SetMotorEnable (false);
    run=false;
  }
  catch (PlayerCc::PlayerError e)
  {
    std::cerr << e << std::endl;
    return false;
  }

  return true;
};


bool controllers::move_to_target::abort() {
  my_pp->SetSpeed(0,0,0);
  my_pp->SetMotorEnable (false);
  my_vfh->SetMotorEnable (false);
  run=false;
  return true;
}

bool controllers::move_to_target::publish_grammar(umbc::command_grammar& cg) {
  return true;
}

bool controllers::move_to_target::near_target() {
  double dist = sqrt((my_pp->GetXPos()-targetX)*(my_pp->GetXPos()-targetX)+
		     (my_pp->GetYPos()-targetY)*(my_pp->GetYPos()-targetY));
  return (dist < 0.5);
}
