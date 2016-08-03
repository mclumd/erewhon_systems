#include <vector>
#include <deque>
#include <set>
#include <algorithm>
#include <ext/hash_map>

#include "goal_network.h"
#include "globals.h"
#include "state.h"

class State;

using namespace std;

bool gne_compare::operator() (const GoalNetworkEntry *gne1, const GoalNetworkEntry *gne2) {
    return (gne1->f < gne2->f);
}

void GoalNetworkEntry::pretty_print () {
    cout << "node_id : " << id << endl;
    cout << "goal:" << endl;
    cout << "f's size is " << f.size() << endl;
    for (int i = 0; i < f.size(); i++) {
        const goal_formula &f_i = f[i];
        cout << " -- ";
        for (int j = 0; j < f_i.size(); j++) {
            int var = f_i[j].first, val = f_i[j].second; 
            cout << g_variable_name[var] << ":=" << val << " (" << g_fact_names[var][val] << ") ";
        }
        cout << endl;
    }
    cout << "parents:" << endl << " -- ";
    for (auto it = parents.begin(); it != parents.end(); it++) 
        cout << (*it)->id << " "; 
    cout << endl;
 
    cout << "children:" << endl << " -- ";
    for (auto it = children.begin(); it != children.end(); it++) 
        cout << (*it)->id << " "; 
    cout << endl;
}

void GoalNetwork::pretty_print (int node_id) {
    GoalNetworkEntry *node_ptr = nodeid_map [node_id];
    assert (node_ptr != NULL);
    node_ptr->pretty_print (); 
}

// TODO: not complete! need to test parents and children
// actually, no need to do that ... since we're running equality test
// for every edge of the graph, don't need to check neighbours explicitly
bool GoalNetworkEntry::operator== (const GoalNetworkEntry &other) {
    return f == other.f;

}

GoalNetwork::GoalNetwork (const goal_formula &g) {
    max_id = 0;
    disj_goal_formula gf_vec;
    // vertex_set gf_parents, gf_children; 
    gf_vec.push_back (g);
    GoalNetworkEntry *gne_ptr = new GoalNetworkEntry (++max_id, gf_vec);
    nodeid_map.insert (make_pair(max_id, gne_ptr));
    // cout << "gne_ptr is " << gne_ptr << endl;
    // cout << "gf size is " << (gne_ptr->f)[0].size() << endl;
    gne_ptr->pretty_print ();
    source_nodes.insert (gne_ptr);
}

GoalNetwork::GoalNetwork (const GoalNetwork &other) {
    max_id = other.get_max_id ();
    const id_map &other_map = other.get_nodeid_map (); 
    // GoalNetworkEntry *this_nodes = new GoalNetworkEntry [num_nodes_other];
    for (auto it = other_map.begin(); it != other_map.end(); it++) {
        int other_id = it->first;
        GoalNetworkEntry *this_ptr = new GoalNetworkEntry (other_id, it->second->f);
        /*
        cout << "orig entry in nimap is:" << endl;
        (it->second)->pretty_print (); 
        cout << "new entry in nimap is:" << endl;
        this_ptr->pretty_print (); 
        */
        
        //set id and f in the new GoalNetworkEntry object
        // this_ptr->id = other_id;
        // this_ptr->f = it->second->f;

        nodeid_map.insert (make_pair(other_id, this_ptr));
    }

    // allocated the required number of GoalNetworkEntry objects,
    // now to populate them
    for (auto it = other_map.begin(); it != other_map.end(); it++) {
        int other_id = it->first;
        // cout << "other_id is " << other_id << endl;
        GoalNetworkEntry *other_ptr = it->second;
        GoalNetworkEntry *this_ptr = nodeid_map [other_id];
        /*
        cout << "this_id is " << this_ptr->id << endl;
        cout << "other_ptr is " << other_ptr << ", this_ptr is " << this_ptr << endl;
        */
        vertex_set &other_p = other_ptr->parents;
        vertex_set &this_p = this_ptr->parents;
        // set parents of the new node
        for (auto it2 = other_p.begin(); it2 != other_p.end(); it2++) {
            int id_of_parent = (*it2)->id;
            GoalNetworkEntry *new_parent_ptr = nodeid_map[id_of_parent];
            this_p.insert (new_parent_ptr);
        }

        vertex_set &other_c = other_ptr->children;
        vertex_set &this_c = this_ptr->children;
        // set children of the new node
        for (auto it3 = other_c.begin(); it3 != other_c.end(); it3++) {
            int id_of_child = (*it3)->id;
            GoalNetworkEntry *new_child_ptr = nodeid_map[id_of_child];
            this_c.insert (new_child_ptr);
        }
    }

    for (auto m_it = nodeid_map.begin (); m_it != nodeid_map.end (); m_it++) {
        GoalNetworkEntry *gne_ptr = m_it->second;
        if ((gne_ptr->parents).size () == 0)
            source_nodes.insert (gne_ptr);
    }

    /*
    const vertex_set &other_source_nodes = other.get_source_nodes ();
    for (auto it = other_source_nodes.begin(); it != other_source_nodes.end(); it++) {
        int id_of_source = (*it)->id;
        cout << "orig source node is " << endl;
        (*it)->pretty_print (); 
        GoalNetworkEntry *new_source_ptr = nodeid_map[id_of_source];
        cout << "new source node is " << new_source_ptr->id << endl;
        new_source_ptr->pretty_print (); 
        source_nodes.insert (new_source_ptr);
    }
    */

}

