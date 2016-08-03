#include <cassert>
#include <iostream>
#include <limits>
#include <algorithm>
#include <map>
#include <fstream>
#include <sstream>
#include <pstream.h>
using namespace std;

#include "gdp_search.h"
#include "operator.h"
#include "successor_generator.h"
#include "goal_relevancy_info.h"
#include "option_parser.h"
#include "plstate.h"
#include "globals.h"
#include "lifted_method.h"
#include "timer.h"
#include "method.h"
#include "landmarks/landmark_graph_gdp.h"
#include "landmarks/landmark_factory_gdp_rpg_sasp.h"
#include "landmarks/exploration_gdp.h"
#include "goal_network.h"

/* struct Method_with_heuristic_value;

struct Method_with_heuristic_value {
    Method *m;
    int heur_value;
};
*/

GDPSearch::GDPSearch() {
    initial_state = new State(*g_initial_state);
    // cout << "\ncurrent_state is as follows:" << endl;
    // initial_state->dump();
    initial_gl = new GoalList (g_goal);
    initial_gn = new GoalNetwork (g_goal);
    // copy = new GoalNetwork (*initial_gn);
    cout << "\ngoal_network is as follows:" << endl;
    initial_gn->dump();
    // cout << "\n its copy is as follows:" << endl;
    // copy->dump();
    // cout << "testing equality of goal networks: " << (*initial_gn == *copy) << endl;
}

// This is be where the various
// auxiliary data structures for heuristic computation, 
// closed lists, etc are be set up.
void GDPSearch::initialize() {
    goal_relevancy_info = new GoalRelevancyInfo (); 
    // goal_relevancy_info->dump();

    GDP_Search_Node first_node(initial_state, initial_gl);
    closed_list = new GDP_Closed_List (first_node);
    // cout << "closed list is:" << endl;
    // closed_list->dump();
    
    // closed list for state,goal_network pairs
    GDP_Network_Node first_network_node (initial_state, initial_gn);
    network_cl = new GDP_Network_CL (first_network_node);
    cout << "network_cl is:" << endl;
    network_cl->dump();
    cout << "testing membership:" << network_cl->is_there (first_network_node) << endl;

    g_gdp_nodes_expanded += 1;
    g_total_gdp_nodes += 1;
    
    g_current_state = g_initial_state;
    g_current_goal = &g_goal;

    opts = Options ();
    opts.set<int>("cost_type", 1);
    opts.set<ExplorationGDP *>("explor", new ExplorationGDP(opts));
    opts.set<bool>("reasonable_orders", false);
    opts.set<bool>("only_causal_landmarks", false);
    opts.set<bool>("disjunctive_landmarks", true);
    opts.set<bool>("conjunctive_landmarks", true);
    opts.set<bool>("no_orders", false);
    opts.set<int> ("lm_cost_type", 1);
    gdp_h = new GDPHeuristic (opts);
    gdp_h->initialize ();

    // set up Lisp Server Interface
    // TODO: in future, can set up more fancy checks (eg. if alisp is 
    // available)
    lisp_server_interface = new Lisp_Interface ();
    //vector<const Method *> aarm;
    //get_applicable_and_relevant_methods_using_sockets (g_goal, aarm);
}

bool GDPSearch::solve () {
    return solve (initial_state, initial_gn);
}

