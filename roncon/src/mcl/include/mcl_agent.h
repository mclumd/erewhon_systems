#ifndef RC_MCL_AGENT_H
#define RC_MCL_AGENT_H

#include "agent.h"
#include <string>

namespace raccoon {
    namespace agents {
        class mcl_agent : public agent_player {
          public:
            mcl_agent(agent* a) : agent("mcl-"+a->get_name()), inner_agent(a) {}
            virtual ~mcl_agent() {delete inner_agent;}

            virtual agent* peel() {return inner_agent;}
            virtual bool initialize();
          private:
            agent* inner_agent;
        }
    }
}

#endif /*MC_MCL_AGENT_H*/
