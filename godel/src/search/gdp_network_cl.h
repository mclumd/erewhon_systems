#ifndef GDP_NETWORK_CL_H
#define GDP_NETWORK_CL_H

#include <unordered_set>
#include <functional>

#include "state.h"
#include "goal_network.h"
#include "gdp_network_node.h"

// typedef std::pair<State, GoalNetwork> GDP_Network_Node;
/*
struct gdp_search_node_hash {
    size_t operator() (const GDP_Network_Node &entry) const {
        const State &s = *(entry.get_stateptr());
        const GoalNetwork *gn = entry.get_gnptr();
        int hash = 0;

        for (int i = 0; i < g_variable_name.size(); i++)
                hash += i * (s[i] + 1);

        hash += gn->hash();

        return hash;
    }
};
*/

class GDP_Network_CL {
    std::unordered_set<GDP_Network_Node> closed_list;

    public:
    GDP_Network_CL (GDP_Network_Node &first_n);
    bool is_there (GDP_Network_Node &n);
    bool add_node (GDP_Network_Node &n);

    //viewers
    void dump () const;
};

#endif