/*
GoalNetwork::GoalNetwork (const GoalNetwork &other) {
    num_nodes = 0;
    cout << "in goal_network copy constructor ... " << endl;
    map<GoalNetworkEntry *, GoalNetworkEntry *> old_new_ptr_map;
    const vector<GoalNetworkEntry *> &other_sn = other.get_source_nodes ();  
    deque<GoalNetworkEntry *> queue (other_sn.begin(), other_sn.end());
    while (queue.size() != 0) {
        GoalNetworkEntry *other_ptr = queue.front();
        cout << "other_ptr id is " << other_ptr->id << endl; 
        vector<GoalNetworkEntry *> this_parents, this_children;
        GoalNetworkEntry *this_ptr = new GoalNetworkEntry (
            ++num_nodes,
            other_ptr->f, 
            this_parents, 
            this_children);
        old_new_ptr_map.insert (make_pair(other_ptr, this_ptr));
        vector<GoalNetworkEntry *> &other_p = other_ptr->parents;
        
        for (int i = 0; i < other_p.size(); i++) {
            map<GoalNetworkEntry *, GoalNetworkEntry *>::iterator it = old_new_ptr_map.find (other_p[i]);
            if (it == old_new_ptr_map.end())
                continue;
            else {
                cout << "other_p:" << it->first << ", this_p:" << it->second << endl; 
                (this_ptr->parents).push_back (it->second);
                (it->second->children).push_back (this_ptr);
                cout << "this_ptr->parents size is " << (this_ptr->parents).size() << endl;
            }
        }
            
        
        vector<GoalNetworkEntry *> &other_c = other_ptr->children;
        for (int i = 0; i < other_c.size(); i++) {
            map<GoalNetworkEntry *, GoalNetworkEntry *>::iterator it = old_new_ptr_map.find (other_c[i]);
            if (it == old_new_ptr_map.end())
                queue.push_back (other_c[i]);
                // continue;
            
            // else {
            //     (this_ptr->children).push_back (it->second);
            //     cout << "this_ptr->children size is " << (this_ptr->children).size() << endl;
            // }
            
        }
        

        queue.pop_front(); 
    }

    // now populate source_nodes
    for (auto it = old_new_ptr_map.begin(); it != old_new_ptr_map.end(); it++) {
        cout << "old_id : " << it->first->id << ", new_id : " << it->second->id << endl;
        GoalNetworkEntry *new_ptr = it->second;
        if ((new_ptr->parents).size() == 0) 
            source_nodes.push_back (new_ptr);
    }    
}
*/

void GoalNetwork::insert_subgoal_front (const disj_goal_formula &g) {
    vertex_set g_parents;
    GoalNetworkEntry *gle = new GoalNetworkEntry (++max_id, g, g_parents, source_nodes);
    cout << "new node is:" << endl;
    gle->pretty_print ();
    nodeid_map.insert (make_pair(max_id, gle));

    for (auto it = source_nodes.begin(); it != source_nodes.end(); it++) {
        GoalNetworkEntry *gne_ptr = *it;
        (gne_ptr->parents).insert (gle);
    }

    vertex_set new_source;
    new_source.insert (gle);

    source_nodes = new_source;
    cout << "the new source_nodes is:" << endl;
    for (auto snit = source_nodes.begin (); snit != source_nodes.end (); snit++) {
        (*snit)->pretty_print (); 
        cout << endl;
    }
}

