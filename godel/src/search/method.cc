#include "method.h"
#include "globals.h"
#include "lifted_method.h"

#include <iostream>
#include <fstream>
#include <cassert>
#include <algorithm>
#include <map>
#include <sstream>

using namespace std;

Method::Method(istream &in)
    : Option (METHOD) {
    check_magic (in, "begin_method");
    in >> ws;

    getline (in, name);

    int num_goals;
    in >> num_goals;

    goal.reserve(num_goals);

    for (int i = 0; i < num_goals; i++) {
        int varNo, val;
        in >> varNo >> val;
        goal.push_back(VarVal(varNo, val));
    }

    int num_prevails;
    in >> num_prevails;

    prevail.reserve(num_prevails);

    for (int i = 0; i < num_prevails; i++) {
        int varNo, val;
        in >> varNo >> val;
        prevail.push_back(VarVal(varNo, val));
    }

    int num_subgoals;
    in >> num_subgoals;

    subgoals.reserve(num_subgoals);

    for (int i = 0; i < num_subgoals; i++) {
        int num_vars_in_subgoal;
        in >> num_vars_in_subgoal;
        goal_formula sg;
        subgoals.push_back(sg);
        goal_formula &sg_ref = subgoals[i];
        for (int j = 0; j < num_vars_in_subgoal; j++) {
            int varNo, val;
            in >> varNo >> val;
            // cout << "var is " << varNo << ", val is " << val << endl;
            sg_ref.push_back(make_pair(varNo, val));
        }

        subgoal_set.insert (subgoal_set.end(), sg_ref.begin(), sg_ref.end());

        sort (sg_ref.begin(), sg_ref.end());
        // cout << "size of current_subgoals is " << current_subgoal.size() << endl;
    }

    sort (subgoal_set.begin(), subgoal_set.end()); 
    goal_formula::iterator it = unique (subgoal_set.begin(), subgoal_set.end());
    subgoal_set.resize (it - subgoal_set.begin());
    
    check_magic(in, "end_method");
}

Method::Method (LiftedMethod &m, map<string, string> &m_grounding) 
    : Option (METHOD) {

    // set name
    stringstream ss;
    ss << m.get_name ();
    const vector<string> &lm_args = m.get_args(); 
    for (int i = 0; i < lm_args.size(); i++)
        ss << " " << m_grounding.find(lm_args[i])->second;
    name = ss.str();    

    // set goal
    const Conjunction &lm_g = m.get_goal (); 
    for (int i = 0; i < lm_g.size(); i++) {
        pair<int, int> &g_i = g_literals_to_num_map.find(lm_g[i].to_str(m_grounding))->second;
        goal.push_back (VarVal(g_i.first, g_i.second));
    }
    // cout << "did preconditions" << endl;

    /*
    // set precondition
    const Conjunction &lm_pre = m.get_pre (); 
    for (int i = 0; i < lm_pre.size(); i++) {
        string pre_i_str = lm_pre[i].to_str(m_grounding); 
        cout << "pre_i_str is " << pre_i_str << endl;
        pair<int, int> &pre_i = g_literals_to_num_map.find(pre_i_str)->second;
        goal.push_back (VarVal(pre_i.first, pre_i.second));
    }
    */

    // set subgoals
    const vector<Conjunction> &lm_subs = m.get_subgoals (); 
    for (int i = 0; i < lm_subs.size(); i++) {
        const Conjunction &lm_sub_i = lm_subs[i];
        goal_formula sg;
        subgoals.push_back(sg);
        goal_formula &sg_ref = subgoals[i];
        for (int j = 0; j < lm_sub_i.size(); j++) {
            pair<int, int> &lm_sub_i_j = g_literals_to_num_map.find(lm_sub_i[j].to_str(m_grounding))->second;
            sg_ref.push_back (lm_sub_i_j);
        }
        
        subgoal_set.insert (subgoal_set.end(), sg_ref.begin(), sg_ref.end());
        sort (sg_ref.begin(), sg_ref.end());
    }

    sort (subgoal_set.begin(), subgoal_set.end()); 
    goal_formula::iterator it = unique (subgoal_set.begin(), subgoal_set.end());
    subgoal_set.resize (it - subgoal_set.begin());
}

// Pretty prints the method
void Method::dump() const {
    cout << name << endl;

    cout << "goal:" << endl;
    for (int i = 0; i < goal.size(); i++) {
        cout << "  " << g_variable_name[goal[i].var] << " := " << goal[i].val << endl;
    }

    cout << "preconditions:" << endl;
    for (int i = 0; i < prevail.size(); i++) {
        cout << "  " << g_variable_name[prevail[i].var] << " := " << prevail[i].val << endl;
    }

    cout << "subgoals:" << endl;
    for (int i = 0; i < subgoals.size(); i++) {
        cout << "  subgoal " << i << endl;
        const goal_formula &s = subgoals[i];
        for (int j = 0; j < s.size(); j++) {
            cout <<"  -- " << g_variable_name[s[j].first] << " := " << s[j].second << endl;
        }
    }

    cout << "subgoals set:" << endl;
    for (int i = 0; i < subgoal_set.size(); i++)
        cout << "  " << subgoal_set[i].first << " := " << subgoal_set[i].second << endl; 
}
