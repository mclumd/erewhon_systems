#ifndef STATE_H
#define STATE_H

#include <iostream>
#include <vector>
using namespace std;

class Operator;

#include "state_var_t.h"
// #include "goal_network.h"

class State {
    state_var_t *vars; // values for vars
    bool borrowed_buffer;
    void _allocate();
    void _deallocate();
    void _copy_buffer_from_state(const State &state);

public:
    explicit State(istream &in);
    State(const State &state);
    State(const State &predecessor, const Operator &op);
    ~State();
    State &operator=(const State &other);
    state_var_t &operator[](int index) {
        return vars[index];
    }
    int operator[](int index) const {
        return vars[index];
    }
    void dump() const;
    bool operator==(const State &other) const;
    bool operator<(const State &other) const;
    size_t hash() const;

    explicit State(state_var_t *buffer) {
        vars = buffer;
        borrowed_buffer = true;
    }
    const state_var_t *get_buffer() const {
        return vars;
    }

    bool is_goal_satisfied (const vector<pair<int, int> > &g) const;
    bool is_disj_satisfied (const vector<vector<pair<int, int> > > &g) const;
    void progress_state (const Operator &op);
    void regress_state (const Operator &op);
};

#endif