void GoalNetwork::insert_subgoal_front (const goal_formula &g) {
    vertex_set g_parents;
    disj_goal_formula dgf;
    dgf.push_back (g);
    GoalNetworkEntry *gle = new GoalNetworkEntry (++max_id, dgf, g_parents, source_nodes);
    cout << "new node is:" << endl;
    gle->pretty_print ();
    nodeid_map.insert (make_pair(max_id, gle));

    for (auto it = source_nodes.begin(); it != source_nodes.end(); it++) {
        GoalNetworkEntry *gne_ptr = *it;
        (gne_ptr->parents).insert (gle);
    }

    vertex_set new_source;
    new_source.insert (gle);

    source_nodes = new_source;
    cout << "the new source_nodes is:" << endl;
    for (auto snit = source_nodes.begin (); snit != source_nodes.end (); snit++) {
        (*snit)->pretty_print (); 
        cout << endl;
    }
}

int GoalNetwork::insert_subgoal_front (int child_id, const disj_goal_formula &g) {
    cout << "trying to insert following formula:" << endl;
    for (int i = 0; i < g.size (); i++) {
        cout << " -- ";
        for (int j = 0; j < g [i].size (); j++) {
            cout << g_fact_names [g[i][j].first][g[i][j].second] << " ";
        }
        cout << endl;
    }
    cout << endl;

    vertex_set gne_parents;
    vertex_set gne_children;
    gne_children.insert (nodeid_map [child_id]); 
    cout << "child of new node is:" << endl;
    (nodeid_map [child_id])->pretty_print (); 
    GoalNetworkEntry *gne = new GoalNetworkEntry (++max_id, g, gne_parents, gne_children);
    nodeid_map.insert (make_pair(max_id, gne));

    GoalNetworkEntry *child_ptr = nodeid_map [child_id];
    (child_ptr->parents).insert (gne);

    source_nodes.erase (child_ptr);
    source_nodes.insert (gne);

    return max_id;
}

int GoalNetwork::insert_subgoal_front (int child_id, const goal_formula &g) {
    disj_goal_formula dgf;
    dgf.push_back (g);

    return insert_subgoal_front (child_id, dgf);
}

void GoalNetwork::insert_subgoals (const vector<goal_formula> &subgoals) {
    for (int i = subgoals.size() - 1; i >= 0; i--) {
        disj_goal_formula gf_vec;
        gf_vec.push_back (subgoals[i]);
        insert_subgoal_front (gf_vec);
    }
}

int GoalNetwork::insert_subgoals (int child_id, const vector<goal_formula> &subgoals) {
    for (int i = subgoals.size() - 1; i >= 0; i--) {
        disj_goal_formula gf_vec;
        gf_vec.push_back (subgoals[i]);
        child_id = insert_subgoal_front (child_id, gf_vec);
    }

    return child_id;
}

void GoalNetwork::dump () const {
    vector<bool> is_printed;
    is_printed.resize (max_id+1, false);
    cout << "size: " << nodeid_map.size () << endl;
    cout << "max_id : " << max_id << endl;
    cout << "\nsource nodes are:" << endl;
    for (auto x = source_nodes.begin (); x != source_nodes.end (); x++)
        (*x)->pretty_print ();

    cout << "\n vertices are as follows:" << endl;
    deque<GoalNetworkEntry *> queue (source_nodes.begin(), source_nodes.end());
    while (queue.size() != 0) {
        GoalNetworkEntry *ptr = queue.front();
        if (!is_printed [ptr->id]) {
            is_printed [ptr->id] = true;
            cout << "gneptr: " << ptr << endl;
            ptr->pretty_print ();
            cout << endl;
            cout << "ptr:" << ptr << endl; 
            vertex_set &ptr_children = ptr->children;
            for (auto it = ptr_children.begin(); it != ptr_children.end(); it++)
                queue.push_back (*it);
        }
        queue.pop_front (); 
    }
    cout << "\n gn printed" << endl;
}

