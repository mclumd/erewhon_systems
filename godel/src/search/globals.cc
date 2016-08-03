#include "globals.h"
#include <cstdlib>
#include <iostream>
#include <fstream>
#include <limits>
#include <set>
#include <string>
#include <vector>
#include <sstream>
#include <algorithm>
using namespace std;

#include <ext/hash_map>
using namespace __gnu_cxx;

#include "axioms.h"
#include "causal_graph.h"
#include "domain_transition_graph.h"
#include "heuristic.h"
#include "operator.h"
#include "method.h"
#include "rng.h"
#include "state.h"
#include "successor_generator.h"
#include "timer.h"
#include "plstate.h"
#include "lifted_method.h"

static const int PRE_FILE_VERSION = 3;
time_t start_timer, end_timer;


// TODO: This needs a proper type and should be moved to a separate
//       mutexes.cc file or similar, accessed via something called
//       g_mutexes. (Right now, the interface is via global function
//       are_mutex, which is at least better than exposing the data
//       structure globally.)

static vector<vector<set<pair<int, int> > > > g_inconsistent_facts;

bool test_goal(const State &state) {
    for (int i = 0; i < g_goal.size(); i++) {
        if (state[g_goal[i].first] != g_goal[i].second) {
            return false;
        }
    }
    return true;
}

int calculate_plan_cost(const vector<const Operator *> &plan) {
    // TODO: Refactor: this is only used by save_plan (see below)
    //       and the SearchEngine classes and hence should maybe
    //       be moved into the SearchEngine (along with save_plan).
    int plan_cost = 0;
    for (int i = 0; i < plan.size(); i++) {
        plan_cost += plan[i]->get_cost();
    }
    return plan_cost;
}

void save_plan(const vector<const Operator *> &plan, int iter) {
    // TODO: Refactor: this is only used by the SearchEngine classes
    //       and hence should maybe be moved into the SearchEngine.
    ofstream outfile;
    if (iter == 0) {
        outfile.open(g_plan_filename.c_str(), ios::out);
    } else {
        ostringstream out;
        out << g_plan_filename << "." << iter;
        outfile.open(out.str().c_str(), ios::out);
    }
    for (int i = 0; i < plan.size(); i++) {
        cout << plan[i]->get_name() << " (" << plan[i]->get_cost() << ")" << endl;
        outfile << "(" << plan[i]->get_name() << ")" << endl;
    }
    outfile.close();
    int plan_cost = calculate_plan_cost(plan);
    ofstream statusfile;
    statusfile.open("plan_numbers_and_cost", ios::out | ios::app);
    statusfile << iter << " " << plan_cost << endl;
    statusfile.close();
    cout << "Plan length: " << plan.size() << " step(s)." << endl;
    cout << "Plan cost: " << plan_cost << endl;
}

void save_gdp_plan (const vector<const Option *> &p) {
    // TODO: Refactor: this is only used by the SearchEngine classes
    //       and hence should maybe be moved into the SearchEngine.
    ofstream outfile;
    outfile.open(g_plan_filename.c_str(), ios::out);
    if (!g_gdp_timelimit_reached) {
        State init_state_test (*g_initial_state);
        int plan_length = 0;
        outfile << "\nPlan:" << endl;
        for (int i = 0; i < p.size(); i++) {
            if (p[i]->is_operator()) {
                plan_length++;
                outfile << "[" << plan_length << "] " << ((Operator *)p[i])->get_name () << endl;
                init_state_test.progress_state (*((Operator *)p[i]));
            }
            // else  
            //    outfile << "-- " << ((Method *)p[i])->get_name () << endl;
        }

        if (test_goal (init_state_test)) {
            outfile << "SUCCESS : final state satisfies goal!" << endl;
            outfile << "Plan length: " << plan_length << endl;
        }
        else
            outfile << "FAILURE : final state does not satisfy goal!" << endl;

        outfile << "GDP time: " << g_gdp_timer << endl;
        outfile << "GDP+LISP time: " << g_lisp_timer + g_gdp_timer() << "s" << endl;
        outfile << "Wall time: " << difftime (end_timer, start_timer) << "s" << endl;
        outfile << "Number of nodes reached:" << g_total_gdp_nodes << endl;
        outfile << "Number of nodes expanded: " << g_gdp_nodes_expanded << endl;
        outfile << "Number of methods applied: " << g_num_methods_applied << endl;
        outfile << "Number of actions chained: " << g_num_actions_chained << endl;
    }
    
    else {
        outfile << "FAILURE : time limit of 30 mins reached!" << endl;
    }
 
    outfile.close();
}