// This is the main search function. Returns a bool
// *status* where status = true if SUCCESS, false if 
// FAILURE and the class variable Plan is to be used 
// only if status=true.  
bool GDPSearch::solve(State *current_state, GoalNetwork *gn) {
    //first, base case -- if gl is empty, then we're done
    if (gn->is_empty()) {
        return true;
    }

    if (((int) (g_lisp_timer + g_timer ())) > g_gdp_timelimit) {
        g_gdp_timelimit_reached = true;
        return false;
    }

    cout << "\nPlan so far is:" << endl;
    for (int i = 0; i < plan.size(); i++) {
        if (plan[i]->is_operator())
            cout << "-- " << ((Operator *)plan[i])->get_name () << endl;
        else  
            cout << "-- " << ((Method *)plan[i])->get_name () << endl;
    }

    int num_unsat_g = 0;
    cout << "\n goals left to be achieved are:" << endl;
    for (int i = 0; i < g_goal.size (); i++) {
        if ((*current_state) [g_goal[i].first] != g_goal [i].second) {
            cout << "-- " << g_fact_names[g_goal[i].first][g_goal[i].second] << endl;
            num_unsat_g++; 
        }
    }
    cout << "\nnum_unsat_g = " << num_unsat_g << endl;
    
    // cout << "current state is:" << endl;
    // g_plstate->dump ();
    cout << "gn " << " is:" << endl;
    gn->dump (); 

    // first get ids of source nodes already satisfied in the current state
    vector<int> sat_ids = gn->get_satisfied_source_ids (*current_state); 

    // if sat_ids is not empty, there exists some GNEs satisfied in current_state
    for (int i = 0; i < sat_ids.size(); i++) {
        // create a new goal-network and remove sat_ptr from that
       
        cout << "\none of the source nodes satisfied in the current state:" << endl;
        gn->pretty_print (sat_ids [i]);
        /*
        const id_map &gn_map = gn->get_nodeid_map (); 
        const GoalNetworkEntry *sat_ptr = gn_map [sat_ids [i]];
        sat_ptr->pretty_print ();
        */
        
        // cout << "original gn is:" << endl;
        // gn->dump (); 
        GoalNetwork &new_gn = *(new GoalNetwork (*gn));
        cout << "after copy constructor, new_gn is:" << endl;
        new_gn.dump (); 
        cout << "original gn is:" << endl;
        gn->dump (); 
        new_gn.remove_vertex (sat_ids[i]);
        cout << "\nafter removing vertex, new_gn is:" << endl;
        new_gn.dump (); 


        // now closed_list comes into play. Need to see
        // if the new (s,gn) pair is in it. If so, return fail.
        GDP_Network_Node possibly_new_node (current_state, &new_gn);
        if (network_cl->is_there (possibly_new_node)) {
            cout << "cycle!" << endl;
            //try next option
            continue;
        }

        // *possibly_new_node* is not there in closed list. 
        // So add it to closed_list.
        else {
            network_cl->add_node (possibly_new_node);
            // cout << "\nafter adding top_g_satisfied node to closed list, closed list is:" << endl;
            // closed_list->dump ();
            // cout << endl;

            g_total_gdp_nodes += 1;
            // now, call solve() on the resulting (s,gn) pair
            // if solvable (a solution is found for (s,gn)), then
            // return true, else try next option
            bool result = solve(current_state, &new_gn);
            if (result)
                return true;
            else continue;
        } 
    }

    cout << "sat_ids did not working, trying methods and ops" << endl;

    cout << "\ntesting state:" << endl;
    current_state->dump ();
    cout << "\ntesting gn:" << endl;
    gn->dump (); 
    
    // if code comes here,  calculate the 
    // set of relevant and applicable actions and methods and try
    // to apply them one after the other
    // else {
    vector<const Operator *> ops;
    vector<const Method *> methods;
    vector<const Operator *> app_ops;
    vector<pair<int, const Option *> > search_options;

    goal_formula unsat_f;
    gn->get_unsatisfied_facts_from_source (*current_state, unsat_f);
    cout << "\ngot unsat_f" << endl;
    for (auto ufit = unsat_f.begin (); ufit != unsat_f.end (); ufit++) {
        cout << "-- " << g_fact_names [ufit->first][ufit->second] << endl;
    }

    // if unsat_f is empty, then it means that all goals w/o predecessors are 
    // satisfied in the current state. Since the recursive call with removing
    // them from the goal network didn't work and unsat_f is empty, then 
    // nothing can be done ... return failure

    if (unsat_f.size () == 0)
        return false;

    // if it gets here, it means that there exists some predecessor task that 
    // is not satisfied in the current state
    get_applicable_and_relevant_ops_and_methods (current_state, unsat_f, ops, methods, app_ops);
    cout << "num of applicable and relevant ops is " << ops.size() << endl;

    // cout << "testing writing to problem file" << endl;
    //get_applicable_and_relevant_methods (unsat_f, methods);
    get_applicable_and_relevant_methods_using_sockets (unsat_f, methods);
    cout << "there are " << methods.size() << " applicable and relevant methods" << endl;
    // char x;
    // cin >> x;
    
    ///*
    cout << "these are the applicable and relevant methods:" << endl;
    for (int i = 0; i < methods.size(); i++)
        cout << methods[i]->get_name () << endl;
    cout << endl;
    //*/
    
    // now to pair each method with possible source nodes in the
    // goal network that it could be relevant to
    map<const Method *, set<int> > method_node_map;
    pair_methods_with_source_nodes (methods, gn->get_source_nodes (), method_node_map); 

    // evaluate each method with heuristic
    vector<pair<int, const Method *> > methods_with_heur_values;
    for (int i = 0; i < methods.size(); i++) {
        int h_value = gdp_h->compute_heuristic (*current_state, *methods[i]);
       
        // if any of the subgoals of the method aren't reachable ... 
        if (h_value == -1)
            continue; 
        
        methods_with_heur_values.push_back (make_pair(h_value, methods[i]));
    }

    sort (methods_with_heur_values.begin(), methods_with_heur_values.end());

    /*
    for (int i = 0; i < methods_with_heur_values.size(); i++) {
        cout << "method " << (methods_with_heur_values[i].second)->get_name() << " with value " << methods_with_heur_values[i].first << endl;
    }
    */
    
    for (int j = 0; j < ops.size(); j++)
        search_options.push_back (make_pair (-1, ops[j]));
    for (int j = 0; j < methods_with_heur_values.size(); j++) {
        // methods[j]->dump ();
        // cout << "heur value is " << gdp_h->compute_heuristic (*current_state, *(methods[j])) << endl;
        set<int> &m_source_ids = method_node_map [methods_with_heur_values[j].second];
        for (auto msi_it = m_source_ids.begin (); msi_it != m_source_ids.end (); msi_it++)
            search_options.push_back (make_pair (*msi_it, methods_with_heur_values[j].second));
    }

    cout << "search_options is of size " << search_options.size () << endl;
    
    // now, we have applicable and relevant ops and methods ... next step 
    // is to try each of them and backtrack if failure 
    for (int opts_index = 0; opts_index < search_options.size(); opts_index++) {
        int node_id = search_options[opts_index].first;
        const Option *current_option = search_options[opts_index].second;

        // if current_option is an operator ...
        if (current_option->is_operator()) {
            Operator &op = *((Operator *)current_option);
            cout << "trying operator " << op.get_name () << endl;
            // first progress the state (non-destructive)
            State &new_state = *(new State (*current_state, op));

            // now closed_list comes into play. Need to see
            // if the new (s,gl) pair is in it. If so, return fail.
            cout << "\nnew_state:" << endl;
            new_state.dump ();
            cout << "\ngn:" << endl;
            gn->dump ();
            GDP_Network_Node possibly_new_node (&new_state, gn);
            cout << "created possibly_new_node" << endl;
            if (network_cl->is_there (possibly_new_node)) {
                cout << "cycle! trying next option\n" << endl;
                //restore the original state and try next option
                continue;
            }

            // *possibly_new_node* is not there in closed list. 
            // So add it to closed_list.
            else {
                network_cl->add_node (possibly_new_node);
                g_gdp_nodes_expanded += 1;
                g_total_gdp_nodes += 1;
                // cout << "\nafter adding op node to closed list, closed list is:" << endl;
                // closed_list->dump ();
                // cout << endl;
            } 
            
            // next add pointer to op to the current plan
            append_to_plan (&op);
            // state is now dirty, set flag
            g_state_clean = false;
            // also progress g_plstate
            g_plstate->progress_state (op); 
            // now call solve () on the resulting search problem
            bool result = solve (&new_state, gn);
            // if a solution is found ...
            if (result) {
                return true;
            }
            
            // if no solution is found, then remove &op from plan and 
            // regress g_plstate
            else {
                plan.pop_back ();
                g_plstate->regress_state (op); 
                continue; // try the next option
            }
        }

        else { // current_option is a method
            const Method &m = *((Method *)current_option);
            cout << "\ntrying method " << m.get_name() << endl;
            m.dump ();

            // state remains the same, only goal list changes
            const vector<goal_formula> &m_sg = m.get_subgoals ();
            cout << "max_id of gn is " << gn->get_max_id () << endl;
            GoalNetwork &new_gn = *(new GoalNetwork (*gn));
            /*
            cout << "max_id of new_gn is " << new_gn.get_max_id () << endl;
            cout << "going to use method, so copied gn. new_gn is:" << endl;
            new_gn.dump (); 
            */

            const vector<VarVal> &m_goal = m.get_goal (); 
            goal_formula m_gf;
            for (int mg_count = 0; mg_count < m_goal.size(); mg_count++)
                m_gf.push_back(make_pair(m_goal[mg_count].var, m_goal[mg_count].val));
            sort (m_gf.begin(), m_gf.end());
            /*
            cout << "node_id of the child is " << endl;
            int m_gf_id = new_gn.insert_subgoal_front (node_id, m_gf);
            new_gn.insert_subgoals (m_gf_id, m_sg);
            */
            cout << "node_id of the child is " << node_id << endl;

            new_gn.insert_subgoal_front (m_gf);
            new_gn.insert_subgoals (m_sg);
            cout << "\nprinting goal_network after inserting subgoals:" << endl;
            new_gn.dump ();
            
            cout << "\nsimplifying new_gn now" << endl;
            new_gn.simplify();
            cout << "\nafter simplifying ... " << endl;
            new_gn.dump ();
            cout << "\nsimplifying done" << endl;
            // copy = new GoalNetwork (*initial_gn);
            // cout << "printing copy after inserting subgoals:" << endl;
            // copy->dump ();
            // cout << "testing equality after inserting subgoals: " << (*copy == *initial_gn) << endl;

            /*
            // testing simplify
            copy->simplify (); 
            copy->dump (); 

            cout << "after inserting method's subgoals ... " << endl; 
            new_gl.dump ();
            cout << "done inserting subgoals" << endl;
            

            new_gl.simplify();
            cout << "after simplifying ... " << endl;
            new_gl.dump ();
            cout << "simplifying done" << endl;
            */
            /*
            const vertex_set &sn = copy->get_source_nodes (); 
            GoalNetworkEntry *st = *(sn.begin());
            GoalNetworkEntry *ch = *((st->children).begin());

            cout << "del_node id: " << ch->id << endl;
            copy->remove_vertex (ch);
            copy->dump (); 
            */

            // now closed_list comes into play. Need to see
            // if the new (s,gl) pair is in it. If so, return fail.
            GDP_Network_Node possibly_new_node (current_state, &new_gn);
            if (network_cl->is_there (possibly_new_node)) {
                cout << "cycle! trying next option" << endl;
                //restore the original goal_list and try next option
                continue;
            }

            // *possibly_new_node* is not there in closed list. 
            // So add it to closed_list.
            else {
                network_cl->add_node (possibly_new_node);
                g_gdp_nodes_expanded += 1;
                g_total_gdp_nodes += 1;
                // cout << "\nafter adding method node to closed list, closed list is:" << endl;
                // closed_list->dump ();
                // cout << endl;
            }
            
            //just changed goal_network
            g_infer_subgoals = true;

            // adding methods to plan
            append_to_plan (&m);
            // now the (state,goal-list) pair is ready. call solve ()
            bool result = solve (current_state, &new_gn); 

            if (result) {
                g_num_methods_applied += 1;
                return true;
            }
            
            // if no solution is found, then try the next option
            else {
                plan.pop_back (); 
                continue;
            }
        }
    }

    
    // if it reaches here, it implies none of the option worked
    // so return failure
    cout << "\nno methods available, constructing landmark graph" << endl;

    // now what we have is a set of source nodes in the goal network
    // for which we could generate the landmark graph
    const vertex_set &sn = gn->get_source_nodes (); 
    for (auto sn_it = sn.begin (); sn_it != sn.end (); sn_it++) {
        GoalNetworkEntry *node_ptr = *sn_it;
        const disj_goal_formula &node_f = node_ptr->f;
        
        if (g_infer_subgoals) {
            for (auto f_it = node_f.begin (); f_it != node_f.end (); f_it++) {
                // first create a copy of gn that you can modify
                GoalNetwork &new_gn = *(new GoalNetwork (*gn));

                // get ptr to the copy of node_ptr in new_gn
                auto ptr_it = (new_gn.get_nodeid_map ()).find (node_ptr->id);
                assert (ptr_it != (new_gn.get_nodeid_map ()).end ());
                node_ptr = ptr_it->second;

                const goal_formula &top_gf = *f_it;
                goal_formula unsat_gf;
                remove_sat_literals (*current_state, top_gf, unsat_gf);
                cout << "printing formula left to be satisfied:" << endl;
                for (int i = 0; i < unsat_gf.size (); i++)
                    cout << " -- " << g_fact_names[unsat_gf[i].first][unsat_gf[i].second] << endl;
                LandmarkGraphGDP *lmg = get_landmark_graph (current_state, unsat_gf);
                // g_plstate->dump(); 
                lmg->dump ();
                lmg->dump_landmarks (); 

                new_gn.insert_nodes_from_landmark_graph (node_ptr, *lmg);

                cout << "\n inserted nodes into LM graph, new_gn is now like this:" << endl;
                new_gn.dump (); 
                cout << "simplifying new_gn ..." << endl;
                new_gn.simplify ();
                new_gn.dump (); 
                cout << "\nfinished simplifying new_gn" << endl;

                GDP_Network_Node possibly_new_node (current_state, &new_gn);
                cout << "about to check closed list " << network_cl << endl;
                if (network_cl->is_there (possibly_new_node)) {
                    cout << "cycle after inserting subgoals from LM graph!" << endl;
                    //try next option
                    continue;
                }

                // *possibly_new_node* is not there in closed list. 
                // So add it to closed_list.
                else {
                    network_cl->add_node (possibly_new_node);
                    g_gdp_nodes_expanded += 1;
                    g_total_gdp_nodes += 1;
                    // cout << "\nafter adding method node to closed list, closed list is:" << endl;
                    // closed_list->dump ();
                    // cout << endl;
                }

                // now, call solve() on the resulting (s,gn) pair
                // if solvable (a solution is found for (s,gn)), then
                // return true, else try next option
                cout << "about to recurse ... " << endl;
                bool result = solve(current_state, &new_gn);
                if (result)
                    return true;
                else continue;
                
                // exit (0);
            }
        }

        /*
        // first let's try preferred ops
        for (auto g_it = node_f.begin (); g_it != node_f.end (); g_it++) {
            const goal_formula &gf = *g_it;
            gdp_h->compute_heuristic (*current_state, gf);
            vector<const Operator *> pref_ops;
            gdp_h->get_preferred_operators (pref_ops);
            for (auto pref_it = pref_ops.begin (); pref_it != pref_ops.end (); pref_it++) {
                const Operator &op = *(*pref_it);
                cout << "trying action_chaining preferred operator " << op.get_name () << endl;
                // first progress the state (non-destructive)
                State &new_state = *(new State (*current_state, op));

                // now closed_list comes into play. Need to see
                // if the new (s,gl) pair is in it. If so, return fail.
                GDP_Network_Node possibly_new_node (&new_state, gn);
                if (network_cl->is_there (possibly_new_node)) {
                    cout << "cycle! trying next option\n" << endl;
                    //restore the original state and try next option
                    continue;
                }

                // *possibly_new_node* is not there in closed list. 
                // So add it to closed_list.
                else {
                    network_cl->add_node (possibly_new_node);
                    g_gdp_nodes_expanded += 1;
                    g_total_gdp_nodes += 1;
                    // cout << "\nafter adding op node to closed list, closed list is:" << endl;
                    // closed_list->dump ();
                    // cout << endl;
                } 
                
                // next add pointer to op to the current plan
                append_to_plan (&op);
                // state is now dirty, set flag
                g_state_clean = false;
                // just did action chaining, set flag
                g_infer_subgoals = false;
                // also progress g_plstate
                g_plstate->progress_state (op); 
                // now call solve () on the resulting search problem
                bool result = solve (&new_state, gn);
                // if a solution is found ...
                if (result) {
                    g_num_actions_chained += 1;
                    return true;
                }
                
                // if no solution is found, then remove &op from plan and 
                // regress g_plstate
                else {
                    plan.pop_back ();
                    g_plstate->regress_state (op); 
                    continue; // try the next option
                }
            }
        }

        cout << "\npreferred ops didn't work, trying all other applicable ops" << endl;
        */

        // now try operators that are not preferred
        vector<pair<int, pair<const Operator *, State *> > > successor_states_h;
        State *succ_state;
        for (auto g_it = node_f.begin (); g_it != node_f.end (); g_it++) {
            const goal_formula &gf = *g_it;
            cout << "\ngoal for action chaining is:" << endl;
            for (int i = 0; i < gf.size (); i++)
                cout << "-- " << g_fact_names[gf[i].first][gf[i].second] << endl;
            for (auto ao_it = app_ops.begin (); ao_it != app_ops.end (); ao_it++) {
                const Operator *app_op = *ao_it;
                cout << "evaluating op " << app_op->get_name () << endl;
                succ_state = new State (*current_state, *app_op);
                int ao_h = gdp_h->compute_heuristic (*succ_state, gf);
                cout << "heuristic value is " << ao_h << endl;
                successor_states_h.push_back (make_pair (ao_h, make_pair (app_op, succ_state)));
            }
        }

        sort (successor_states_h.begin (), successor_states_h.end ());
        for (auto ssh_it = successor_states_h.begin (); ssh_it != successor_states_h.end (); ssh_it++) {
            const Operator &op = *((ssh_it->second).first);
            cout << "trying action_chaining operator " << op.get_name () << endl;
            // first progress the state (non-destructive)
            State &new_state = *((ssh_it->second).second);

            // now closed_list comes into play. Need to see
            // if the new (s,gl) pair is in it. If so, return fail.
            GDP_Network_Node possibly_new_node (&new_state, gn);
            if (network_cl->is_there (possibly_new_node)) {
                cout << "cycle! trying next option\n" << endl;
                //restore the original state and try next option
                continue;
            }

            // *possibly_new_node* is not there in closed list. 
            // So add it to closed_list.
            else {
                network_cl->add_node (possibly_new_node);
                g_gdp_nodes_expanded += 1;
                g_total_gdp_nodes += 1;
                // cout << "\nafter adding op node to closed list, closed list is:" << endl;
                // closed_list->dump ();
                // cout << endl;
            } 
            
            // next add pointer to op to the current plan
            append_to_plan (&op);
            // state is now dirty, set flag
            g_state_clean = false;
            // just did action chaining, set flag
            g_infer_subgoals = false;
            // also progress g_plstate
            g_plstate->progress_state (op); 
            // now call solve () on the resulting search problem
            bool result = solve (&new_state, gn);
            // if a solution is found ...
            if (result) {
                g_num_actions_chained += 1;
                return true;
            }
            
            // if no solution is found, then remove &op from plan and 
            // regress g_plstate
            else {
                plan.pop_back ();
                g_plstate->regress_state (op); 
                continue; // try the next option
            }

        }
    }

    // LandmarkGraphGDP *lmg = get_landmark_graph (current_state, top_gf);
    // g_plstate->dump(); 
    // lmg->dump ();
    // lmg->dump_landmarks (); 


    return false;
    // }
}

