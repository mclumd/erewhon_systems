#ifndef PREFIX_TREE_H
#define PREFIX_TREE_H

/*  This class defines the main data structure
 *  for computing bindings for methods
 */

#include <string>
#include <vector>
#include <iostream>
#include <map>

#include "lifted_method.h"
#include "plstate.h"

using namespace std;

struct Binding_List {
    vector<string> vars;
    vector<string> vals;
}

struct Prefix_Tree_Node {
    string var;
    map<string, Prefix_Tree_Node *> children;

    Prefix_Tree_Node (string var, string val);
    // void add_child (string var, string val);
};

class Prefix_Tree {
    map<string, int> var_levels;
    Prefix_Tree_Node *root;

    Prefix_Tree ();
    Prefix_Tree (vector<Binding_List> &binding_list);

    bool add_binding (Literal &pred, vector<string> &bindings);

    bool find_satisfying_assignments (PLState &state, Conjunction &f);
};

Prefix_Tree &get_bindings_for_predicate (map<string, int> &var_levels, PLState &state, Literal &l);

#endif
