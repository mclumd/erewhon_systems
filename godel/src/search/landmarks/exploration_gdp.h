#ifndef LANDMARKS_EXPLORATION_GDP_H
#define LANDMARKS_EXPLORATION_GDP_H

#include "../heuristic.h"
#include "../globals.h"
#include "../priority_queue.h"
#include "../method.h"
#include "landmark_types.h"
#include "exploration.h"

#include <vector>
#include <ext/hash_set>
#include <ext/hash_map>
#include <cassert>

class Operator;
class State;

class ExProposition;
class ExUnaryOperator;

class ExplorationGDP : public Heuristic {
    static const int MAX_COST_VALUE = 100000000; // See additive_heuristic.h.

    typedef __gnu_cxx::hash_set<const Operator *, ex_hash_operator_ptr> RelaxedPlan;
    RelaxedPlan relaxed_plan;
    std::vector<ExUnaryOperator> unary_operators;
    std::vector<std::vector<ExProposition> > propositions;
    std::vector<ExProposition *> goal_propositions;
    std::vector<ExProposition *> termination_propositions;

    AdaptiveQueue<ExProposition *> prop_queue;
    bool did_write_overflow_warning;

    bool heuristic_recomputation_needed;

    void build_unary_operators(const Operator &op);
    void simplify();

    void setup_exploration_queue(const State &state,
                                 const std::vector<std::pair<int, int> > &excluded_props,
                                 const __gnu_cxx::hash_set<const Operator *,
                                                           ex_hash_operator_ptr> &excluded_ops,
                                 bool use_h_max);
    inline void setup_exploration_queue(const State &state, bool h_max) {
        std::vector<std::pair<int, int> > excluded_props;
        __gnu_cxx::hash_set<const Operator *, ex_hash_operator_ptr> excluded_ops;
        setup_exploration_queue(state, excluded_props, excluded_ops, h_max);
    }
    void relaxed_exploration(bool use_h_max, bool level_out);
    void prepare_heuristic_computation(const State &state, bool h_max);
    void collect_relaxed_plan(ExProposition *goal, RelaxedPlan &relaxed_plan, const State &state);

    int compute_hsp_add_heuristic();
    int compute_hsp_max_heuristic();
    int compute_ff_heuristic(const State &state);

    void collect_ha(ExProposition *goal, RelaxedPlan &relaxed_plan, const State &state);

    void enqueue_if_necessary(ExProposition *prop, int cost, int depth, ExUnaryOperator *op,
                              bool use_h_max);
    void increase_cost(int &cost, int amount);
    void write_overflow_warning();
protected:
    virtual int compute_heuristic(const State &state);
public:
    int get_lower_bound(const State &state);
    void set_additional_goals(const std::vector<std::pair<int, int> > &goals);
    void set_recompute_heuristic() {heuristic_recomputation_needed = true; }
    void compute_reachability_with_excludes(std::vector<std::vector<int> > &lvl_var,
                                            std::vector<__gnu_cxx::hash_map<std::pair<int, int>, int,
                                                                            hash_int_pair> > &lvl_op,
                                            bool level_out,
                                            const std::vector<std::pair<int, int> > &excluded_props,
                                            const __gnu_cxx::hash_set<const Operator *,
                                                                      ex_hash_operator_ptr> &excluded_ops,
                                            bool compute_lvl_ops);
    std::vector<const Operator *> exported_ops; // only needed for landmarks count heuristic ha

    // Returns true iff disj_goal is relaxed reachable. As a side effect, marks preferred operators
    // via "exported_ops". (This is the real reason why you might want to call this.)
    bool plan_for_disj(std::vector<std::pair<int, int> > &disj_goal, const State &state);
    void cleanup (); 
    void reset_goals (const goal_formula &gf); 

    ExplorationGDP(const Options &opts);
    ~ExplorationGDP();
};

#endif