void GDPSearch::get_applicable_and_relevant_ops_and_methods (
        State *current_state,
        const goal_formula &g,
        vector<const Operator *> &ops, 
        vector<const Method *> &methods, 
        vector<const Operator *> &app_ops) {
    vector<const Operator *> applicable_ops;
    vector<const Method *> applicable_methods;
    cout << "\nabout to generate applicable ops" << endl;

    g_successor_generator->generate_applicable_ops_and_methods (
            *current_state, 
            applicable_ops, 
            applicable_methods);
    sort (applicable_ops.begin(), applicable_ops.end());
    sort (applicable_methods.begin(), applicable_methods.end());

    /*
    cout << "applicable ops are:" << endl;
    for (int i = 0; i < applicable_ops.size(); i++) {
        cout << "[" << i << "] = " << applicable_ops[i]->get_name() << endl;
    }

    cout << "applicable methods are:" << endl;
    for (int i = 0; i < applicable_methods.size(); i++) {
        cout << "[" << i << "] = " << applicable_methods[i] << " " << applicable_methods[i]->get_name() << endl;
    }
    */
    
    
    goal_relevancy_info->generate_applicable_and_relevant_ops_and_methods(
            g,
            applicable_ops,
            applicable_methods,
            ops,
            methods, 
            app_ops);
    cout << "\nnow about to generate applicable and relevant ops" << endl;
}

