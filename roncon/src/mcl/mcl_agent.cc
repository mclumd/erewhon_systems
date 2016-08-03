#include "mcl_agent.h"

using namespace raccoon;
using namespace raccoon::agents;
using namespace mclMA;
using namespace mclMA::observables;
using namespace std;

bool mcl_agent::initialize()
{
    string key = peel()->get_name();
    cout << "Initializing MCL with key: " << key << endl;
    initializeMCL(key, 0);
    cout << "Configuring MCL with domain roncon and agent type: "
         << peel()->class_name() << endl;
    configureMCL(key, "roncon", class_name());
    
    //Add sensors.
    //TODO: extend agent_player to return complete lists
    //and add iteration here.
    //TODO: it would be better to wrap all of these proxies 
    //with some generic observable class.
    //TODO: verify the correctness/semantics of the various 
    //codes used here from MCL header APICodes.h
    LaserProxy* laser = peel->get_laser();
    if(laser != NULL) {
        cout << "Adding MCL observable: " << *laser << endl;
        string devname = laser->getInterfaceStr();
        declare_observable_self(key, devname+".right");
        set_obs_prop_self(key, devname+".right", PROP_DT, DT_RATIONAL);
        set_obs_prop_self(key, devname+".right", PROP_SC, SC_SPATIAL);
        declare_observable_self(key, devname+".left");
        set_obs_prop_self(key, devname+".left", PROP_DT, DT_RATIONAL);
        set_obs_prop_self(key, devname+".left", PROP_SC, SC_SPATIAL);
    }
    //JOSH: next, send an initial update.  Then, we need to
    //update/monitor in the monitor call and deal with expectations in
    //the controller wrappers. 





