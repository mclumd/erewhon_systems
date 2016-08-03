#include <libplayerc++/playerc++.h>
#include "umbc/settings.h"
#include "agent_dispatcher.h"
#include "agent_player.h"

int main(int argc,char** argv) {
  using namespace std;
  using namespace PlayerCc;

  umbc::settings::args2SysProperties(argc,argv);

  raccoon::agents::agent_dispatcher_tcp my_dispatcher("dispatch");
  my_dispatcher.initialize();

  try {
    // raccoon::agents::agent_player the_agent("pizzle","localhost",6665);

    //     PlayerClient robot("localhost",6665);
    //     Position2dProxy pp(&robot, 0);
    //     LaserProxy lp(&robot, 0);
    
  }
  catch (PlayerCc::PlayerError e)
  {
    std::cerr << e << std::endl;
    return -1;
  }

  for (;;) { sleep(1);  };

  return -1;
}