bool peek_magic(istream &in, string magic) {
    string word;
    in >> word;
    bool result = (word == magic);
    for (int i = word.size() - 1; i >= 0; i--)
        in.putback(word[i]);
    return result;
}

void check_magic(istream &in, string magic) {
    string word;
    in >> word;
    if (word != magic) {
        cout << "Failed to match magic word '" << magic << "'." << endl;
        cout << "Got '" << word << "'." << endl;
        if (magic == "begin_version") {
            cerr << "Possible cause: you are running the planner "
                 << "on a preprocessor file from " << endl
                 << "an older version." << endl;
        }
        exit(1);
    }
}

void read_and_verify_version(istream &in) {
    int version;
    check_magic(in, "begin_version");
    in >> version;
    check_magic(in, "end_version");
    if (version != PRE_FILE_VERSION) {
        cerr << "Expected preprocessor file version " << PRE_FILE_VERSION
             << ", got " << version << "." << endl;
        cerr << "Exiting." << endl;
        exit(1);
    }
}

void read_metric(istream &in) {
    check_magic(in, "begin_metric");
    in >> g_use_metric;
    check_magic(in, "end_metric");
}

void insert_into_literal_map (string fact, int varNo, int val) {
    // cout << "fact is " << fact << endl;
    if (fact != "<none of those>") {
        const pair<string, vector<string> > &parsed_fact = parse_fact_name (fact);
        stringstream ss;
        ss << parsed_fact.first;
        for (int i = 0; i < (parsed_fact.second).size(); i++)
            ss << " " << (parsed_fact.second)[i];
        // cout << "str = " << ss.str() << ", varNo = " << varNo << " and val = " << val << endl;
        g_literals_to_num_map.insert (make_pair(ss.str(), make_pair(varNo, val))); 
    }
}

void read_variables(istream &in) {
    int count;
    in >> count;
    for (int i = 0; i < count; i++) {
        check_magic(in, "begin_variable");
        string name;
        in >> name;
        cout << "variable name: " << name << endl;
        g_variable_name.push_back(name);
        int layer;
        in >> layer;
        g_axiom_layers.push_back(layer);
        int range;
        in >> range;
        g_variable_domain.push_back(range);
        if (range > numeric_limits<state_var_t>::max()) {
            cerr << "This should not have happened!" << endl;
            cerr << "Are you using the downward script, or are you using "
                 << "downward-1 directly?" << endl;
            exit(1);
        }

        in >> ws;
        vector<string> fact_names(range);
        for (size_t j = 0; j < fact_names.size(); j++) {
            getline(in, fact_names[j]);
            // the following line populate g_literals_to_num_map
            insert_into_literal_map (fact_names[j], i, j); 
        }
        g_fact_names.push_back(fact_names);
        /*
        cout << "fact names for variable " << i << " are as follows:" << endl;
        for (int var_i = 0; var_i < range; var_i++)
            cout << " -- " << fact_names[var_i] << endl;
        cout << endl;
        */
        check_magic(in, "end_variable");
    }
}

