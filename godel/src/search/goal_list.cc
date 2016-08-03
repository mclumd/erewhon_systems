#include <iostream>
#include <cassert>
#include <algorithm>

using namespace std;

#include "goal_list.h"
#include "globals.h"

GoalList::GoalList (goal_formula &g) {
    top_entry = new GoalListEntry (g, NULL, NULL);
}

//copy constructor
GoalList::GoalList (const GoalList &other) {
    cout << "goal list copy constructor called" << endl;
    top_entry = NULL; // set up initial value of new list

    const GoalListEntry *other_entry = other.get_top_entry (); // iterator for original list
    cout << "test1\n";
    GoalListEntry **this_entry = &top_entry; // double indirection!
    cout << "test2\n";
    GoalListEntry *prev_entry = NULL; // keeps track of prev in the new list

    while (other_entry != NULL) {
        const goal_formula &other_gf = other_entry->g;
        *this_entry = new GoalListEntry (other_gf, NULL, prev_entry);

        // now update pointers
        prev_entry = *this_entry;
        this_entry = &((*this_entry)->next);
        other_entry = other_entry->next;
    }

}

//TODO creates a new GoalList instance consisting of sub(m) concatenated
// with *other*
// GoalList::GoalList (const GoalList &other, const Method &m) {
// }

void GoalList::insert_subgoal (const goal_formula &g) {
    top_entry = new GoalListEntry (g, top_entry, NULL);
    if (top_entry->next != NULL)
        (top_entry->next)->prev = top_entry;
}

void GoalList::insert_subgoal (const Subgoal &g) {
    goal_formula g_copy;
    for (int i = 0; i < g.size(); i++) {
            const VarVal &var_val = g[i];
            g_copy.push_back(make_pair(var_val.var, var_val.val));
    }

    // you've created a copy of g in g_copy. Now instantiate a new GoalListEntry
    // struct and insert that in the front of the list
    top_entry = new GoalListEntry (g_copy, top_entry, NULL);
    if (top_entry->next != NULL)
        (top_entry->next)->prev = top_entry;
}


// this function inserts the sequence of goals one-by-one
// into the *front* of gl. 
void GoalList::insert_subgoals (const vector<Subgoal> &subgoals) {
    for (int i = subgoals.size() - 1; i >= 0; i--) {
        insert_subgoal (subgoals[i]);
    }
}

// this function inserts the sequence of goals one-by-one
// into the *front* of gl. 
void GoalList::insert_subgoals (const vector<goal_formula> &subgoals) {
    for (int i = subgoals.size() - 1; i >= 0; i--) {
        insert_subgoal (subgoals[i]);
    }
}


void GoalList::dump () const {
    int i = 0;
    for (GoalListEntry *current = top_entry; current != NULL; current = current->next) {
        const goal_formula &current_g = current->g;
        //cout << i << "th goal formula is of size " << g.size() << endl;
        cout << "-- goal " << i++ << ": ";
        for (int j = 0; j < current_g.size(); j++) {
            cout << g_variable_name[current_g[j].first] << " := " << current_g[j].second << " ";
        }
        cout << ", "; 
        for (int j = 0; j < current_g.size(); j++) {
            cout << g_fact_names[current_g[j].first][current_g[j].second] << " ";
        }
 
        cout << endl;
    }
}

const goal_formula &GoalList::top () {
    return top_entry->g;
}

const goal_formula &GoalList::remove_top () {
    GoalListEntry *old_top = top_entry;
    top_entry = top_entry->next;
    cout << "test1\n" << endl;
    if (top_entry != NULL)
        top_entry->prev = NULL;
    cout << "test2\n" << endl;
    const goal_formula &top_f = old_top->g; // to be returned
    delete old_top; // free the entry

    return top_f;
}

bool GoalList::is_empty() {
    return top_entry == NULL;
}

