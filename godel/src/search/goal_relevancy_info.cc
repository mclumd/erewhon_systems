#include <vector>
#include <map>
#include <algorithm>

#include "goal_relevancy_info.h"
#include "operator.h"
#include "method.h"

using namespace std;

//class Operator;
//struct PrePost;

// this function initializes the two maps, i.e. for operators and methods. It iterates through the variables g_operators and g_methods and populates the two maps.
GoalRelevancyInfo::GoalRelevancyInfo () {
    /* first populate relevant_ops_map 
     */
    for (int i = 0; i < g_operators.size(); i++) {
        Operator &op = g_operators[i];
        const vector<PrePost> &op_preposts = op.get_pre_post();
        for (int j = 0; j < op_preposts.size(); j++) {
            const PrePost &op_prepost = op_preposts[j];
            // the vector corresponding to the particular (varNo, val) effect
            // is retrieved
            vector<Operator *> &ops_list = relevant_ops_map[make_pair(op_prepost.var, op_prepost.post)];
            // now a pointer to this operator is inserted into ops_list
            ops_list.push_back(&op);
        }
    }

    // now do the same for methods
    for (int i = 0; i < g_methods.size(); i++) {
        Method &m = g_methods[i];
        const vector<VarVal> &m_goal = m.get_goal();
        for (int j = 0; j < m_goal.size(); j++) {
            const VarVal &m_varval = m_goal[j];
            // the vector corresponding to the particular (varNo, val) goal
            // is retrieved
            vector<Method *> &m_list = relevant_methods_map[make_pair(m_varval.var, m_varval.val)];
            // now a pointer to this operator is inserted into ops_list
            m_list.push_back(&m);
        }
    }
 
    // now iterate through the maps and sort the vectors
    map<pair<int, int>, vector<Operator *> >::iterator op_table_it;
    for (op_table_it = relevant_ops_map.begin(); op_table_it != relevant_ops_map.end(); op_table_it++) {
        vector<Operator *> &op_list = op_table_it->second;
        sort (op_list.begin(), op_list.end());
    }

    map<pair<int, int>, vector<Method *> >::iterator m_table_it;
    for (m_table_it = relevant_methods_map.begin(); m_table_it != relevant_methods_map.end(); m_table_it++) {
        vector<Method *> &m_list = m_table_it->second;
        sort (m_list.begin(), m_list.end());
    }
}

/* 
 * This function takes in a goal formula and generates 
 * a vector of relevant Operators and Methods. It assumes that 
 * the goal relevancy table has its 'values' (i.e. vectors of
 * Ops/Methods) in sorted order.
 */
void GoalRelevancyInfo::generate_relevant_ops_and_methods (
        const goal_formula &g,
        vector<Operator *> &rel_ops,
        vector<Method *> &rel_methods) {
    // generating relevant ops ... 
    int *num_rel_ops_per_goal = new int[g.size()];
    int num_rel_ops = 0;
    map<pair<int, int>, vector<Operator *> >::iterator it;
    for (int i = 0; i < g.size(); i++) {
        it = relevant_ops_map.find(g[i]);
        if (it != relevant_ops_map.end()) {
            num_rel_ops_per_goal[i] = (it->second).size();
        }

        else {
            num_rel_ops_per_goal[i] = 0;
        }

        num_rel_ops += num_rel_ops_per_goal[i];
        // cout << "num_rel_ops for goal " << i << " = " << num_rel_ops_per_goal[i] << endl;
    }

    // cout << "num_rel_ops = " << num_rel_ops << endl;
    // cout << rel_ops.size() << " " << rel_methods.size() << endl; 

    rel_ops.resize(num_rel_ops, '\0');
    int index = 0;
    for (int i = 0; i < g.size(); i++) {
        if (num_rel_ops_per_goal[i] != 0) {
            it = relevant_ops_map.find(g[i]);
            copy((it->second).begin(), (it->second).end(),rel_ops.begin() + index);
            index += num_rel_ops_per_goal[i];
        }
    }
    /*
    cout << "rel_ops is:" << endl;
    for (int i = 0; i < rel_ops.size(); i++) {
        cout << "[" << i << "] = " << rel_ops[i] << endl;
    }
    */

    //now do merge
    index = 0;
    for (int i = 0; i < g.size() - 1; i++) {
        index += num_rel_ops_per_goal[i];
        if (num_rel_ops_per_goal[i+1] != 0) {
            // cout << "entered for " << i << " and " << i+1 << endl;
            inplace_merge (
                rel_ops.begin(), 
                rel_ops.begin() + index, 
                rel_ops.begin() + index + num_rel_ops_per_goal[i+1]);
        }
    }

    /*
    cout << "rel_ops is:" << endl;
    for (int i = 0; i < rel_ops.size(); i++) {
        cout << "[" << i << "] = " << rel_ops[i]->get_name() << endl;
    }
    */

    // delete num_rel_ops_per_goal
    delete num_rel_ops_per_goal;

    // generating relevant methods ... 
    int *num_rel_methods_per_goal = new int[g.size()];
    int num_rel_methods = 0;
    map<pair<int, int>, vector<Method *> >::iterator it2;
    for (int i = 0; i < g.size(); i++) {
        it2 = relevant_methods_map.find(g[i]);
        if (it2 != relevant_methods_map.end()) {
            num_rel_methods_per_goal[i] = (it2->second).size();
        }

        else {
            num_rel_methods_per_goal[i] = 0;
        }

        num_rel_methods += num_rel_methods_per_goal[i];
        // cout << "num_rel_methods for goal " << i << " = " << num_rel_methods_per_goal[i] << endl;
    }

    // cout << "num_rel_methods = " << num_rel_methods << endl;
    //cout << rel_ops.size() << " " << rel_methods.size() << endl; 

    rel_methods.resize(num_rel_methods, '\0');
    index = 0;
    for (int i = 0; i < g.size(); i++) {
        if (num_rel_methods_per_goal[i] != 0) {
            it2 = relevant_methods_map.find(g[i]);
            copy((it2->second).begin(), (it2->second).end(),rel_methods.begin() + index);
            index += num_rel_methods_per_goal[i];
        }
    }

    /*
    cout << "rel_methods is:" << endl;
    for (int i = 0; i < rel_methods.size(); i++) {
        cout << "[" << i << "] = " << rel_methods[i] << endl;
    }
    */

    //now do merge
    index = 0;
    for (int i = 0; i < g.size() - 1; i++) {
        index += num_rel_methods_per_goal[i];
        if (num_rel_methods_per_goal[i+1] != 0) {
            // cout << "entered for " << i << " and " << i+1 << endl;
            inplace_merge (
                rel_methods.begin(), 
                rel_methods.begin() + index, 
                rel_methods.begin() + index + num_rel_methods_per_goal[i+1]);
        }
    }

    /*
    cout << "rel_methods:" << endl;
    for (int i = 0; i < rel_methods.size(); i++) {
        cout << "[" << i << "] = " << rel_methods[i] << " " << rel_methods[i]->get_name() << endl;
    }
    */

    // delete num_rel_methods_per_goal
    delete num_rel_methods_per_goal;
}

