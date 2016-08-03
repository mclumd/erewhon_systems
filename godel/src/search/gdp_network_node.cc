#include "gdp_network_node.h"
#include "globals.h"

// functions for GDP_Network_Node are below:

GDP_Network_Node::GDP_Network_Node (State state, GoalNetwork gnetwork) {
    s = &state;
    gn = &gnetwork;
    cout << "after making a copy of goal_list, the copy looks like this:" << endl;
    gn->dump();
    cout << "address of new gn is " << gn << endl;
}

GDP_Network_Node::GDP_Network_Node (State *input_s, GoalNetwork *input_gn) {
    s = input_s;
    gn = input_gn;
}

GDP_Network_Node::GDP_Network_Node (const GDP_Network_Node &other) {
    // cout << "gdp_search_node copy constructor called" << endl;
    s = other.get_stateptr();
    gn = other.get_gnptr();
}

bool GDP_Network_Node::operator== (const GDP_Network_Node &other) const {
    State *other_s = other.get_stateptr ();
    GoalNetwork *other_gn = other.get_gnptr ();

    return (*s == *other_s) && (*gn == *other_gn);
}

State *GDP_Network_Node::get_stateptr () const {return s;}
GoalNetwork *GDP_Network_Node::get_gnptr () const {return gn;} 

/*
size_t gdp_search_node_hash (const GDP_Network_Node &entry) {
    const State &s = *(entry.get_stateptr());
    const GoalNetwork *gn = entry.get_gnptr();
    int hash = 0;

    for (int i = 0; i < g_variable_name.size(); i++)
            hash += i * (s[i] + 1);

    hash += gn->hash();

    return hash;
}
*/
