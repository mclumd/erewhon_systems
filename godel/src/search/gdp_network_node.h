#ifndef GDP_NETWORK_NODE_H
#define GDP_NETWORK_NODE_H

#include "state.h"
#include "goal_network.h"
#include "globals.h"

#include <functional>

class GDP_Network_Node {
    private:
    State *s;
    GoalNetwork *gn;

    public:
    GDP_Network_Node (State s, GoalNetwork gn);
    GDP_Network_Node (State *s, GoalNetwork *gn);
    GDP_Network_Node (const GDP_Network_Node &other);
    bool operator== (const GDP_Network_Node &other) const;
    State *get_stateptr () const; //{return s;}
    GoalNetwork *get_gnptr () const; //{return gn;} 
};

namespace std {
    template<>
    struct hash<GDP_Network_Node> {
        size_t operator() (const GDP_Network_Node &entry) const {
            const State &s = *(entry.get_stateptr());
            const GoalNetwork *gn = entry.get_gnptr();
            int hash = 0;

            for (int i = 0; i < g_variable_name.size(); i++) {
                hash += i * (s[i] + 1);
            }

            hash += gn->hash();

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
