#ifndef PLSTATE_H
#define PLSTATE_H

/* This file encodes the class definition of a Predicate Logic 
 * version of the state object. The state here is a conjunction of 
 * literals (as encoded in the pddl representation)
 *
 * Right now, the state is encoded as an unordered_map mapping the
 * predicate name to the set of all n-tuples of arg sets corresponding
 * to that predicate in the state currently. 
 *
 * e.g. if the set contained ((p1 A B) (p1 C D) (p2 E F) (p3)), it would be
 * stored as:
 * p1 -> {(A B), (C, D)}
 * p2 -> {(E F)}
 * p3 -> {()}
 */

#include <string>
#include <vector>
#include <unordered_map>
#include <set>
#include <fstream>

#include "operator.h"

using namespace std;

typedef set<vector<string> > args_collection;
typedef unordered_map<string, args_collection> hash_state;

class PLState {
    hash_state state;

    public:
    PLState (istream &in);
    bool remove_atom (const pair<string, vector<string> > &del_effect);
    void add_atom (const pair<string, vector<string> > &add_effect);

    void progress_state (const Operator &op);
    void regress_state (const Operator &op);

    // const args_collection &get_args_for_pred (const string &pred);

    // vector<map<string, string> > all_possible_bindings (const LiftedMethod &m);
    
    // viewers
    void dump () const;

    void output (ofstream &out); 
    string to_str ();

}; 

#endif
