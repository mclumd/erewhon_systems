#include "gdp_closed_list.h"
#include "state.h"
#include "goal_list.h"

#include <unordered_set>

using namespace std;

// from here on, functions for GDP_Closed_List are defined

GDP_Closed_List::GDP_Closed_List (GDP_Search_Node &first_n) {
    closed_list.insert (first_n);
}

bool GDP_Closed_List::is_there (GDP_Search_Node &n) {
    unordered_set<GDP_Search_Node>::iterator it = closed_list.find (n);

    if (it == closed_list.end())
        return false;
    else return true;
}

bool GDP_Closed_List::add_node (GDP_Search_Node &n) {
    unordered_set<GDP_Search_Node>::hasher fn = closed_list.hash_function ();
    // cout << "adding the following node to the closed list" << endl;
    // cout << "state hash value: " << (n.get_stateptr ())->hash() << endl;
    // cout << "goal_list: " << endl;
    (n.get_glptr ())->dump ();
    // cout << "hash value of new node is " << fn (n) << endl;
    cout << endl;
 
    const pair<unordered_set<GDP_Search_Node>::iterator, bool> &result = closed_list.insert (n);
    return result.second;
}

void GDP_Closed_List::dump () const {
    // hash<GDP_Search_Node> fn;
    unordered_set<GDP_Search_Node>::hasher fn = closed_list.hash_function ();
    for (auto a = closed_list.begin(); a != closed_list.end(); a++) {
        cout << "state: " << (a->get_stateptr ())->hash() << endl;
        // (a->get_stateptr ())->dump ();
        cout << "goal_list: " << endl;
        (a->get_glptr ())->dump ();
        cout << "hash value is " << fn (*a) << endl;
        cout << endl;
    }
}
