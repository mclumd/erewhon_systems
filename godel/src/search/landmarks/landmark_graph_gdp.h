#ifndef LANDMARKS_LANDMARK_GRAPH_GDP_H
#define LANDMARKS_LANDMARK_GRAPH_GDP_H

#include <vector>
#include <set>
#include <map>
#include <ext/hash_map>
#include <list>
#include <ext/hash_set>
#include <cassert>

#include "../operator.h"
#include "exploration_gdp.h"
#include "landmark_types.h"
#include "../option_parser.h"
#include "landmark_graph.h"

class LandmarkGraphGDP {
public:
    static void add_options_to_parser(OptionParser &parser);

    // ------------------------------------------------------------------------------
    // methods needed only by non-landmarkgraph-factories
    inline int cost_of_landmarks() const {return landmarks_cost; }
    void count_costs();
    LandmarkNode *get_lm_for_index(int);
    int get_needed_cost() const {return needed_cost; }
    int get_reached_cost() const {return reached_cost; }
    LandmarkNode *get_landmark(const pair<int, int> &prop) const;

    // ------------------------------------------------------------------------------
    // methods needed by both landmarkgraph-factories and non-landmarkgraph-factories
    inline const set<LandmarkNode *> &get_nodes() const {
        return nodes;
    }
    inline const Operator &get_operator_for_lookup_index(int op_no) const {
        const Operator &op = (op_no < g_operators.size()) ?
                             g_operators[op_no] : g_axioms[op_no - g_operators.size()];
        return op;
    }
    inline int number_of_landmarks() const {
        assert(landmarks_count == nodes.size());
        return landmarks_count;
    }
    ExplorationGDP *get_exploration() const {return exploration; }
    bool is_using_reasonable_orderings() const {return reasonable_orders; }

    // ------------------------------------------------------------------------------
    // methods needed only by landmarkgraph-factories
    LandmarkGraphGDP(const Options &opts);
    virtual ~LandmarkGraphGDP() {}

    inline LandmarkNode &get_simple_lm_node(const pair<int, int> &a) const {
        assert(simple_landmark_exists(a));
        return *(simple_lms_to_nodes.find(a)->second);
    }
    inline LandmarkNode &get_disj_lm_node(const pair<int, int> &a) const {
        // Note: this only works because every proposition appears in only one disj. LM
        assert(!simple_landmark_exists(a));
        assert(disj_lms_to_nodes.find(a) != disj_lms_to_nodes.end());
        return *(disj_lms_to_nodes.find(a)->second);
    }
    inline const std::vector<int> &get_operators_including_eff(const pair<int, int> &eff) const {
        return operators_eff_lookup[eff.first][eff.second];
    }

    bool use_orders() const {return !no_orders; }  // only needed by HMLandmark
    bool use_only_causal_landmarks() const {return only_causal_landmarks; }
    bool use_disjunctive_landmarks() const {return disjunctive_landmarks; }
    bool use_conjunctive_landmarks() const {return conjunctive_landmarks; }

    int number_of_disj_landmarks() const {
        return landmarks_count - (simple_lms_to_nodes.size() + conj_lms);
    }
    int number_of_conj_landmarks() const {
        return conj_lms;
    }
    int number_of_edges() const;

    // HACK! (Temporary accessor needed for LandmarkFactorySasp.)
    OperatorCost get_lm_cost_type() const {
        return lm_cost_type;
    }

    bool simple_landmark_exists(const pair<int, int> &lm) const; // not needed by HMLandmark
    bool disj_landmark_exists(const set<pair<int, int> > &lm) const; // not needed by HMLandmark
    bool landmark_exists(const pair<int, int> &lm) const; // not needed by HMLandmark
    bool exact_same_disj_landmark_exists(const set<pair<int, int> > &lm) const;

    LandmarkNode &landmark_add_simple(const pair<int, int> &lm);
    LandmarkNode &landmark_add_disjunctive(const set<pair<int, int> > &lm);
    LandmarkNode &landmark_add_conjunctive(const set<pair<int, int> > &lm);
    void rm_landmark_node(LandmarkNode *node);
    LandmarkNode &make_disj_node_simple(std::pair<int, int> lm); // only needed by LandmarkFactorySasp
    void set_landmark_ids();
    void set_landmark_cost(int cost) {
        landmarks_cost = cost;
    }
    void dump_node(const LandmarkNode *node_p) const;
    void dump() const;
    void dump_landmarks () const;
private:
    void generate_operators_lookups();
    ExplorationGDP *exploration;
    int landmarks_count;
    int conj_lms;
    bool reasonable_orders;
    bool only_causal_landmarks;
    bool disjunctive_landmarks;
    bool conjunctive_landmarks;
    bool no_orders;
    OperatorCost lm_cost_type;
    int reached_cost;
    int needed_cost;
    int landmarks_cost;
    __gnu_cxx::hash_map<pair<int, int>, LandmarkNode *, hash_int_pair> simple_lms_to_nodes;
    __gnu_cxx::hash_map<pair<int, int>, LandmarkNode *, hash_int_pair> disj_lms_to_nodes;
    std::set<LandmarkNode *> nodes;
    std::vector<LandmarkNode *> ordered_nodes;
    std::vector<std::vector<std::vector<int> > > operators_eff_lookup;
};

void dump_landmark (LandmarkNode *lmn);

#endif