void read_mutexes(istream &in) {
    g_inconsistent_facts.resize(g_variable_domain.size());
    for (size_t i = 0; i < g_variable_domain.size(); ++i)
        g_inconsistent_facts[i].resize(g_variable_domain[i]);

    int num_mutex_groups;
    in >> num_mutex_groups;

    /* NOTE: Mutex groups can overlap, in which case the same mutex
       should not be represented multiple times. The current
       representation takes care of that automatically by using sets.
       If we ever change this representation, this is something to be
       aware of. */

    for (size_t i = 0; i < num_mutex_groups; ++i) {
        check_magic(in, "begin_mutex_group");
        int num_facts;
        in >> num_facts;
        vector<pair<int, int> > invariant_group;
        invariant_group.reserve(num_facts);
        for (size_t j = 0; j < num_facts; ++j) {
            int var, val;
            in >> var >> val;
            invariant_group.push_back(make_pair(var, val));
        }
        check_magic(in, "end_mutex_group");
        for (size_t j = 0; j < invariant_group.size(); ++j) {
            const pair<int, int> &fact1 = invariant_group[j];
            int var1 = fact1.first, val1 = fact1.second;
            for (size_t k = 0; k < invariant_group.size(); ++k) {
                const pair<int, int> &fact2 = invariant_group[k];
                int var2 = fact2.first;
                if (var1 != var2) {
                    /* The "different variable" test makes sure we
                       don't mark a fact as mutex with itself
                       (important for correctness) and don't include
                       redundant mutexes (important to conserve
                       memory). Note that the preprocessor removes
                       mutex groups that contain *only* redundant
                       mutexes, but it can of course generate mutex
                       groups which lead to *some* redundant mutexes,
                       where some but not all facts talk about the
                       same variable. */
                    g_inconsistent_facts[var1][val1].insert(fact2);
                }
            }
        }
    }
}

void read_goal(istream &in) {
    check_magic(in, "begin_goal");
    int count;
    in >> count;
    for (int i = 0; i < count; i++) {
        int var, val;
        in >> var >> val;
        g_goal.push_back(make_pair(var, val));
    }
    check_magic(in, "end_goal");
}

void dump_goal() {
    cout << "Goal Conditions:" << endl;
    for (int i = 0; i < g_goal.size(); i++)
        cout << "  " << g_variable_name[g_goal[i].first] << ": "
             << g_goal[i].second << endl;
}

void read_operators(istream &in) {
    int count;
    in >> count;
    for (int i = 0; i < count; i++)
        g_operators.push_back(Operator(in, false));
}

void read_axioms(istream &in) {
    int count;
    in >> count;
    for (int i = 0; i < count; i++)
        g_axioms.push_back(Operator(in, true));

    g_axiom_evaluator = new AxiomEvaluator;
    g_axiom_evaluator->evaluate(*g_initial_state);
}

void read_methods(istream &in) {
    int count;
    in >> count;
    for (int i = 0; i < count; i++)
        g_methods.push_back(Method(in));
    cout << "read in " << count << " methods" << endl; 
}

void read_lifted_methods(istream &in) {
    int count;
    in >> count;
    for (int i = 0; i < count; i++) {
        LiftedMethod lm (in);
        g_lifted_methods.insert (make_pair(lm.get_name (), lm));
        // g_lifted_methods.push_back(LiftedMethod(in));
        const Conjunction &lm_goal = lm.get_goal ();
        for (auto g_it = lm_goal.begin(); g_it != lm_goal.end(); g_it++)
            g_predicates_methods_achieve.insert (g_it->pred);
    }
    cout << "read in " << count << " lifted_methods" << endl;
    for (auto it = g_predicates_methods_achieve.begin(); it != g_predicates_methods_achieve.end(); it++)
        cout << *it << endl;
}

template <class T>
bool obj_addr_cmp (const T &op1, const T &op2) {
    return (&op1 < &op2);
}

