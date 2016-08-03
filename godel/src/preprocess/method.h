#ifndef METHOD_H
#define METHOD_H

#include <iostream>
#include <fstream>
#include <string>
#include <vector>

#include "variable.h"

using namespace std;

class Variable;

class Method {
public:
    struct VarVal {
        Variable *var;
        int val;
        VarVal(Variable *v, int p): var(v), val(p) {}
    };

    typedef vector<VarVal> Subgoal;

private:
    string name;
    vector<VarVal> goal;
    vector<VarVal> prevail;
    vector<Subgoal> subgoals;

public:
    Method(istream &in, const vector<Variable *> variables);
    void dump() const;
    vector<VarVal> get_prevail() const {return prevail; }
    vector<VarVal> get_goal() const {return goal; }
    vector<Subgoal> get_subgoals() const {return subgoals; }
    Subgoal get_subgoal(int i) {return subgoals[i]; }
    void generate_cpp_input(ofstream &outfile) const;
    bool is_redundant() const;
};

extern void strip_methods(vector<Method> &methods);
extern void strip_unimportant_vars_from_formula (vector<Method::VarVal> formula);
#endif




