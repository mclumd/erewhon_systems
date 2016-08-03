#include "gdp_network_cl.h"
#include "state.h"
#include "goal_network.h"

#include <unordered_set>

using namespace std;

// from here on, functions for GDP_Network_CL are defined

GDP_Network_CL::GDP_Network_CL (GDP_Network_Node &first_n) {
    closed_list.insert (first_n);
}

bool GDP_Network_CL::is_there (GDP_Network_Node &n) {
    unordered_set<GDP_Network_Node>::iterator it = closed_list.find (n);
    cout << "ran the find operation in network_cl" << endl;

    if (it == closed_list.end())
        return false;
    else return true;
}

bool GDP_Network_CL::add_node (GDP_Network_Node &n) {
    unordered_set<GDP_Network_Node>::hasher fn = closed_list.hash_function ();
    // cout << "adding the following node to the closed list" << endl;
    // cout << "state hash value: " << (n.get_stateptr ())->hash() << endl;
    // cout << "goal_list: " << endl;
    (n.get_gnptr ())->dump ();
    // cout << "hash value of new node is " << fn (n) << endl;
    cout << endl;
 
    const pair<unordered_set<GDP_Network_Node>::iterator, bool> &result = closed_list.insert (n);
    return result.second;
}

void GDP_Network_CL::dump () const {
    // hash<GDP_Network_Node> fn;
    unordered_set<GDP_Network_Node>::hasher fn = closed_list.hash_function ();
    for (auto a = closed_list.begin(); a != closed_list.end(); a++) {
        cout << "state: " << (a->get_stateptr ())->hash() << endl;
        // (a->get_stateptr ())->dump ();
        cout << "goal_list: " << endl;
        (a->get_gnptr ())->dump ();
        cout << "hash value is " << fn (*a) << endl;
        cout << endl;
    }
}
