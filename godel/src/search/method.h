#ifndef METHOD_H
#define METHOD_H

#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <cassert>
#include <map>

#include "lifted_method.h"
#include "state.h"
#include "option.h"

using namespace std;

struct VarVal {
    int var;
    int val;
    VarVal(int v, int p): var(v), val(p) {}

    bool is_applicable(const State &state) const {
        assert(var >= 0 && var < g_variable_name.size());
        assert(val >= 0 && val < g_variable_domain[var]);
        return state[var] == val;
    }

    bool operator==(const VarVal &other) const {
        return var == other.var && val == other.val;
    }

    bool operator!=(const VarVal &other) const {
        return !(*this == other);
    }
};

typedef std::vector<VarVal> Subgoal;
typedef std::vector<std::pair<int, int> > goal_formula;

class Method : public Option {
private:
    string name;
    vector<VarVal> goal;
    vector<VarVal> prevail;
    vector<goal_formula> subgoals;
    goal_formula subgoal_set;

public:
    Method(istream &in);
    Method (LiftedMethod &m, map<string, string> &m_grounding);
    void dump() const;
    std::string get_name() const {return name; }
    const vector<VarVal> &get_prevail() const {return prevail; }
    const vector<VarVal> &get_goal() const {return goal; }
    const vector<goal_formula> &get_subgoals() const {return subgoals; }
    const goal_formula &get_subgoal_set() const {return subgoal_set; }
    const goal_formula &get_subgoal(int i) {return subgoals[i]; }
};

#endif