// this function does some rudimentary simplification of the goal list
// e.g. [g, g_1, g_1, g_2, g_2, g_3] would be simplified to [g, g_1, g_2, g_3]
// -- if there's a subsequence [g, g], that would be simplified to [g]
// -- if there's a subsequence [g, g /\ g'] or [g /\ g', g],
//    that would be simplified to [g /\ g']
void GoalList::simplify() {
    GoalListEntry *current_entry = top_entry;
    GoalListEntry *next_entry;
    
    // set up current and next pointers
    if (current_entry == NULL) 
        return;
    else
        next_entry = current_entry->next;

    // to check if the first two goals have any redundancy
    while (next_entry != NULL) {
        //cout << "current_entry is " << current_entry << ", next_entry is " << next_entry << endl;
        const goal_formula &current_gf = current_entry->g;
        // cout << "current_gf is:" << endl;
        // print_gf (current_gf);
        const goal_formula &next_gf = next_entry->g;
        // cout << "next_gf is:" << endl;
        // print_gf (next_gf);

        if (is_gf_subset_of(next_gf, current_gf)) {
            /*
            cout << "current_gf subset of next_gf" << endl;
            cout << "current_gf:" << endl;
            print_gf (current_gf);
            cout << "next_gf:" << endl;
            print_gf (next_gf);
            */
            remove(current_entry);
            current_entry = next_entry;
            next_entry = next_entry->next;
        }

        /*
        else if (is_gf_subset_of(current_gf, next_gf)) {
            cout << "next_gf subset of current_gf" << endl;
            cout << "current_gf:" << endl;
            print_gf (current_gf);
            cout << "next_gf:" << endl;
            print_gf (next_gf);
            current_entry->next = next_entry->next;
            remove(next_entry);
            next_entry = current_entry->next;
        }
        */

        else {
            current_entry = next_entry;
            next_entry = next_entry->next;
        }
    }
}

bool GoalList::is_gf_subset_of (const goal_formula &gf1, const goal_formula &gf2) {

    if (includes (gf2.begin(), gf2.end(), gf1.begin(), gf1.end())) {
        /*
        cout << "gf1 included in gf2" << endl;
        print_gf (gf1);
        print_gf (gf2);
        */
        return true;
    }
    else return false;
}

const goal_formula &GoalList::remove (GoalListEntry *curr) {
    GoalListEntry *prev = curr->prev;

    if (prev == NULL) // implies curr = top_entry
        return remove_top ();

    // curr is not the top element
    prev->next = curr->next;
    const goal_formula &curr_f = curr->g; // to be returned
    delete curr; // free the entry

    return curr_f;
}

void GoalList::print_gf (const goal_formula &g) const {
    for (int i = 0; i < g.size(); i++) 
        cout << g_variable_name[g[i].first] << " := " << g[i].second << "\t";
    cout << endl;
}

int GoalList::hash () const {
    int hash = 0;
    GoalListEntry *curr = top_entry;
    int index = 3;

    while (curr != NULL) {
        const goal_formula &g = curr->g;
        int temp = 0;
        for (int i = 0; i < g.size(); i++) 
            temp += g[i].first * (g[i].second + index);

        hash += temp;
        index++;
        curr = curr->next;
    }

    return (11 + index) * hash;
}

bool GoalList::operator== (const GoalList &other) const {
    const GoalListEntry *other_entry = other.get_top_entry();
    GoalListEntry *this_entry = top_entry;

    while (this_entry != NULL) {
        const goal_formula &this_gf = this_entry->g;

        if (other_entry != NULL) {
            const goal_formula &other_gf = other_entry->g;
            if (this_gf == other_gf) {
                this_entry = this_entry->next;
                other_entry = other_entry->next;
            }
            
            //if entries differ at a particular position ...
            else return false;
        }
        
        // if other is shorter than this, this will be reached
        else return false;
    }

    // here, this_entry is NULL. Must return false if other_entry
    // is still not NULL (since that would imply other is longer 
    // than this)
    if (other_entry != NULL)
        return false;
    else return true;
}






