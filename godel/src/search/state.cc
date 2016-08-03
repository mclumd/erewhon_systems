#include "state.h"

#include "axioms.h"
#include "globals.h"
#include "operator.h"
#include "utilities.h"

#include <algorithm>
#include <iostream>
#include <cassert>
using namespace std;

void State::_allocate() {
    borrowed_buffer = false;
    vars = new state_var_t[g_variable_domain.size()];
}

void State::_deallocate() {
    if (!borrowed_buffer)
        delete[] vars;
}

void State::_copy_buffer_from_state(const State &state) {
    // TODO: Profile if memcpy could speed this up significantly,
    //       e.g. if we do blind A* search.
    for (int i = 0; i < g_variable_domain.size(); i++)
        vars[i] = state.vars[i];
}

State & State::operator=(const State &other) {
    if (this != &other) {
        if (borrowed_buffer)
            _allocate();
        _copy_buffer_from_state(other);
    }
    return *this;
}

State::State(istream &in) {
    _allocate();
    check_magic(in, "begin_state");
    for (int i = 0; i < g_variable_domain.size(); i++) {
        int var;
        in >> var;
        vars[i] = var;
    }
    check_magic(in, "end_state");

    g_default_axiom_values.assign(vars, vars + g_variable_domain.size());
}

State::State(const State &state) {
    _allocate();
    _copy_buffer_from_state(state);
}

State::State(const State &predecessor, const Operator &op) {
    assert(!op.is_axiom());
    _allocate();
    _copy_buffer_from_state(predecessor);
    // Update values affected by operator.
    for (int i = 0; i < op.get_pre_post().size(); i++) {
        const PrePost &pre_post = op.get_pre_post()[i];
        if (pre_post.does_fire(predecessor))
            vars[pre_post.var] = pre_post.post;
    }

    g_axiom_evaluator->evaluate(*this);
}

State::~State() {
    _deallocate();
}

void State::dump() const {
    // We cast the values to int since we'd get bad output otherwise
    // if state_var_t == char.
    for (int i = 0; i < g_variable_domain.size(); i++)
        cout << "  " << g_variable_name[i] << ": "
             << static_cast<int>(vars[i]) << endl;
}

bool State::operator==(const State &other) const {
    int size = g_variable_domain.size();
    return ::equal(vars, vars + size, other.vars);
}

bool State::operator<(const State &other) const {
    int size = g_variable_domain.size();
    return ::lexicographical_compare(vars, vars + size,
                                     other.vars, other.vars + size);
}

size_t State::hash() const {
    return ::hash_number_sequence(vars, g_variable_domain.size());
}

// this function takes in a vector of <var_index, val> pairs
// and returns true if all such pairs are satisfied in the 
// state object and false otherwise
bool State::is_goal_satisfied (const vector<pair<int, int> > &g) const {
    for (int i = 0; i < g.size(); i++) {
        int var_index = g[i].first;
        int val = g[i].second;
        if (vars[var_index] == val) {
            continue;
        }

        else return false;
    }

    return true;
}

// this function takes in a vector of vector of <var_index, val> pairs
// and returns true if any of the vectors are satisfied in the 
// state object and false otherwise
bool State::is_disj_satisfied (const vector<vector<pair<int, int> > > &g) const {
    for (int i = 0; i < g.size(); i++) {
        bool result = is_goal_satisfied (g[i]);
        if (result)
            return true;
    }

    return false;
}


// this function does a destructive update of the state to
// \gamma(s,a)
void State::progress_state (const Operator &op) {
    // just to double check, make sure op is applicable in the state
    assert (op.is_applicable(*this));

    const vector<PrePost> &op_prepost = op.get_pre_post(); 

    // now for each prepost, update the value of the var to the new value
    for (int i = 0; i < op_prepost.size(); i++) {
        vars[op_prepost[i].var] = op_prepost[i].post;
    }
}

// this function does a destructive update of the state object back to 
// \gamma^{-1} (s,a)
void State::regress_state (const Operator &op) {
    const vector<PrePost> &op_prepost = op.get_pre_post(); 

    // now for each prepost, update the value of the var to the new value
    for (int i = 0; i < op_prepost.size(); i++) {
        // for each pre_post, first verify that the current
        // value of the state variable equals the 'post' value
        assert (vars[op_prepost[i].var] == op_prepost[i].post);

        vars[op_prepost[i].var] = op_prepost[i].pre;
    }
}
