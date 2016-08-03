#include <algorithm>

#include "umbc/logger.h"
#include "umbc/token_machine.h"
#include "agent_player.h"
#include "player_configurer.h"
#include "controller.h"
#include "controller_obsAvoid.h"
#include "controller_turnTarg.h"
#include "controller_moveTarg.h"

using namespace raccoon;

agents::agent_player::agent_player(string aname,string hostname, int port) :
  agent_basic(aname),my_host(hostname),my_port(port),my_client(NULL) {
  my_client = new PlayerClient(my_host,my_port);
#ifdef OLD_CONFIGURE
  set_status(player_config::configure(this));
#endif
};

bool agents::agent_player::initialize() {
#ifndef OLD_CONFIGURE
  // get sensor proxies...
  cout << "getting proxies for " << get_name() << endl;
  my_client->RequestDeviceList();
  std::list<playerc_device_info_t> dev_l = my_client->GetDeviceList();
  for (std::list<playerc_device_info_t>::const_iterator dii = dev_l.begin();
       dii != dev_l.end();
       dii++) {
    //cout << " device: " << *dii << endl;
    //cout << " host: " << dii->addr.host << endl;
    //cout << " robot: " << dii->addr.robot << endl;
    //cout << " interf: " << dii->addr.interf << endl;
    //cout << " index: " << dii->addr.index << endl;
    switch(dii->addr.interf) {
        case PLAYER_LASER_CODE:
            add_laser(dii->addr.index);
            break;
        case PLAYER_POSITION2D_CODE:
            add_pp(dii->addr.index);
            break;
        default:
            cout << "No implemented proxy for device " 
                 << *dii << ", ignored." << endl;
    }
  }

  /* The VFH driver, layered on top of basic position/sensing
   * drivers, is used by some of the movement controllers.  See e.g.
   * controller_moveTarg.cc comments as well as the player
   * documentation on the VFH driver. */
  if(!lasers.empty() && !p2ds.empty()) {
      vector<Position2dProxy*>::iterator pos = 
        find_if(p2ds.begin(), p2ds.end(),
        bind2nd(not_equal_to<Position2dProxy*>(), NULL));
      if(pos != p2ds.end()) {
        add_vfh((*pos)->GetIndex());
      }
  }
  /* Now we will try creating each known type of controller for the
   * agent, and if it is valid (e.g. the agent has the necessary
   * sensors/effectors to support the controller) we will add it to
   * the available list.  This method is slightly backhanded; it
   * would be better to avoid creating the controllers in the first
   * place if they could not be used.  But as there's no way to
   * force derived classes to implement static functions, this seems
   * simplest without a more major code reorg. */
  /* It would also be an improvement to keep all known controllers in a
   * list so that they could be tried in a loop here. */
  controllers::controller *tempcont;
  /* obs_avoid */
  tempcont = new controllers::obs_avoid(this);
  if(tempcont->is_valid()) {
      add_controller(tempcont);
  } else {
      delete tempcont;
  }
  /* turn_to_target */
  tempcont = new controllers::turn_to_target(this);
  if(tempcont->is_valid()) {
      add_controller(tempcont);
  } else {
      delete tempcont;
  }
  /* move_to_target */
  tempcont = new controllers::move_to_target(this);
  if(tempcont->is_valid()) {
      add_controller(tempcont);
  } else {
      delete tempcont;
  }
#endif

  return agent_basic::initialize();
}

bool agents::agent_player::monitor() {
  return agent_basic::monitor();
}

bool agents::agent_player::shutdown() {
  return true;
}

string agents::agent_player::query(string q) {
  umbc::tokenMachine tm(q);
  string req = tm.nextToken();
  cout << " processing query at agent_player level: '"
       << req << "'" << endl;
  if (strncmp(req.c_str(),"describe",8)==0)
    return okay_msg(describe());
  else
    return agents::agent_basic::query(q);
}

string agents::agent_player::command(string c) {
  return agents::agent_basic::command(c);
}

bool agents::agent_player::publish_grammar(umbc::command_grammar& cg) {
  return agent_basic::publish_grammar(cg);
}

string agents::agent_player::describe() {
  string tv="< "+get_name()+" ";
  if (!lasers.empty()) tv+="laser ";
  if (!p2ds.empty()) tv+="posn2d ";
  if (!vfhs.empty()) tv+="vfh ";
  tv+= "(active: ";
  for (list<controller*>::const_iterator aci = active_controllers.begin();
       aci != active_controllers.end();
       aci++) {
    if ((*aci) == NULL)
      tv+= "NULL ";
    else
      tv+= (*aci)->get_name()+" ";
  }
  tv+=")";
  tv+=">";
  return tv;
}