void read_everything(istream &in) {
    cout << "entered read_everything ..." << endl;
    read_and_verify_version(in);
    read_metric(in);
    read_variables(in);
    cout << "read in variables" << endl;
    read_mutexes(in);
    g_initial_state = new State(in);
    read_goal(in);
    read_operators(in);
    
    /*
    cout << "\noperators before sorting:" << endl;
    for (int i = 0; i < g_operators.size(); i++) {
        cout << &g_operators[i] << endl;
    }
    cout << "printing done" << endl;
    // sort(g_operators.begin(), g_operators.end(), obj_addr_cmp<Operator>);
    cout << "\noperators after sorting:" << endl;
    for (int i = 0; i < g_operators.size(); i++) {
        cout << &g_operators[i] << endl;
    }
    */

    read_axioms(in);
    read_methods(in);
    
    /*
    cout << "\nmethods before sorting:" << endl;
    for (int i = 0; i < g_methods.size(); i++) {
        cout << &g_methods[i] << endl;
    }
    cout << "printing done" << endl;
    // sort(g_methods.begin(), g_methods.end(), obj_addr_cmp<Method>);
    cout << "\nmethods after sorting:" << endl;
    for (int i = 0; i < g_methods.size(); i++) {
        cout << &g_methods[i] << endl;
    }
    */
   
    
    

    check_magic(in, "begin_SG");
    g_successor_generator = read_successor_generator_with_methods(in);
    check_magic(in, "end_SG");
    //g_successor_generator->dump_with_methods();
    DomainTransitionGraph::read_all(in);
    g_causal_graph = new CausalGraph(in);
    g_plstate = new PLState (in);
    // cout << "PL State is as follows:" << endl;
    // g_plstate->dump ();

    read_lifted_methods (in);

    cout << "checking if methods were read in correctly ... " << endl;
    
    /*
    for (auto it = g_lifted_methods.begin(); it != g_lifted_methods.end(); it++) {
        cout << "LiftedMethod " << it->first << ":" << endl;
        (it->second).dump();
        cout << endl;
    }
    */

    in >> ws;
    getline (in, g_path_to_method_file);
    cout << "method file: " << g_path_to_method_file << endl;
}

void dump_everything() {
    cout << "Use metric? " << g_use_metric << endl;
    cout << "Min Action Cost: " << g_min_action_cost << endl;
    cout << "Max Action Cost: " << g_max_action_cost << endl;
    // TODO: Dump the actual fact names.
    cout << "Variables (" << g_variable_name.size() << "):" << endl;
    for (int i = 0; i < g_variable_name.size(); i++)
        cout << "  " << g_variable_name[i]
             << " (range " << g_variable_domain[i] << ")" << endl;
    cout << "Initial State:" << endl;
    g_initial_state->dump();
    dump_goal();
    /*
    cout << "Successor Generator:" << endl;
    g_successor_generator->dump();
    for(int i = 0; i < g_variable_domain.size(); i++)
      g_transition_graphs[i]->dump();
    */
}

void verify_no_axioms_no_cond_effects() {
    if (!g_axioms.empty()) {
        cerr << "Heuristic does not support axioms!" << endl << "Terminating."
             << endl;
        exit(1);
    }

    for (int i = 0; i < g_operators.size(); i++) {
        const vector<PrePost> &pre_post = g_operators[i].get_pre_post();
        for (int j = 0; j < pre_post.size(); j++) {
            const vector<Prevail> &cond = pre_post[j].cond;
            if (cond.empty())
                continue;
            // Accept conditions that are redundant, but nothing else.
            // In a better world, these would never be included in the
            // input in the first place.
            int var = pre_post[j].var;
            int pre = pre_post[j].pre;
            int post = pre_post[j].post;
            if (pre == -1 && cond.size() == 1 && cond[0].var == var
                && cond[0].prev != post && g_variable_domain[var] == 2)
                continue;

            cerr << "Heuristic does not support conditional effects "
                 << "(operator " << g_operators[i].get_name() << ")" << endl
                 << "Terminating." << endl;
            exit(1);
        }
    }
}

bool are_mutex(const pair<int, int> &a, const pair<int, int> &b) {
    if (a.first == b.first) // same variable: mutex iff different value
        return a.second != b.second;
    return bool(g_inconsistent_facts[a.first][a.second].count(b));
}


void write_lisp_goal (const vector<pair<int, int> > &goals, ofstream &out) {
    /*
    out << "(" << endl;
    for (int i = 0; i < goals.size(); i++) {
        const pair<int, int> &g = goals[i];
        string g_str = g_fact_names[g.first][g.second];
        if (g_str != "<none of these>") {
            const pair<string, vector<string> > parsed_goal = parse_fact_name (g_str);
            out << "(" << parsed_goal.first;
            for (int j = 0; j < (parsed_goal.second).size(); j++)
                out << " " << (parsed_goal.second)[j];
            out << ")" << endl;
        }
    }
    out << ")" << endl;
    */
    out << write_lisp_goal_to_str (goals);
}