int GoalNetwork::hash () const {
    int hash = 0;

    deque<GoalNetworkEntry *> queue (source_nodes.begin(), source_nodes.end());

    int index = 3;

    while (queue.size() != 0) {
        GoalNetworkEntry *curr = queue.front(); 
        vertex_set &children = curr->children;
        const disj_goal_formula &g = curr->f;
        int temp = 0;
        for (int i = 0; i < g.size(); i++) 
            for (int j = 0; j < g[i].size(); j++)
                temp += g[i][j].first * (g[i][j].second + index);

        hash += temp;
        index++;

        queue.pop_front();
        for (auto it = children.begin(); it != children.end(); it++)
            queue.push_back (*it);
    }

    return (11 + index) * hash;
}

bool GoalNetwork::operator == (const GoalNetwork &other) {
    deque<GoalNetworkEntry *> queue (source_nodes.begin(), source_nodes.end());
   
    /*
    cout << "this source nodes:" << endl;
    for (auto it = source_nodes.begin(); it != source_nodes.end(); it++)
        cout << *it << endl;
    */

    const vertex_set &other_source_nodes = other.get_source_nodes (); 
    deque<GoalNetworkEntry *> other_queue (other_source_nodes.begin(), other_source_nodes.end());

    /*
    cout << "other source nodes:" << endl;
    for (auto it = other_source_nodes.begin(); it != other_source_nodes.end(); it++)
        cout << *it << endl;
    */

    // cout << "num_orig: " << get_num_nodes () << ", num_copy: " << other.get_num_nodes() << endl;
    // number of vertices don't match
    if (get_num_nodes() != other.get_num_nodes ())
        return false;

    // now go through the vertices
    while (queue.size() != 0) {
        GoalNetworkEntry *this_ptr = queue.front ();
        GoalNetworkEntry *other_ptr = other_queue.front ();
        // cout << "this_ptr:" << this_ptr << ", other_ptr:" << other_ptr << endl;

        if (!(*this_ptr == *other_ptr)) {
            /*
            cout << "formulae are not identical!" << endl;
            // cout << "this_gne:" << this_ptr << endl;
            this_ptr->pretty_print ();
            // cout << "other_gne:" << other_ptr << endl;
            other_ptr->pretty_print ();
            */
            return false;
        }

        if ((this_ptr->parents).size() != (other_ptr->parents).size())
            return false;

        if ((this_ptr->children).size() != (other_ptr->children).size())
            return false;

        // cout << "adding elements to queue:" << endl;
        for (auto it = (this_ptr->children).begin(); it != (this_ptr->children).end(); it++) {
            // cout << "added " << *it << endl;
            queue.push_back (*it);
        }
        // cout << "adding elements to other_queue:" << endl;
        for (auto it = (other_ptr->children).begin(); it != (other_ptr->children).end(); it++) {
            // cout << "added " << *it << endl;
            other_queue.push_back (*it);
        }

        queue.pop_front ();
        other_queue.pop_front (); 
    }

    // if it reaches here, all vertices and degrees are identical
    return true;
}

bool does_conj_imply_conj (const goal_formula &c1, const goal_formula &c2) {
    cout << "c1:" << endl;
    for (int i = 0; i < c1.size (); i++)
        cout << " -- " << c1 [i].first << " := " << c1 [i].second << endl;
    cout << "c2:" << endl;
    for (int i = 0; i < c2.size (); i++)
        cout << " -- " << c2 [i].first << " := " << c2 [i].second << endl;
    if (includes (c1.begin(), c1.end(), c2.begin(), c2.end())) {
        return true;
    }
    else return false;
}

bool does_disj_imply_other_disj (const disj_goal_formula &f1, const disj_goal_formula &f2) {
    if (f1.size() != 1) // if f1 is a disjunction, hard to say anything useful
        return false;

    // f1 is now a simple conjunction
    const goal_formula &fla1 = f1[0];
    for (auto it = f2.begin(); it != f2.end(); it++) {
        const goal_formula &fla2 = *it;
        if (does_conj_imply_conj (fla1, fla2))
            return true;
    }
    
    return false;
}

bool is_child_redundant (GoalNetworkEntry *parent, GoalNetworkEntry *child) {
    if ((child->parents).size () != 1)
        return false;

    if (does_disj_imply_other_disj (parent->f, child->f)) {
        cout << "p_disj implies c_disj" << endl;
        return true;
    }

    return false;
}

