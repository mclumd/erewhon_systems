#ifndef GDP_HEURISTIC_H
#define GDP_HEURISTIC_H

#include "additive_heuristic.h"
#include "method.h"

class State;

class GDPHeuristic : public AdditiveHeuristic {
    // Relaxed plans are represented as a set of operators implemented
    // as a bit vector.
    typedef std::vector<bool> RelaxedPlan;
    RelaxedPlan relaxed_plan;
    void mark_relaxed_plan(
        const State &state, Proposition *g);
    

protected:
    void reset_and_expand_planning_graph (const State &m, const goal_formula &g);
    void expand_planning_graph (const goal_formula &g);
    void setup_exploration_queue ();
    int setup_goal_propositions (const goal_formula &g); 
    void relaxed_exploration (const goal_formula &g); 
public:
    virtual void initialize();
    virtual int compute_heuristic(const State &state, const Method &m);
    virtual int compute_heuristic(const State &state, const goal_formula &g);
    GDPHeuristic(const Options &opt);
    ~GDPHeuristic();
};

#endif
