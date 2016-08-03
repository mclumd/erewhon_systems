#ifndef GDP_SEARCH_NODE_H
#define GDP_SEARCH_NODE_H

#include "state.h"
#include "goal_list.h"
#include "globals.h"

#include <functional>

class GDP_Search_Node {
    private:
    State *s;
    GoalList *gl;

    public:
    GDP_Search_Node (State s, GoalList gl);
    GDP_Search_Node (State *s, GoalList *gl);
    GDP_Search_Node (const GDP_Search_Node &other);
    bool operator== (const GDP_Search_Node &other) const;
    State *get_stateptr () const; //{return s;}
    GoalList *get_glptr () const; //{return gl;} 
};

namespace std {
    template<>
    struct hash<GDP_Search_Node> {
        size_t operator() (const GDP_Search_Node &entry) const {
            const State &s = *(entry.get_stateptr());
            const GoalList *gl = entry.get_glptr();
            int hash = 0;

            for (int i = 0; i < g_variable_name.size(); i++) {
                hash += i * (s[i] + 1);
            }

            hash += gl->hash();

            return hash;
        }
    };
}

/*
namespace std {
    template<>
    struct hash<GDP_Search_Node> {
        size_t operator() (const GDP_Search_Node &n) const; 
    };
}
*/

#endif