void GoalNetwork::simplify () {
    // cout << "\nin simplify ... " << endl;
    deque<pair<GoalNetworkEntry *, GoalNetworkEntry *> > parent_child_pairs;
    vector<bool> is_removed; // to keep track of deleted vertices
    is_removed.resize (max_id, false);
    vector<GoalNetworkEntry *> to_be_removed;

    for (auto it = source_nodes.begin(); it != source_nodes.end(); it++) {
        GoalNetworkEntry *parent = *it;
        vertex_set &children = parent->children;
        for (auto it2 = children.begin(); it2 != children.end(); it2++) {
            GoalNetworkEntry *child = *it2;
            parent_child_pairs.push_back (make_pair (parent, child));
        }
    }

    while (parent_child_pairs.size() != 0) {
        pair<GoalNetworkEntry *, GoalNetworkEntry *> &pcp = parent_child_pairs.front();
        cout << "\nits going to cup here" << endl;
        if (is_removed [(pcp.first)->id - 1] || is_removed [(pcp.second)->id - 1]) {
            parent_child_pairs.pop_front ();
            continue;
        }
        
        cout << "top gne:" << pcp.first << endl;
        (pcp.first)->pretty_print (); 
        cout << "bottom gne:" << pcp.second << endl;
        (pcp.second)->pretty_print (); 
        
        if (is_child_redundant (pcp.first, pcp.second)) {
            cout << "child redundant" << endl;
            cout << "parent gne:" << endl;
            (pcp.first)->pretty_print (); 
            cout << "child gne:" << endl;
            (pcp.second)->pretty_print (); 
            cout << endl;
            vertex_set &grandchildren = (pcp.second)->children;
            for (auto it = grandchildren.begin (); it != grandchildren.end (); it++) 
                parent_child_pairs.push_back (make_pair (pcp.first, *it));
            cout << "deleted vertex " << pcp.second << endl;
            remove_vertex (pcp.second);
            to_be_removed.push_back (pcp.second);
            is_removed [(pcp.second)->id - 1] = true; 
            // note: pcp.second is deleted at this point
        }

        else {
            vertex_set &grandchildren = (pcp.second)->children;
            for (auto it = grandchildren.begin (); it != grandchildren.end (); it++) 
                parent_child_pairs.push_back (make_pair (pcp.second, *it));
        }

        parent_child_pairs.pop_front ();
    }

    // after everything is simplified, let's delete here
    for (int i = 0; i < to_be_removed.size (); i++)
        delete to_be_removed [i];
}

void GoalNetwork::remove_vertex (GoalNetworkEntry *vertex) {
    nodeid_map.erase (vertex->id);

    // if vertex is in source_nodes, remove it from there
    if ((vertex->parents).size () == 0)
        source_nodes.erase (vertex);

    vertex_set &v_p = vertex->parents;
    vertex_set &v_c = vertex->children;

    // now need to connect each parent to every child
    for (auto it = v_p.begin(); it != v_p.end(); it++) {
        GoalNetworkEntry *parent = *it;
        // cout << "id of parent is " << parent->id << endl;
        (parent->children).erase (vertex);
        (parent->children).insert (v_c.begin(), v_c.end());
    }

    // now update parents of each child as well
    for (auto it = v_c.begin(); it != v_c.end(); it++) {
        GoalNetworkEntry *child = *it;
        cout << "id of child is " << child->id << endl;
        /*
        for (auto it2 = v_p.begin (); it2 != v_p.end (); it2++) {
            pair<vertex_set::iterator, bool> ret = (child->parents).insert (*it2);
            cout << "was inserted? " << ret.second << endl;
            cout << *(ret.first) << " is now in the set" << endl;
            cout << *((child->parents).end ()) << " is the end of the set" << endl;
            cout << "id of parent is " << (*it2)->id << endl;
        }

        cout << "child->parents is as follows: " << (child->parents).size () << endl;
        for (auto set_it = (child->parents).begin (); set_it != (child->parents).end (); set_it++)
            (*set_it)->pretty_print (); 
        */


        (child->parents).erase (vertex);
        (child->parents).insert (v_p.begin(), v_p.end());
        cout << "child now looks as follows:" << endl;
        child->pretty_print (); 

        if ((child->parents).size () == 0)
            source_nodes.insert (child);

    }

    // not deleting it here because it's creating segfaults in simplify()
    // delete vertex; 
}

void GoalNetwork::remove_vertex (int id) {
    auto it = nodeid_map.find (id);
    assert (it != nodeid_map.end());

    remove_vertex (it->second);
}