void GDPSearch::pair_methods_with_source_nodes (
        vector<const Method *> &methods,
        const vertex_set &source_nodes,  
        map<const Method *, set<int> > &m_id_map) {
    map<pair<int, int>, vector<int> > lit_source_id_map; 

    /*
    for (auto m_it = methods.begin(); m_it != methods.end(); m_it++) {
        const Method *m_ptr = *m_it;
        const vector<VarVal> &m_goal = m_ptr->get_goal ();
        vector<pair<int, int> > &m_lits = method_lit_map[m_ptr];
        for (int i = 0; i < m_goal.size(); i++) {
            m_lits.push_back (make_pair (m_goal[i].var, m_goal[i].val));
        }
    }
    */

    // first build the lit_source_id_map, i.e. a mapping from facts
    // (<var, val> pairs) to a list of source ids in which they are present
    for (auto s_it = source_nodes.begin(); s_it != source_nodes.end(); s_it++) {
        const disj_goal_formula &s_f = (*s_it)->f;
        int s_id = (*s_it)->id;
        for (int i = 0; i < s_f.size(); i++) {
            const goal_formula &s_c = s_f[i];
            for (int j = 0; j < s_c.size(); j++) {
                const pair<int, int> &lit = s_c[j];
                vector<int> &ids = lit_source_id_map[lit];
                ids.push_back (s_id);
                // m_lits.push_back (make_pair (m_goal[i].var, m_goal[i].val));
            }
        }
    }

    // now for each <var, val> pair in each method's goals, retrieve all
    // source ids and add them to the method's source_id entry
    for (auto m_it = methods.begin (); m_it != methods.end (); m_it++) {
        const Method *m_ptr = *(m_it);
        set<int> &m_ids = m_id_map [m_ptr];
        const vector<VarVal> &m_goals = m_ptr->get_goal ();
        for (int i = 0; i < m_goals.size (); i++) {
            pair<int, int> m_g = make_pair (m_goals[i].var, m_goals[i].val);
            auto it = lit_source_id_map.find (m_g);
            if (it != lit_source_id_map.end ()) {
                vector<int> &ids = it->second;
                m_ids.insert (ids.begin (), ids.end ());
            }
        }
    }
}

