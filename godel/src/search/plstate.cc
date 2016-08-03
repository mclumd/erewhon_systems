#include "plstate.h"
#include "globals.h"

#include <iostream>
#include <sstream>

#include <string>
#include <vector>
#include <unordered_map>

using namespace std;

PLState::PLState (istream &in) {
    check_magic (in, "begin_plstate");
    in >> ws;
    
    int num_atoms;
    in >> num_atoms;
    in >> ws;

    for (int i = 0; i < num_atoms; i++) {
        string line, pred, word;
        vector<string> args;
        getline (in, line);
        stringstream ss (line);

        getline (ss, pred, ' ');

        while (getline(ss, word, ' ')) {
            args.push_back (word);
        }

        /*
        cout << "predicate is " << predicate << endl;
        cout << "args are:" << endl;
        for (int i = 0; i < args.size(); i++) 
            cout << "-- " << args[i] << endl; 
        */
        
        // now add the new atom to the state object
        add_atom (make_pair(pred, args));
    }

    check_magic (in, "end_plstate");
}

void PLState::dump () const {
    for (auto it = state.begin(); it != state.end(); it++) {
        cout << it->first << ":" << endl;
        for (auto args_it = (it->second).begin(); args_it != (it->second).end(); args_it++) {
            cout << "-- "; 
            for (int i = 0; i < args_it->size(); i++)
                cout << (*args_it)[i] << " ";
            cout << endl;
        }
    }
}

void PLState::progress_state (const Operator &op) {
    // cout << "trying to apply operator " << op.get_name (); 
    const vector<PrePost> &op_prepost = op.get_pre_post ();
    // cout << "prepost is of size " << op_prepost.size() << endl;  

    // for each pre_post, do the following
    for (int i = 0; i < op_prepost.size(); i++) {
        const PrePost &pp = op_prepost[i];
        // cout << "var " << pp.var << ", pre = " << pp.pre << ", post = " << pp.post << endl; 

        // original atom names for del and add effects

        // handling delete effect ... 
        if (pp.pre != -1) { // if equal to -1, then can be anything, so nothing to del
            string pre_fact_name = g_fact_names[pp.var][pp.pre];
            // cout << "pre_fact_name is " << pre_fact_name << endl;

            if (pre_fact_name != "<none of those>") {
                const pair<string, vector<string> > parsed_atom = parse_fact_name (pre_fact_name);
                bool status = remove_atom (parsed_atom);
                if (!status)
                    cout << "status=false, something strange is going on in progress_state!" << endl;
                // cout << "finished removing pre" << endl;
            }
        }
        
        // now handling post ... 
        string post_fact_name = g_fact_names[pp.var][pp.post];
        // cout << "post_fact_name is " << post_fact_name << endl;
        
        // same for add effect
        if (post_fact_name != "<none of those>") {
            const pair<string, vector<string> > parsed_atom = parse_fact_name (post_fact_name);
            add_atom (parsed_atom);
            // cout << "finished adding post" << endl;
        }
    }
}

void PLState::regress_state (const Operator &op) {
    cout << "trying to reverse operator " << op.get_name (); 
    const vector<PrePost> &op_prepost = op.get_pre_post ();
    cout << "prepost is of size " << op_prepost.size() << endl;  

    // for each pre_post, do the following
    for (int i = 0; i < op_prepost.size(); i++) {
        const PrePost &pp = op_prepost[i];
        cout << "var " << pp.var << ", pre = " << pp.pre << ", post = " << pp.post << endl; 

        // now removing post from the state ...  
        string post_fact_name = g_fact_names[pp.var][pp.post];
        cout << "post_fact_name is " << post_fact_name << endl;
        
        // same for add effect
        if (post_fact_name != "<none of those>") {
            const pair<string, vector<string> > parsed_atom = parse_fact_name (post_fact_name);
            bool status = remove_atom (parsed_atom);
            if (!status)
                cout << "status=false, something strange is going on in regress_state!" << endl;
            cout << "finished removing post" << endl;
        }

        // now adding pre to the state ... 
        if (pp.pre != -1) { // if equal to -1, then can be anything, so nothing to add
            string pre_fact_name = g_fact_names[pp.var][pp.pre];
            cout << "pre_fact_name is " << pre_fact_name << endl;

            if (pre_fact_name != "<none of those>") {
                const pair<string, vector<string> > parsed_atom = parse_fact_name (pre_fact_name);
                add_atom (parsed_atom);
                cout << "finished adding pre" << endl;
            }
        }
    }
}

void PLState::add_atom (const pair<string, vector<string> > &add_atom) {
    hash_state::iterator state_it = state.find (add_atom.first);
    if (state_it != state.end()) {
        args_collection &arg_set = state_it->second;
        arg_set.insert (add_atom.second);
    }
    else { // pred being added for the first time
        args_collection new_arg_set;
        new_arg_set.insert (add_atom.second);
        state.insert (make_pair(add_atom.first, new_arg_set));
    }
}

bool PLState::remove_atom (const pair<string, vector<string> > &del_atom) {
    hash_state::iterator state_it = state.find (del_atom.first);
    if (state_it != state.end()) {
        args_collection &arg_set = state_it->second;
        int num_erased = arg_set.erase (del_atom.second);
        if (num_erased != 0) {
            cout << "stuff got erased" << endl;
            // if arg_set is now empty, remove pred from state object
            if (arg_set.empty())
                state.erase (del_atom.first);
            return true;
        }
        else {
            cout << "predicate itself not found" << endl;
            return false;
        }
    }

    else return false;
}

void PLState::output (ofstream &out) {
    string plstate_str = to_str ();
    out << plstate_str;
}

string PLState::to_str () {
    // cout << "entered output()" << endl;
    stringstream out;
    out << "(";
    for (auto plstate_it = state.begin(); plstate_it != state.end(); plstate_it++) {
        string pred = plstate_it->first;
        bool is_goal = (pred == "goal");
        args_collection &ac = plstate_it->second;

        for (auto arg_it = ac.begin(); arg_it != ac.end(); arg_it++) {
            const vector<string> &args = *arg_it;
            vector<string>::const_iterator it = args.begin();
            if (is_goal) {
                pred = *it;
                it++;
                out << "(goal ";
            }
            
            out << "(" << pred; 

            while (it != args.end()) {
                out << " " << *it;
                it++;
            }

            out << ")"; // for the inner term
            if (is_goal)
                out << ")" << " ";
            else out << " ";
        }
    }
    out << ")";

    return out.str ();

}

// const args_collection &get_args_for_pred (const string &pred) {
// return 