string write_lisp_goal_to_str (const vector<pair<int, int> > &goals) {
    stringstream out;
    out << "(" << " ";
    for (int i = 0; i < goals.size(); i++) {
        const pair<int, int> &g = goals[i];
        string g_str = g_fact_names[g.first][g.second];
        if (g_str != "<none of these>") {
            const pair<string, vector<string> > parsed_goal = parse_fact_name (g_str);
            out << "(" << parsed_goal.first;
            for (int j = 0; j < (parsed_goal.second).size(); j++)
                out << " " << (parsed_goal.second)[j];
            out << ")" << " ";
        }
    }
    out << ")" << " ";

    return out.str ();
}


void write_lisp_problem (const vector<pair<int, int> > &goals, ofstream &out) {
    out << "(in-package :shop2)" << endl;
    out << "(defproblem blah logistics" << endl;
    g_plstate->output (out);
    write_lisp_goal (goals, out);
    out << ")" << endl;
}

/*vector<map<string, string> > get_bindings_for_literal (
        const Literal &l,
        const PLState &s,
        const map<string, int> &levels_of_vars, 
        vector<map<string, string> > all_bindings) {
    
}*/

const pair<string, vector<string> > parse_fact_name (string &fact_name) {
    stringstream ss (fact_name);
    string word, pred;
    vector<string> args;
    getline (ss, word, ' '); // discard 'Atom'
    getline (ss, pred, '('); // store predicate in pred
    // cout << " -- pred is " << pred << endl;
    while (getline (ss, word, ',')) {
        ss >> ws;
        stringstream arg_ss (word);
        string arg;
        getline (arg_ss, arg, ')'); // arg now contains the proper argument
        if (arg != "")
            args.push_back (arg);
    }

    /*
    for (int i = 0; i < args.size(); i++)
        cout << " -- arg" << i << " is " << args[i] << endl;
    */

    return make_pair(pred, args);
}

const Method *constr_method_instances_from_str_repr (string &m_str) {
    cout << "m_str: " << m_str << endl;
    stringstream ss (m_str);
    char ch = ss.peek ();
    if (ch == '(') {
        ss >> ch;
    }
    
    //if the string started with '(', that should have been removed by now
    string m_name;
    getline (ss, m_name, ' '); 
    cout << "method name is " << m_name << endl;
    cout << "number of lifted methods: " << g_lifted_methods.size () << endl;
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
    
    cout << "testing insertion into grounding map" << endl;
    for (auto it = m_grounding.begin(); it != m_grounding.end(); it++)
        cout << "  " << it->first << " -> " << it->second << endl;
    
    // you have the method object and the groundings, create Method instances
    // based on these two
    cout << "testing method creation start ..." << endl;
    Method *x = new Method(m, m_grounding);
    cout << "testing method creation end." << endl;

    return x;
}


bool g_use_metric;
int g_min_action_cost = numeric_limits<int>::max();
int g_max_action_cost = 0;
vector<string> g_variable_name;
vector<int> g_variable_domain;
vector<vector<string> > g_fact_names;
unordered_map<string, pair<int, int> > g_literals_to_num_map;
vector<int> g_axiom_layers;
vector<int> g_default_axiom_values;
set<string> g_predicates_methods_achieve;

State *g_initial_state;
State *g_current_state;
vector<pair<int, int> > g_goal;
const vector<pair<int, int> > *g_current_goal;
vector<Operator> g_operators;
vector<Operator> g_axioms;
vector<Method> g_methods;
map<string, LiftedMethod> g_lifted_methods;
AxiomEvaluator *g_axiom_evaluator;
SuccessorGenerator *g_successor_generator;
vector<DomainTransitionGraph *> g_transition_graphs;
CausalGraph *g_causal_graph;
PLState *g_plstate;
bool g_state_clean = false;
bool g_infer_subgoals = true;
string g_path_to_method_file;
Timer g_gdp_timer;
double g_lisp_timer = 0; 
int g_gdp_timelimit = 1800;
bool g_gdp_timelimit_reached = false; 

Timer g_timer;
string g_plan_filename = "gdp_result";
RandomNumberGenerator g_rng(2011); // Use an arbitrary default seed.

// gdp-related statistics
int g_total_gdp_nodes = 0;
int g_gdp_nodes_expanded = 0;
int g_num_actions_chained = 0;
int g_num_methods_applied = 0;