void GDPSearch::append_to_plan (const Option *op) {
    plan.push_back (op);
}

Plan GDPSearch::get_plan () {
    return plan;
}

// this function gets applicable and relevant methods by 
// the following procedure:
//  -- write out the current state (predicate version) and
//     current goal as a lisp problem into a file
//  -- run get-bindings.lisp to write out the bindings into a
//     file called bindings.out
//  -- read in that file, get bindings for each method
//  -- ground each method with the obtained bindings and 
//     set app_and_rel_methods to the collection of all such 
//     grounded methods
void GDPSearch::get_applicable_and_relevant_methods (
        const goal_formula &g, 
        vector<const Method *> &app_and_rel_methods) {
    ofstream prob_file ("prob");
    write_lisp_problem (g, prob_file);
    prob_file.close(); 

    // written to file, now run get-bindings.lisp
    stringstream command;
    command << "/opt/acl80.64/alisp -#! get-bindings.lisp " << 
        g_path_to_method_file << " " <<  
        "prob " <<
        "bindings.out > out2";
    // cout << command.str();
    
    g_gdp_timer.stop();

    cout << endl << "trying to execute the lisp command" << endl;
    redi::ipstream proc(command.str(), redi::pstreams::pstderr);
    g_gdp_timer.resume ();
    ///*
    string line;
    // read child's stdout
    while (getline(proc.out(), line))
        cout << "stdout: " << line << 'n';
    // read child's stderr
    while (getline(proc.err(), line))
        cout << "stderr: " << line << 'n';
    //*/

    //having run get-bindings.lisp, read in the bindings

    ifstream bindings_file ("bindings.out");
    int num_bindings;
    bindings_file >> num_bindings;
    bindings_file >> ws;
    cout << num_bindings << " bindings" << endl;
   
    for (int i = 0; i < num_bindings; i++) {
        cout << "trying binding " << i << endl;  
        string g_method;
        getline (bindings_file, g_method); 
        stringstream ss (g_method);
        string m_name;
        getline (ss, m_name, ' '); 
        cout << "method name is " << m_name << endl;
        LiftedMethod &m = (g_lifted_methods.find (m_name))->second;
        m.dump (); 
        const vector<string> &m_args = m.get_args ();
        map<string, string> m_grounding; 
        for (auto a_it = m_args.begin(); a_it != m_args.end(); a_it++) {
            string c;
            getline (ss, c, ' ');
            ss >> ws;
            m_grounding.insert (make_pair(*a_it, c)); 
        }
        /*
        cout << "testing insertion into grounding map" << endl;
        for (auto it = m_grounding.begin(); it != m_grounding.end(); it++)
            cout << "  " << it->first << " -> " << it->second << endl;
        */
        // you have the method object and the groundings, create Method instances
        // based on these two
        Method *x = new Method(m, m_grounding);
        cout << "dumping app_and_rel_method " << x << endl;
        x->dump (); 
        app_and_rel_methods.push_back (x);
    }

    double t;
    bindings_file >> t;
    cout << "lisp took " << t << " seconds to get bindings\n";
    g_lisp_timer += t;
    
    bindings_file.close(); 
    bindings_file.clear();
    // redi::ipstream proc2("rm bindings.out", redi::pstreams::pstderr);
}