bool GoalNetwork::is_there_satisfied_source_node (const State &s) {
    for (auto it = source_nodes.begin(); it != source_nodes.end(); it++) {
        GoalNetworkEntry *gne_ptr = *it;
        if (s.is_disj_satisfied (gne_ptr->f))
            return true;
    }

    return false;
}

vector<int> GoalNetwork::get_satisfied_source_ids (const State &s) {
    vector<int> sat_ids;
    for (auto it = source_nodes.begin(); it != source_nodes.end(); it++) {
        GoalNetworkEntry *gne_ptr = *it;
        if (s.is_disj_satisfied (gne_ptr->f))
            sat_ids.push_back (gne_ptr->id);
    }

    return sat_ids;    
}

void GoalNetwork::get_unsatisfied_facts_from_source (const State &s, goal_formula &unsat_f) {
    for (auto it = source_nodes.begin(); it != source_nodes.end(); it++) {
        const disj_goal_formula &gne_f = (*it)->f;
        for (auto it2 = gne_f.begin(); it2 != gne_f.end(); it2++) {
            const goal_formula &gne_f_c = *it2;
            for (auto it3 = gne_f_c.begin(); it3 != gne_f_c.end(); it3++) {
                const pair<int, int> &lit = *it3;
                if (!(s[lit.first] == lit.second))
                    unsat_f.push_back (lit);
            }
        }
    }

    sort (unsat_f.begin(), unsat_f.end());

    auto it = unique (unsat_f.begin(), unsat_f.end());
    unsat_f.resize (it - unsat_f.begin());
}

GoalNetworkEntry *get_gne_from_lm (int new_id, LandmarkNode *lmn) {
    vector<int> &lm_vars = lmn->vars;
    vector<int> &lm_vals = lmn->vals;
    bool is_disj = lmn->disjunctive;
    disj_goal_formula f;
    goal_formula g;
    
    for (int i = 0; i < lm_vars.size (); i++) {
        if (is_disj) {
            goal_formula g_temp;
            g_temp.push_back (make_pair (lm_vars [i], lm_vals [i]));
            f.push_back (g_temp);
        }

        else {
            g.push_back (make_pair (lm_vars [i], lm_vals [i]));
        }
    }

    if (!is_disj)
        f.push_back (g);

    return new GoalNetworkEntry (new_id, f);
}

bool exists_method_relevant_to_lm (LandmarkNode *lmn) {
    const int l = (lmn->vars).size();
    for (int i = 0; i < l; i++) {
        int var = (lmn->vars)[i], val = (lmn->vals)[i];
        if (g_predicates_methods_achieve.find((parse_fact_name (g_fact_names[var][val])).first) != g_predicates_methods_achieve.end()) {
            return true;
        }
    }

    return false;
}

void extract_gn_from_root (GoalNetworkEntry *parent_ptr, LandmarkNode *root_lm, vector<bool> &is_visited, map<LandmarkNode *, GoalNetworkEntry *> &inferred_goals) {
    // cout << "parent_ptr = " << parent_ptr << endl;
    cout << "root_lm is:" << endl;
    dump_landmark (root_lm);
    if (exists_method_relevant_to_lm (root_lm)) {
        cout << "method exists for this lm" << endl;
        GoalNetworkEntry *gne;

        if (!is_visited [root_lm->get_id ()]) {
            cout << "new relevant lm, generating new GNE object" << endl;
            // is_visited [root_lm->get_id ()] = true;
            gne = get_gne_from_lm (inferred_goals.size () + 1, root_lm);
            inferred_goals.insert (make_pair(root_lm, gne));
        }

        else {
            cout << "old relevant lm, retrieving existing GNE object" << endl;
            gne = inferred_goals [root_lm];
        }

        if (parent_ptr != NULL) {
            cout << "parent is:" << endl;
            parent_ptr->pretty_print (); 
            (gne->parents).insert (parent_ptr);
            (parent_ptr->children).insert (gne);
        }
        cout << "gne is " << gne << endl;
        gne->pretty_print ();
        cout << "gne p-printed" << endl;

        parent_ptr = gne;
    }

    if (!is_visited [root_lm->get_id ()] || ((!exists_method_relevant_to_lm (root_lm)) && (parent_ptr != NULL))) {
        is_visited [root_lm->get_id ()] = true;
        __gnu_cxx::hash_map<LandmarkNode *, edge_type, hash_pointer> &children = root_lm->children;
        // cout << "going for " << children.size() << " children of LM " << root_lm->get_id () << endl;
        for (__gnu_cxx::hash_map<LandmarkNode *, edge_type, hash_pointer>::const_iterator ch_it = children.begin (); ch_it != children.end (); ch_it++) {
            LandmarkNode *child_ptr = ch_it->first;
            cout << "trying LM " << child_ptr->get_id () << ", child of LM " << root_lm->get_id () << endl;
            // dump_landmark (child_ptr);
            // cout << endl;

            extract_gn_from_root (parent_ptr, child_ptr, is_visited, inferred_goals);
        }
        cout << "done with children of LM " << root_lm->get_id () << endl;
    }
}

