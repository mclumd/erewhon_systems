#ifndef GDP_SEARCH_H
#define GDP_SEARCH_H

#include <vector>
#include <set>

#include "state.h"
#include "goal_list.h"
#include "gdp_closed_list.h"
#include "gdp_heuristic.h"
#include "option_parser_util.h"
#include "landmarks/landmark_graph_gdp.h"
#include "goal_network.h"
#include "gdp_network_cl.h"
#include "lisp_interface.h"

class Heuristic;
class Operator;
class ScalarEvaluator;
class Options;
class Method;
class GoalRelevancyInfo;

typedef std::vector<const Option *> Plan;

/*
 * Notes for GDP search: class has the following class variables:
 *  - current_state of type State
 *  - goal_list of type list(vector<pair<int, int>>)
 *  - open_list of type list(pair<state-change, goal-list-change>)
 *
 *  solve():
 *  This is the main function of GDPSearch. it takes the current state 
 *  and goal-list. It then finds all relevant and applicable actions and 
 *  methods, adds the options to the open_list in the form of <state-change,
 *  goal-list-change> pairs. 
 *
 *    
 */ 

class GDPSearch {
    private:
    State *initial_state;
    GoalList *initial_gl;
    GoalNetwork *initial_gn; 
    // GoalNetwork *copy; 
    Plan plan;
    GDP_Closed_List *closed_list;
    GDPHeuristic *gdp_h;
    GoalRelevancyInfo *goal_relevancy_info;
    Options opts;

    GDP_Network_CL *network_cl;

    
    public:
    GDPSearch();
    void initialize();
    bool solve ();
    bool solve(State *state, GoalNetwork *gn);
    Plan get_plan ();
    Lisp_Interface *lisp_server_interface;

    private:
    void get_applicable_and_relevant_ops_and_methods (
            State *current_state,
            const goal_formula &g,
            std::vector<const Operator *> &ops,
            std::vector<const Method *> &methods, 
            std::vector<const Operator *> &app_ops); 
    void get_applicable_and_relevant_methods (
            const goal_formula &g,
            std::vector<const Method *> &methods); 
    void get_applicable_and_relevant_methods_using_sockets (
            const goal_formula &g,
            std::vector<const Method *> &methods); 
    void append_to_plan (const Option *op);
    void pair_methods_with_source_nodes (
            std::vector<const Method *> &methods, 
            const std::set<GoalNetworkEntry *, gne_compare> &source_nodes, 
            std::map<const Method *, std::set<int> > &m_id_map);
    LandmarkGraphGDP *get_landmark_graph (State *s, const goal_formula &top_gf);
};

void remove_sat_literals (
        State &current_state, 
        const goal_formula &top_gf, 
        goal_formula &unsat_f); 

void retrieve_method_instances_from_server_msg (
        stringstream &msg,
        vector<const Method *> &app_and_rel_methods);

#endif