/* This function generates the set of applicable and relevant HGN methods
 * given the current state and goal by sending the planning problem 
 * (current_state,goal) to the Lisp Server, getting the computation done there
 * and then getting the data back. 
 */
void GDPSearch::get_applicable_and_relevant_methods_using_sockets (
        const goal_formula &g,
        vector<const Method *> &app_and_rel_methods) {
    stringstream current_problem, msg;
    //cout << g_plstate->to_str() << endl;

    // construct current planning problem and send to Lisp server
    current_problem << "(";
    current_problem << g_plstate->to_str ();
    current_problem << " ";
    current_problem << write_lisp_goal_to_str (g);
    current_problem << ")";
    current_problem << endl;
    
    g_gdp_timer.stop ();

    // send problem to lisp server
    lisp_server_interface->send_msg_to_server (current_problem.str ());
 
    // now wait for response
    lisp_server_interface->recv_msg_from_server (msg);
    //remove (msg.begin (), msg.end (), '\n');
    cout << "msg: " << msg.str () << endl;

    // before anything else, resume gdp timer
    g_gdp_timer.resume ();

    // now parsing msg to retrieve method instances
    retrieve_method_instances_from_server_msg (msg, app_and_rel_methods);

    float time_taken_by_server;
    msg >> time_taken_by_server;
    cout << "time taken by server to calculate bindings: " << time_taken_by_server << endl;
    g_lisp_timer += time_taken_by_server;

    cout << g.size () << " " << app_and_rel_methods.size() << endl;
}
        

