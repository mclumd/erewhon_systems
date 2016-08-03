#ifndef GOAL_LIST_H
#define GOAL_LIST_H

#include "method.h"

typedef std::vector<goal_formula> goal_list;

class GoalList {
    struct GoalListEntry {
        const goal_formula &g;
        GoalListEntry *next;
        GoalListEntry *prev;

        GoalListEntry (const goal_formula &gf, GoalListEntry *next_entry, GoalListEntry *prev_entry)
            : g (gf), next (next_entry), prev (prev_entry) {}
    };

    GoalListEntry *top_entry;

    public:
    GoalList (goal_formula &g);
    GoalList (const GoalList &other);
    // GoalList (const GoalList &other, const Method &m); TODO

    // modifiers
    void insert_subgoal (const goal_formula &g);
    void insert_subgoal (const Subgoal &g);
    void insert_subgoals (const vector<Subgoal> &subgoals);
    void insert_subgoals (const vector<goal_formula> &subgoals);
    const goal_formula &remove_top();
    void simplify ();
    const goal_formula &remove(GoalListEntry *curr);

    //viewers
    void dump() const;
    void print_gf (const goal_formula &g) const;
    
    //accessors
    const goal_formula &top();
    bool is_empty();
    int hash() const;
    bool operator==(const GoalList &gl) const;
    const GoalListEntry *get_top_entry() const {return top_entry;}

    private:
    bool is_gf_subset_of (const goal_formula &gf1, const goal_formula &gf2);
};

#endif
