#ifndef SUCCESSOR_GENERATOR_H
#define SUCCESSOR_GENERATOR_H

#include <iostream>
#include <vector>

class Operator;
class State;
class Method;

using namespace std;

class SuccessorGenerator {
public:
    virtual ~SuccessorGenerator() {}
    virtual void generate_applicable_ops_and_methods(const State &,
                                                     vector<const Operator *> &ops, 
                                                     vector<const Method *> &methods) = 0;
    virtual void generate_applicable_ops(const State &curr,
                                         std::vector<const Operator *> &ops) = 0;

    void dump() {_dump("  ", false); }
    void dump_with_methods() {_dump("  ", true); }
    virtual void _dump(string indent, bool methods_present) = 0;
};

//class SuccessorGeneratorSwitch;
//class SuccessorGeneratorGenerate;

SuccessorGenerator *read_successor_generator(std::istream &in);
SuccessorGenerator *read_successor_generator_with_methods(std::istream &in);

#endif