void reset_exploration (Options &opts, const goal_formula &gf) {
    ExplorationGDP *exp_gdp = opts.get<ExplorationGDP *> ("explor");
    exp_gdp->cleanup ();
    exp_gdp->reset_goals (gf);
}

LandmarkGraphGDP *GDPSearch::get_landmark_graph (State *current_state, const goal_formula &top_gf) {
    g_current_state = current_state;
    g_current_goal = &top_gf;
    reset_exploration (opts, top_gf);
    LandmarkFactoryGDPRpgSasp lm_graph_factory(opts);
    // LandmarkGraph *graph = lm_graph_factory.compute_lm_graph(st, gf);
    LandmarkGraphGDP *graph = lm_graph_factory.compute_lm_graph();
    // graph->dump (); 
    return graph;
}

void remove_sat_literals (
        State &current_state, 
        const goal_formula &f, 
        goal_formula &unsat_f) {
    for (auto it = f.begin (); it != f.end (); it++) {
        if (current_state[it->first] != it->second)
            unsat_f.push_back (make_pair (it->first, it->second));
    }
}

void retrieve_method_instances_from_server_msg (
        stringstream &msg,
        vector<const Method *> &app_and_rel_methods) {
    int num_methods;
    msg >> num_methods;
    msg >> ws;
    cout << "number of methods: " << num_methods << endl;

    for (int i = 0; i < num_methods; i++) {
        string m_str;
        getline (msg, m_str);
        const Method *x = constr_method_instances_from_str_repr (m_str);
        cout << "[" << i << "]: method constructed is:" << endl;
        x->dump ();

        app_and_rel_methods.push_back (x);
    }

    // simply to avoid silly warnings
    msg.str ();
    app_and_rel_methods.size ();
}

// void GDPSearch::try_action_chaining
