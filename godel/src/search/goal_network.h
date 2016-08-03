#ifndef GOAL_NETWORK_H
#define GOAL_NETWORK_H

#include <vector>
#include <iostream>
#include <map>
#include <set>

#include "state.h"
#include "landmarks/landmark_graph_gdp.h"
// #include "method.h"

typedef std::vector<std::pair<int, int> > goal_formula;
typedef std::vector<goal_formula> disj_goal_formula;

struct GoalNetworkEntry;

// struct gne_compare;

class State;
class LandmarkGraphGDP;

struct gne_compare {
    bool operator() (const GoalNetworkEntry *gne1, const GoalNetworkEntry *gne2); 
};


typedef std::set<GoalNetworkEntry *, gne_compare> vertex_set;

// every formula is modeled as a disjunction of conjunctions (DNF)
struct GoalNetworkEntry {
    int id;
    const disj_goal_formula f;
    vertex_set parents;
    vertex_set children;

    GoalNetworkEntry (int node_id, const disj_goal_formula &gf)
        : id (node_id), f (gf) {}

    GoalNetworkEntry (int node_id, const disj_goal_formula &gf, vertex_set &gf_parents, vertex_set &gf_children)
        : id (node_id), f (gf), parents (gf_parents), children (gf_children) {
        /*
        std::cout << "entered GNE constructor " << std::endl;
        std::cout << "formula size is " << f[0].size() << std::endl;
        for (int j = 0; j < f.size(); j++) {
            std::cout << "disj " << j << std::endl;
            for (int i = 0; i < f[j].size(); i++)
                std::cout << f[j][i].first << ":=" << f[j][i].second << std::endl;
                std::cout << std::endl;
        }
        std::cout << "exiting GNE constructor" << std::endl;
        */
    }
    
    bool operator== (const GoalNetworkEntry &other);

    void pretty_print ();
};

typedef std::map<int, GoalNetworkEntry *> id_map;

class GoalNetwork {
    vertex_set source_nodes;
    id_map nodeid_map;
    int max_id; 

    public:
    GoalNetwork (const goal_formula &g);
    GoalNetwork (const GoalNetwork &other);

    void pretty_print (int node_id);
    const vertex_set &get_source_nodes () const {return source_nodes;}
    int get_num_nodes () const {return nodeid_map.size();}
    const id_map &get_nodeid_map () const {return nodeid_map;}
    int get_max_id () const {return max_id;}
    bool is_empty () const {return (get_num_nodes () == 0);}
    vector<int> get_satisfied_source_ids (const State &s);
    bool is_there_satisfied_source_node (const State &s);
    void get_unsatisfied_facts_from_source (const State &s, goal_formula &unsat_f);
 
    void insert_nodes_from_landmark_graph (GoalNetworkEntry *child, LandmarkGraphGDP &lmg);    
    void insert_subgoal_front (const disj_goal_formula &g);
    void insert_subgoal_front (const goal_formula &g);
    int insert_subgoal_front (int child_id, const disj_goal_formula &g);
    int insert_subgoal_front (int child_id, const goal_formula &g);
    void insert_subgoals (const std::vector<goal_formula> &subgoals);
    int insert_subgoals (int child_id, const std::vector<goal_formula> &subgoals);
    void insert_goal_network (GoalNetwork &other_network);
    void insert_gnes (vector<GoalNetworkEntry *> &children, vector<GoalNetworkEntry *> &nodes); 
    void remove_vertex (GoalNetworkEntry *vertex);
    void remove_vertex (int id);

    void simplify (); 

    int hash() const;
    bool operator== (const GoalNetwork &other);

    void dump () const;
};

/*
namespace std {
    void pair_methods_with_source_nodes (
            std::vector<const Method *> &methods, 
            const std::set<GoalNetworkEntry *, gne_compare> &source_nodes, 
            std::map<const Method *, std::set<int> > &m_id_map);
}
*/

#endif