void GoalRelevancyInfo::generate_applicable_and_relevant_ops_and_methods (
        const goal_formula &g,
        vector<const Operator *> &applicable_ops,
        vector<const Method *> &applicable_methods,
        vector<const Operator *> &app_and_rel_ops,
        vector<const Method *> &app_and_rel_methods, 
        vector<const Operator *> &app_not_rel_ops) {
    vector<Operator *> rel_ops;
    vector<Method *> rel_methods;

    generate_relevant_ops_and_methods (g, rel_ops, rel_methods);
    // cout << "after generating relevant ops and methods, ops: " << rel_ops.size() << ", methods: " << rel_methods.size() << endl;

    cout << "Printing applicable ops here" << endl;
    cout << "applicable_ops:" << endl;
    for (int i = 0; i < applicable_ops.size(); i++) {
        cout << applicable_ops[i]->get_name () << endl;
    }

    cout << "Printing relevant ops here" << endl;
    cout << "rel_ops:" << endl;
    for (int i = 0; i < rel_ops.size(); i++) {
        cout << rel_ops[i]->get_name () << endl;
    }
    
    /*
    cout << "\n\napplicable_methods:" << endl;
    for (int i = 0; i < applicable_methods.size(); i++) {
        cout << applicable_methods[i] << ", ";
    }
    */

    set_intersection (
        applicable_ops.begin(), applicable_ops.end(),
        rel_ops.begin(), rel_ops.end(), 
        back_inserter (app_and_rel_ops));

    set_intersection (
        applicable_methods.begin(), applicable_methods.end(),
        rel_methods.begin(), rel_methods.end(), 
        back_inserter (app_and_rel_methods));

    set_difference (
        applicable_ops.begin(), applicable_ops.end(),
        rel_ops.begin(), rel_ops.end(), 
        back_inserter (app_not_rel_ops));

    cout << app_and_rel_ops.size() << " app_and_rel_ops:" << endl;
    for (int i = 0; i < app_and_rel_ops.size(); i++) {
        cout << "[" << i << "] = " << app_and_rel_ops[i]->get_name() << endl;
    }


    cout << app_and_rel_methods.size() << " app_and_rel_methods:" << endl;
    for (int i = 0; i < app_and_rel_methods.size(); i++) {
        cout << "[" << i << "] = " << app_and_rel_methods[i]->get_name() << endl;
    }

    cout << app_not_rel_ops.size() << " app_not_rel_ops:" << endl;
    for (int i = 0; i < app_not_rel_ops.size(); i++) {
        cout << "[" << i << "] = " << app_not_rel_ops[i]->get_name() << endl;
    }
}

void GoalRelevancyInfo::dump () {
    cout << "Operators' goal relevancy table:" << endl;
    map<pair<int, int>, vector<Operator *> >::iterator op_table_it;
    for (op_table_it = relevant_ops_map.begin(); op_table_it != relevant_ops_map.end(); op_table_it++) {
        const pair<int, int> &var_val = op_table_it->first;
        vector<Operator *> &op_list = op_table_it->second;
        cout << g_variable_name[var_val.first] << " := " << var_val.second << ":" << endl;
        for (int i = 0; i < op_list.size(); i++) {
            cout << "-- " << op_list[i]->get_name() << endl;
        }
    }

    cout << "Methods' goal relevancy table:" << endl;
    map<pair<int, int>, vector<Method *> >::iterator m_table_it;
    for (m_table_it = relevant_methods_map.begin(); m_table_it != relevant_methods_map.end(); m_table_it++) {
        const pair<int, int> &var_val = m_table_it->first;
        vector<Method *> &m_list = m_table_it->second;
        cout << g_variable_name[var_val.first] << " := " << var_val.second << ":" << endl;
        for (int i = 0; i < m_list.size(); i++) {
            cout << "-- " << m_list[i]->get_name() << endl;
        }
    }
}
