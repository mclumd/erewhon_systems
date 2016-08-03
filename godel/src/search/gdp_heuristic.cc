#include "gdp_heuristic.h"
#include "method.h"
#include "globals.h"
#include "operator.h"

#include <vector>

using namespace std;

GDPHeuristic::GDPHeuristic (const Options &opt) 
    : AdditiveHeuristic(opt) {
}

GDPHeuristic::~GDPHeuristic () {
}

void GDPHeuristic::initialize () {
    cout << "Initializing GDP heuristic..." << endl;
    AdditiveHeuristic::initialize();
    relaxed_plan.resize(g_operators.size(), false);
}

int GDPHeuristic::compute_heuristic (const State &state, const goal_formula &g) {
    // cout << "starting new planning graph" << endl;
    g_state_clean = true; // going to create a fresh planning graph
    for (int i = 0; i < preferred_operators.size (); i++)
        preferred_operators [i]->unmark (); 
    preferred_operators.clear ();
    reset_and_expand_planning_graph (state, g);

    for (int i = 0; i < g.size(); i++) {
        Proposition &prop = propositions[g[i].first][g[i].second];
        if (prop.cost == -1)
            return DEAD_END;
    }

    // if it comes here, means all goals are relaxed reachable - gen relaxed plan now
    for (int i = 0; i < g.size(); i++) {
        Proposition *goal = &propositions[g[i].first][g[i].second];
        mark_relaxed_plan (state, goal);
    }

    // cout << "relaxed plan is:" << endl;
    int h_ff = 0;
    for (int op_no = 0; op_no < relaxed_plan.size(); op_no++) {
        if (relaxed_plan[op_no]) {
            // cout << g_operators[op_no].get_name () << endl;
            relaxed_plan[op_no] = false; // Clean up for next computation.
            h_ff += get_adjusted_cost(g_operators[op_no]);
        }
    }

    // cout << endl;
    
    return h_ff;
}

int GDPHeuristic::compute_heuristic (const State &state, const Method &m) {
    // cout << "computing heuristic ... " << endl;
    const goal_formula &subgoal_set = m.get_subgoal_set(); 
    for (int i = 0; i < preferred_operators.size (); i++)
        preferred_operators [i]->unmark (); 
    preferred_operators.clear (); 
    if (!g_state_clean) {
        // cout << "starting new planning graph" << endl;
        g_state_clean = true; // going to create a fresh planning graph
        reset_and_expand_planning_graph (state, subgoal_set);
    }

    else {
        // cout << "continuing expanding old planning graph" << endl;
        expand_planning_graph (subgoal_set);
    }

    for (int i = 0; i < subgoal_set.size(); i++) {
        Proposition &prop = propositions[subgoal_set[i].first][subgoal_set[i].second];
        if (prop.cost == -1)
            return DEAD_END;
    }

    // if it comes here, means all goals are relaxed reachable - gen relaxed plan now
    for (int i = 0; i < subgoal_set.size(); i++) {
        Proposition *goal = &propositions[subgoal_set[i].first][subgoal_set[i].second];
        mark_relaxed_plan (state, goal);
    }

    // cout << "relaxed plan is:" << endl;
    int h_ff = 0;
    for (int op_no = 0; op_no < relaxed_plan.size(); op_no++) {
        if (relaxed_plan[op_no]) {
            // cout << g_operators[op_no].get_name () << endl;
            relaxed_plan[op_no] = false; // Clean up for next computation.
            h_ff += get_adjusted_cost(g_operators[op_no]);
        }
    }

    // cout << endl;
    
    return h_ff;
  
    /*
    int method_cost = 0;

    for (int i = 0; i < subgoal_set.size(); i++) {
        int prop_cost = propositions[subgoal_set[i].first][subgoal_set[i].second].cost;    
        if (prop_cost == -1)
            return DEAD_END;
        increase_cost (method_cost, prop_cost);
    }

    return method_cost; 
    */
}

