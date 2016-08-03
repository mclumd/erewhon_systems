#ifndef GLOBALS_H
#define GLOBALS_H

#include "operator_cost.h"
#include "state.h"
#include "plstate.h"

#include <iosfwd>
#include <string>
#include <vector>
#include <cassert>
#include <map>
#include <time.h>

struct Literal;

class AxiomEvaluator;
class CausalGraph;
class DomainTransitionGraph;
class Operator;
class Method;
class Option;
class LiftedMethod;
class Axiom;
class State;
class SuccessorGenerator;
class Timer;
class RandomNumberGenerator;
class PLState;

bool test_goal(const State &state);
void save_plan(const std::vector<const Operator *> &plan, int iter);
void save_gdp_plan(const std::vector<const Option *> &plan);
int calculate_plan_cost(const std::vector<const Operator *> &plan);
void write_lisp_problem (const vector<pair<int, int> > &goals, ofstream &out); 
string write_lisp_goal_to_str (const vector<pair<int, int> > &goals);
const pair<string, vector<string> > parse_fact_name (string &fact_name); 
const Method *constr_method_instances_from_str_repr (string &m_str);

/*
namespace std {
    void get_bindings_for_literal (
            const Literal &l,
            const PLState &s,
            const map<string, int> levels_of_vars, 
            vector<map<string, string> > all_bindings);
}
*/

void read_everything(std::istream &in);
void dump_everything();

void verify_no_axioms_no_cond_effects();

void check_magic(std::istream &in, std::string magic);

bool are_mutex(const std::pair<int, int> &a, const std::pair<int, int> &b);


extern bool g_use_metric;
extern int g_min_action_cost;
extern int g_max_action_cost;

// TODO: The following five belong into a new Variable class.
extern std::vector<std::string> g_variable_name;
extern std::vector<int> g_variable_domain;
extern std::vector<std::vector<std::string> > g_fact_names;
extern std::unordered_map<string, std::pair<int, int> > g_literals_to_num_map;
extern std::vector<int> g_axiom_layers;
extern std::vector<int> g_default_axiom_values;
extern std::set<string> g_predicates_methods_achieve;

extern State *g_initial_state;
extern State *g_current_state;
extern std::vector<std::pair<int, int> > g_goal;
extern const std::vector<std::pair<int, int> > *g_current_goal;

extern std::vector<Operator> g_operators;
extern std::vector<Method> g_methods;
extern std::map<string, LiftedMethod> g_lifted_methods;
extern std::vector<Operator> g_axioms;
extern AxiomEvaluator *g_axiom_evaluator;
extern SuccessorGenerator *g_successor_generator;
extern std::vector<DomainTransitionGraph *> g_transition_graphs;
extern CausalGraph *g_causal_graph;
extern Timer g_timer;
extern std::string g_plan_filename;
extern RandomNumberGenerator g_rng;
extern PLState *g_plstate;
extern bool g_state_clean;
extern bool g_infer_subgoals;
extern string g_path_to_method_file;
extern Timer g_gdp_timer;
extern double g_lisp_timer;
extern int g_gdp_timelimit;
extern bool g_gdp_timelimit_reached; 
extern time_t start_timer;
extern time_t end_timer;


// GDP-related statistics
extern int g_total_gdp_nodes;
extern int g_gdp_nodes_expanded;
extern int g_num_actions_chained;
extern int g_num_methods_applied;

#endif
