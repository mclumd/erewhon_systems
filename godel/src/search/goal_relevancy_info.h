#ifndef GOAL_RELEVANCY_INFO_H
#define GOAL_RELEVANCY_INFO_H

#include <vector>
#include <map>

#include "method.h"

class Operator;

class GoalRelevancyInfo {
    private:
        std::map<std::pair<int, int>, vector<Operator *> > relevant_ops_map;
        std::map<std::pair<int, int>, vector<Method *> > relevant_methods_map;

    public:
        GoalRelevancyInfo ();
        void generate_applicable_and_relevant_ops_and_methods (
                const goal_formula &g,
                vector<const Operator *> &applicable_ops,
                vector<const Method *> &applicable_methods,
                vector<const Operator *> &app_and_rel_ops,
                vector<const Method *> &app_and_rel_methods, 
                vector<const Operator *> &app_not_rel_ops);
        void dump(); 

    private:
        void generate_relevant_ops_and_methods (
                const goal_formula &g,
                vector<Operator *> &rel_ops,
                vector<Method *> &rel_methods);
};

#endif
