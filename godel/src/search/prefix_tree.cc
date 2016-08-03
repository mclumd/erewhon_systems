#include <string>
#include <vector>
#include <iostream>
#include <map>

#include "lifted_method.h"
#include "plstate.h"
#include "prefix_tree.h"

using namespace std;

Prefix_Tree_Node::Prefix_Tree_Node (string given_var, string given_val) {
    var = given_var;
    children.insert (make_pair (given_val, (Prefix_Tree_Node *) NULL));
    // children.insert (pair<string, Prefix_Tree_Node*> (given_val, NULL));
}

Prefix_Tree::Prefix_Tree () {
    root = NULL;
}

/*
 * This function initializes a prefix_tree from a binding list. 
 */
Prefix_Tree::Prefix_Tree (vector<Binding_List> &binding_lists) {
    for (int i = 0; i < binding_lists.size (); i++) {
        Binding_List &binding_list = binding_lists[i];
        assert (binding_list.vars.size () == binding_list.vals.size ());
        for (int j = 0; i < binding_list.vars.size (); i++) {
        

    }
}

bool Prefix_Tree::add_binding (Literal &pred, vector<string> &bindings) {
    vector<string> &vars = pred.args;
    vector<pair<int, string> > vars_in_tree;
    vector<string> vars_not_in_tree;
    map<string, int>::iterator level_it;
    for (auto var_it = vars.begin (); var_it != vars.end (); var_it++) {
        level_it = var_levels.find (*var_it);
        if (level_it != var_levels.end ()) { // var is already in tree
            vars_in_tree.push_back (make_pair (level_it->second, *var_it));
        }
        
        else {
            vars_not_in_tree.push_back (*var_it);
        }
    }
}

