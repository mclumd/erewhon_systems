#ifndef SUCCESSOR_GENERATOR_H
#define SUCCESSOR_GENERATOR_H

#include <list>
#include <vector>
#include <fstream>
#include <map>
using namespace std;

class GeneratorBase;
class Operator;
class Variable;
class Method;

class SuccessorGenerator {
    GeneratorBase *root;

    typedef vector<pair<Variable *, int> > Condition;
    GeneratorBase *construct_recursive(int switchVarNo, list<int> &ops, list<int> &methods);
    SuccessorGenerator(const SuccessorGenerator &copy);

    vector<Condition> conditions;
    vector<Condition::const_iterator> next_condition_by_op;

    // augmenting the successor_generator with methods
    vector<Condition> method_conditions;
    vector<Condition::const_iterator> next_condition_by_method;


    vector<Variable *> varOrder;

    // private copy constructor to forbid copying;
    // typical idiom for classes with non-trivial destructors
public:
    SuccessorGenerator();
    SuccessorGenerator(const vector<Variable *> &variables,
                       const vector<Operator> &operators, 
                       const vector<Method> &methods);
    ~SuccessorGenerator();
    void dump() const;
    void generate_cpp_input(ofstream &outfile) const;
};

#endif