void GoalNetwork::insert_nodes_from_landmark_graph (GoalNetworkEntry *child, LandmarkGraphGDP &lmg) {
    int num_nodes_in_lmg = lmg.number_of_landmarks (); 
    vector<bool> is_visited;
    is_visited.resize (num_nodes_in_lmg, false);
    map<LandmarkNode *, GoalNetworkEntry *> inferred_goals;

    for (int i = 0; i < num_nodes_in_lmg; i++) {
        // if the node has not yet been visited, then 
        // start DFS from i
        if (!is_visited [i]) {
            LandmarkNode *lmn = lmg.get_lm_for_index (i);
            cout << "DFS reached this LM node:" << endl;
            lmg.dump_node (lmn); 
            // is_visited [i] = true;
            extract_gn_from_root (NULL, lmn, is_visited, inferred_goals);
        }
    }

    cout << "inferred goal network is:" << endl;
    for (auto it = inferred_goals.begin (); it != inferred_goals.end (); it++) {
        GoalNetworkEntry *ptr = it->second;
        ptr->pretty_print (); 
        cout << endl;
    }

    cout << "new child is:" << endl;
    child->pretty_print (); 
    
    //now, insert all of the GNEs in inferred_goals, inserting the ones without children
    //as parents of 'child'
    //also insert the ones without parents into source_nodes
    vector<GoalNetworkEntry *> new_nodes;
    for (auto inf_it = inferred_goals.begin (); inf_it != inferred_goals.end (); inf_it++) {
        GoalNetworkEntry *ptr = inf_it->second;
        new_nodes.push_back (ptr);
    }

    cout << "size of new_nodes is " << new_nodes.size () << endl;

    vector<GoalNetworkEntry *> new_children;
    new_children.push_back (child);
    insert_gnes (new_children, new_nodes);

    // dump ();  
}

void GoalNetwork::insert_gnes (vector<GoalNetworkEntry *> &children, vector<GoalNetworkEntry *> &nodes) {
    int inc_id = max_id;
    cout << "max_id is " << max_id << ", inc_id is " << inc_id << endl;

    // firstly, remove children from source_nodes since 
    // they're going to have a parent now
    for (auto it_child = children.begin (); it_child != children.end (); it_child++) {
        GoalNetworkEntry *ch = *it_child;
        source_nodes.erase (ch);
    }
    
    for (auto it = nodes.begin (); it != nodes.end (); it++) {
        GoalNetworkEntry *ptr = *it;

        // update id of ptr based on current max_id
        ptr->id += inc_id;
        max_id ++; 
        cout << "max_id is now " << max_id << endl; 

        // update nodeid_map with new node
        nodeid_map.insert (make_pair (ptr->id, ptr));

        // if ptr has no children, add as parent to each node in children
        if ((ptr->children).size () == 0) {
            // cout << "new parent of child has arrived" << endl;
            // ptr->pretty_print ();
            cout << endl; 
            for (auto it_child = children.begin (); it_child != children.end (); it_child++) {
                GoalNetworkEntry *ch = *it_child;
                (ch->parents).insert (ptr);
                (ptr->children).insert (ch);
            }
        }

        // if ptr has no parents, add to source_nodes
        if ((ptr->parents).size () == 0) {
            // cout << "new source node has arrived" << endl;
            // ptr->pretty_print ();
            cout << endl; 
            source_nodes.insert (ptr);
        }
    }

    /*
    cout << "source nodes are:" << endl;
    for (auto sn_it = source_nodes.begin (); sn_it != source_nodes.end (); sn_it++) {
        (*sn_it)->pretty_print (); 
    }
    */


    cout << "source nodes after removing children:" << endl;
    for (auto sn_it = source_nodes.begin (); sn_it != source_nodes.end (); sn_it++) {
        (*sn_it)->pretty_print (); 
    }
}
