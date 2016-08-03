#include "method.h"
#include "variable.h"
#include "helper_functions.h"

#include <iostream>
#include <fstream>
#include <cassert>

using namespace std;

Method::Method(istream &in, const vector<Variable *> variables) {
    check_magic (in, "begin_method");
    in >> ws;

    getline (in, name);

    int num_goals;
    in >> num_goals;

    goal.reserve(num_goals);

    for (int i = 0; i < num_goals; i++) {
        int varNo, val;
        in >> varNo >> val;
        goal.push_back(VarVal(variables[varNo], val));
    }

    int num_prevails;
    in >> num_prevails;

    prevail.reserve(num_prevails);

    for (int i = 0; i < num_prevails; i++) {
        int varNo, val;
        in >> varNo >> val;
        prevail.push_back(VarVal(variables[varNo], val));
    }

    int num_subgoals;
    in >> num_subgoals;

    subgoals.reserve(num_subgoals);

    for (int i = 0; i < num_subgoals; i++) {
        int num_vars_in_subgoal;
        in >> num_vars_in_subgoal;
        subgoals.push_back(Subgoal());
        Subgoal &current_subgoal = subgoals[i];
        for (int j = 0; j < num_vars_in_subgoal; j++) {
            int varNo, val;
            in >> varNo >> val;
            // cout << "var is " << varNo << ", val is " << val << endl;
            current_subgoal.push_back(VarVal(variables[varNo], val));
        }
        // cout << "size of current_subgoals is " << current_subgoal.size() << endl;
    }
    
    check_magic(in, "end_method");
}

// Pretty prints the method
void Method::dump() const {
    cout << name << endl;

    cout << goal[0].var << endl;
    cout << "goal:" << endl;
    for (int i = 0; i < goal.size(); i++) {
        cout << "  " << goal[i].var->get_name() << " := " << goal[i].val << endl;
    }

    cout << "preconditions:" << endl;
    for (int i = 0; i < prevail.size(); i++) {
        cout << "  " << prevail[i].var->get_name() << " := " << prevail[i].val << endl;
    }

    cout << "subgoals:" << endl;
    for (int i = 0; i < subgoals.size(); i++) {
        cout << "  subgoal " << i << endl;
        Subgoal s = subgoals[i];
        for (int j = 0; j < s.size(); j++) {
            cout <<"  -- " << s[j].var->get_name() << " := " << s[j].val << endl;
        }
    }
}

void Method::generate_cpp_input(ofstream &outfile) const {
    outfile << "begin_method" << endl;
    outfile << name << endl;
    outfile << goal.size() << endl;
    for (int i = 0; i < goal.size(); i++) {
        outfile << goal[i].var->get_level() << " " << goal[i].val << endl;
    }
    outfile << prevail.size() << endl;
    for (int i = 0; i < prevail.size(); i++) {
        outfile << prevail[i].var->get_level() << " " << prevail[i].val << endl;
    }
    outfile << subgoals.size() << endl;
    for (int i = 0; i < subgoals.size(); i++) {
        Subgoal s = subgoals[i];
        outfile << s.size() << endl;
        for (int j = 0; j < s.size(); j++) {
            outfile << s[j].var->get_level() << " " << s[j].val << endl;
        }
    }
    outfile << "end_method" << endl;
}

/* 
 * at this point, doing a naive check of goal \subseteq prevail that is O(N^2)
 * can do something better with sets or by sorting the two vectors. 
 * but since |goal| is typically small, the current code usually ends up being 
 * pretty efficient. 
*/ 
bool Method::is_redundant() const {
    if (goal.empty())
        return true;
    else if (subgoals.empty())
        return true;

    // this part determines if goals \subseteq prevail. 
    for (int i = 0; i < goal.size(); i++) {
        VarVal goal_part = goal[i];
        bool goal_subset_of_prevail = false;
        for (int j = 0; j < prevail.size(); j++) {
            cout << "prev: " << prevail[j].var << ":" << prevail[j].val << ", goal - " << goal_part.var << ":" << goal_part.val << endl;
            // if goal_part \in prevail ...
            if (prevail[j].var == goal_part.var && prevail[j].val == goal_part.val) {
                cout << "equality!" << endl;
                goal_subset_of_prevail = true;
                break;
            }
        }
        // if it reaches here, goal_part not contained in prevail, 
        // implying that method is not redundant. So return false
        if (goal_subset_of_prevail == false) {
            cout << "This method is not redundant" << endl;
            return false;
        }
    }
    
    cout << "This method is redundant" << endl;
    // if code reaches here, then all goal parts are contained in prevail. 
    // so method is redundant. 
    return true;
}

void strip_methods(vector<Method> &methods) {
    cout << "Entered strip_methods ..." << endl;
    int num_good_methods = 0;
    for (int i = 0; i < methods.size(); i++) {
        cout << "\n\nMethod " << i << ":" << endl;
        methods[i].dump();
        strip_unimportant_vars_from_formula (methods[i].get_goal());
        strip_unimportant_vars_from_formula (methods[i].get_prevail());
        vector<Method::Subgoal> sg = methods[i].get_subgoals();
        int num_subgoals = 0;
        for (int j = 0; j < sg.size(); j++) {
            strip_unimportant_vars_from_formula (sg[j]);
            if (!(sg[j].empty())) {
                sg[num_subgoals++] = sg[j];
            }
        }
        sg.erase(sg.begin() + num_subgoals, sg.end());
        
        // at this point, have removed unimportant vars from goal, prevail and subgoals
        // have also removed subgoals that have become empty as a result
        // now to check if method is redundant ...
        
        if (!methods[i].is_redundant()) {
            methods[num_good_methods++] = methods[i];
        }
    }
    methods.erase(methods.begin() + num_good_methods, methods.end());
}

void strip_unimportant_vars_from_formula (vector<Method::VarVal> formula) {
    int new_index = 0;
    for (int i = 0; i < formula.size(); i++) {
        if (formula[i].var->get_level() != -1) {
            formula[new_index++] = formula[i];
        }
    }
    formula.erase(formula.begin() + new_index, formula.end());
}





