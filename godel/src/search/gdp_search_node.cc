#include "gdp_search_node.h"
#include "globals.h"

// functions for GDP_Search_Node are below:

GDP_Search_Node::GDP_Search_Node (State state, GoalList glist) {
    s = &state;
    gl = &glist;
    cout << "after making a copy of goal_list, the copy looks like this:" << endl;
    gl->dump();
    cout << "address of new gl is " << gl << endl;
}

GDP_Search_Node::GDP_Search_Node (State *input_s, GoalList *input_gl) {
    s = input_s;
    gl = input_gl;
}

GDP_Search_Node::GDP_Search_Node (const GDP_Search_Node &other) {
    // cout << "gdp_search_node copy constructor called" << endl;
    s = other.get_stateptr();
    gl = other.get_glptr();
}

bool GDP_Search_Node::operator== (const GDP_Search_Node &other) const {
    State *other_s = other.get_stateptr ();
    GoalList *other_gl = other.get_glptr ();

    return (*s == *other_s) && (*gl == *other_gl);
}

State *GDP_Search_Node::get_stateptr () const {return s;}
GoalList *GDP_Search_Node::get_glptr () const {return gl;} 

/*
size_t gdp_search_node_hash (const GDP_Search_Node &entry) {
    const State &s = *(entry.get_stateptr());
    const GoalList *gl = entry.get_glptr();
    int hash = 0;

    for (int i = 0; i < g_variable_name.size(); i++)
            hash += i * (s[i] + 1);

    hash += gl->hash();

    return hash;
}
*/