void GDPHeuristic::mark_relaxed_plan (const State &state, Proposition *goal) {
    if (!goal->marked) { // Only consider each subgoal once.
        goal->marked = true;
        UnaryOperator *unary_op = goal->reached_by;
        if (unary_op) { // We have not yet chained back to a start node.
            for (int i = 0; i < unary_op->precondition.size(); i++)
                mark_relaxed_plan(state, unary_op->precondition[i]);
            int operator_no = unary_op->operator_no;
            if (operator_no != -1) {
                // This is not an axiom.
                relaxed_plan[operator_no] = true;
                
                if (unary_op->cost == unary_op->base_cost) {
                    // This test is implied by the next but cheaper,
                    // so we perform it to save work.
                    // If we had no 0-cost operators and axioms to worry
                    // about, it would also imply applicability.
                    const Operator *op = &g_operators[operator_no];
                    if (op->is_applicable(state))
                        set_preferred(op);
                }

            }
        }
    }
}

void GDPHeuristic::reset_and_expand_planning_graph (const State &state, const goal_formula &g) {
    setup_exploration_queue();
    setup_exploration_queue_state(state);
    
    relaxed_exploration (g);
}

void GDPHeuristic::expand_planning_graph (const goal_formula &g) {
    int num_unsolved_goals = setup_goal_propositions (g);
    if (num_unsolved_goals == 0)
        return;
    else relaxed_exploration (g);

}

void GDPHeuristic::relaxed_exploration (const goal_formula &g) {
    int num_unsolved_goals = setup_goal_propositions (g);
    while (!queue.empty()) {
        pair<int, Proposition *> top_pair = queue.pop();
        int distance = top_pair.first;
        Proposition *prop = top_pair.second;
        int prop_cost = prop->cost;
        assert(prop_cost >= 0);
        assert(prop_cost <= distance);
        if (prop_cost < distance)
            continue;
        if (prop->is_goal && --num_unsolved_goals == 0)
            return;
        const vector<UnaryOperator *> &triggered_operators =
            prop->precondition_of;
        for (int i = 0; i < triggered_operators.size(); i++) {
            UnaryOperator *unary_op = triggered_operators[i];
            increase_cost(unary_op->cost, prop_cost);
            unary_op->unsatisfied_preconditions--;
            assert(unary_op->unsatisfied_preconditions >= 0);
            if (unary_op->unsatisfied_preconditions == 0)
                enqueue_if_necessary(unary_op->effect,
                                     unary_op->cost, unary_op);
        }
    }
}

void GDPHeuristic::setup_exploration_queue() {
    queue.clear();

    for (int var = 0; var < propositions.size(); var++) {
        for (int value = 0; value < propositions[var].size(); value++) {
            Proposition &prop = propositions[var][value];
            prop.cost = -1;
            prop.marked = false;
            // prop.is_goal = false;
        }
    }

    // Deal with operators and axioms without preconditions.
    for (int i = 0; i < unary_operators.size(); i++) {
        UnaryOperator &op = unary_operators[i];
        op.unsatisfied_preconditions = op.precondition.size();
        op.cost = op.base_cost; // will be increased by precondition costs

        if (op.unsatisfied_preconditions == 0)
            enqueue_if_necessary(op.effect, op.base_cost, &op);
    }
}


int GDPHeuristic::setup_goal_propositions (const goal_formula &g) {
    int unachieved_goals = 0;
    for (int var = 0; var < propositions.size(); var++) {
        for (int value = 0; value < propositions[var].size(); value++) {
            Proposition &prop = propositions[var][value];
            prop.is_goal = false;
            prop.marked = false;
        }
    }

    for (int i = 0; i < g.size(); i++) {
        Proposition &prop = propositions[g[i].first][g[i].second];
        if (prop.cost == -1) {
            prop.is_goal = true;
            unachieved_goals++;
        }
    }

    return unachieved_goals;
}