bool agents::agent_player::add_laser(int gIndex) {
  if (gIndex >= lasers.size()) lasers.resize(gIndex+1,NULL);
  if (lasers[gIndex] == NULL) {
    try {
      LaserProxy* nlp = new LaserProxy(my_client,gIndex);
      lasers[gIndex]=nlp;
    }
    catch  (PlayerCc::PlayerError e) {
      umbc::uLog::annotate(umbc::UMBCLOG_ERROR,e.GetErrorStr());
      return false;
    }
    return true;
  }
  else {
    umbc::uLog::annotate(umbc::UMBCLOG_ERROR,
             "attempt to add a LaserProxy to \"" 
             + get_name() + "\" at an already-occupied index.");
    return false;
  }
}

bool agents::agent_player::add_pp(int gIndex) {
  if (gIndex >= p2ds.size()) p2ds.resize(gIndex+1,NULL);
  if (p2ds[gIndex] == NULL) {
    try {
      Position2dProxy* nlp = new Position2dProxy(my_client,gIndex);
      p2ds[gIndex]=nlp;
    }
    catch  (PlayerCc::PlayerError e) {
      umbc::uLog::annotate(umbc::UMBCLOG_ERROR,e.GetErrorStr());
      return false;
    }
    return true;
  }
  else {
    umbc::uLog::annotate(umbc::UMBCLOG_ERROR,
             "attempt to add a Postion2dProxy to \"" 
             + get_name() + "\" at an already-occupied index.");
    return false;
  }
}

/* gIndex here is the index of the p2d driver we are layering on.  As
 * per the comment in controller_moveTarg.cc, and the existing code
 * for adding both a position proxy and VFH driver proxy, we will
 * create this VFH with an index of gIndex+1. */
bool agents::agent_player::add_vfh(int gIndex) {
  if ((gIndex >= p2ds.size()) || (p2ds[gIndex] == NULL)) {
    umbc::uLog::annotate(umbc::UMBCLOG_ERROR,
             "attempt to add a VFH proxy to \"" 
             + get_name() + "\" based on non-existent position proxy.");
    return false;
  }
  else if ((gIndex < vfhs.size()) && (vfhs[gIndex] != NULL)) {
    umbc::uLog::annotate(umbc::UMBCLOG_ERROR,"attempt to add a VFH to \"" 
             + get_name() + "\" at an already-occupied index.");
    return false;
  }
  else {
    if (gIndex >= vfhs.size()) vfhs.resize(gIndex+1,NULL);
    try {
      Position2dProxy* vfh = new Position2dProxy(my_client,gIndex+1);
      vfhs[gIndex]=vfh;
    }
    catch  (PlayerCc::PlayerError e) {
      umbc::uLog::annotate(umbc::UMBCLOG_ERROR,e.GetErrorStr());
      return false;
    }
    return true;
  }
}

bool agents::agent_player::add_pp_vfh(int gIndex) {
  if ((gIndex < p2ds.size()) && (p2ds[gIndex] != NULL)) {
    umbc::uLog::annotate(umbc::UMBCLOG_ERROR,
             "attempt to add a Postion2dProxy to \"" 
             + get_name() + "\" at an already-occupied index.");
    return false;
  }
  else if ((gIndex < vfhs.size()) && (vfhs[gIndex] != NULL)) {
    umbc::uLog::annotate(umbc::UMBCLOG_ERROR,"attempt to add a VFH to \"" 
             + get_name() + "\" at an already-occupied index.");
    return false;
  }
  else {
    if (gIndex >= p2ds.size()) p2ds.resize(gIndex+1,NULL);
    try {
      Position2dProxy* nlp = new Position2dProxy(my_client,gIndex);
      p2ds[gIndex]=nlp;
    }
    catch  (PlayerCc::PlayerError e) {
      umbc::uLog::annotate(umbc::UMBCLOG_ERROR,e.GetErrorStr());
      return false;
    }
    if (gIndex >= vfhs.size()) vfhs.resize(gIndex+1,NULL);
    try {
      Position2dProxy* vfh = new Position2dProxy(my_client,gIndex+1);
      vfhs[gIndex]=vfh;
    }
    catch  (PlayerCc::PlayerError e) {
      umbc::uLog::annotate(umbc::UMBCLOG_ERROR,e.GetErrorStr());
      return false;
    }
    return true;
  }
}
