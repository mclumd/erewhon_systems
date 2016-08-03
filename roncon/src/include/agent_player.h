#ifndef RC_AGENT_GENERIC
#define RC_AGENT_GENERIC

#include "agent.h"
#include <string>
#include <vector>
#include <libplayerc++/playerc++.h>

namespace raccoon {
  namespace agents {
    
    using namespace std;
    using namespace PlayerCc;

    class agent_player : public agent_basic {
    public:
      agent_player(string aname,string hostname, int port);

      virtual bool initialize();
      virtual bool monitor();
      virtual bool shutdown();

      virtual string query  (string q);
      virtual string command(string c);

      virtual string class_name() { return "player_agent"; };
      // virtual string grammar_commname() { return ""; };
      virtual bool publish_grammar(umbc::command_grammar& cg);
      virtual string describe();

      bool add_laser(int gIndex);
      bool add_pp   (int gIndex);
      bool add_vfh  (int gIndex);
      bool add_pp_vfh(int gIndex);

      PlayerClient* get_client() { return my_client; };
      LaserProxy*   get_laser() { if (!lasers.empty()) return lasers[0]; };
      Position2dProxy* get_p2d() { if (!p2ds.empty()) return p2ds[0]; };
      Position2dProxy* get_vfh() { if (!vfhs.empty()) return vfhs[0]; };
      
    protected:
      string my_host;
      int    my_port;
      PlayerClient* my_client;

      vector<LaserProxy*>    lasers;
      vector<Position2dProxy*> p2ds;
      vector<Position2dProxy*> vfhs;

    };

  };
};


#endif
