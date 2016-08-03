#ifndef GDP_CLOSED_LIST_H
#define GDP_CLOSED_LIST_H

#include <unordered_set>
#include <functional>

#include "state.h"
#include "goal_list.h"
#include "gdp_search_node.h"

// typedef std::pair<State, GoalList> GDP_Search_Node;
/*
struct gdp_search_node_hash {
    size_t operator() (const GDP_Search_Node &entry) const {
        const State &s = *(entry.get_stateptr());
        const GoalList *gl = entry.get_glptr();
        int hash = 0;

        for (int i = 0; i < g_variable_name.size(); i++)
                hash += i * (s[i] + 1);

        hash += gl->hash();

        return hash;
    }
};
*/

class GDP_Closed_List {
    std::unordered_set<GDP_Search_Node> closed_list;

    public:
    GDP_Closed_List (GDP_Search_Node &first_n);
    bool is_there (GDP_Search_Node &n);
    bool add_node (GDP_Search_Node &n);

    //viewers
    void dump () const;
};

#endif
