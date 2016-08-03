#include "globals.h"
#include "operator.h"
#include "method.h"
#include "state.h"
#include "successor_generator.h"

#include <cstdlib>
#include <iostream>
#include <vector>
using namespace std;

class SuccessorGeneratorSwitch : public SuccessorGenerator {
    int switch_var;
    SuccessorGenerator *immediate_generator;
    vector<SuccessorGenerator *> generator_for_value;
    SuccessorGenerator *default_generator;
public:
    SuccessorGeneratorSwitch(istream &in, bool methods_present);
    virtual void generate_applicable_ops(const State &curr,
                                         vector<const Operator *> &ops); 

    virtual void generate_applicable_ops_and_methods(const State &curr,
                                                     vector<const Operator *> &ops,
                                                     vector<const Method *> &methods);
    virtual void _dump(string indent, bool methods_present);
};

class SuccessorGeneratorGenerate : public SuccessorGenerator {
    vector<const Operator *> op;
    vector<const Method *> m;
public:
    SuccessorGeneratorGenerate(istream &in, bool methods_present);
    virtual void generate_applicable_ops(const State &,
                                         vector<const Operator *> &ops); 
    virtual void generate_applicable_ops_and_methods(const State &,
                                         vector<const Operator *> &ops, 
                                         vector<const Method *> &methods);
    virtual void _dump(string indent, bool methods_present);
};

SuccessorGeneratorSwitch::SuccessorGeneratorSwitch(istream &in, bool methods_present){
    in >> switch_var;
    //cout << "switch var is var" << switch_var << endl;

    if (methods_present)
        immediate_generator = read_successor_generator_with_methods(in);
    else 
        immediate_generator = read_successor_generator(in);
    for (int i = 0; i < g_variable_domain[switch_var]; i++)
        if (methods_present)
            generator_for_value.push_back(read_successor_generator_with_methods(in));
        else 
            generator_for_value.push_back(read_successor_generator(in));
    if (methods_present)
        default_generator = read_successor_generator_with_methods(in);
    else 
        default_generator = read_successor_generator(in);
}

void SuccessorGeneratorSwitch::generate_applicable_ops_and_methods(
    const State &curr, vector<const Operator *> &ops, vector<const Method *> &methods) {
    immediate_generator->generate_applicable_ops_and_methods(curr, ops, methods);
    generator_for_value[curr[switch_var]]->generate_applicable_ops_and_methods(curr, ops, methods);
    default_generator->generate_applicable_ops_and_methods(curr, ops, methods);
}


void SuccessorGeneratorSwitch::generate_applicable_ops(const State &curr, 
    vector<const Operator *> &ops) {
    immediate_generator->generate_applicable_ops(curr, ops);
    generator_for_value[curr[switch_var]]->generate_applicable_ops(curr, ops);
    default_generator->generate_applicable_ops(curr, ops);
}


void SuccessorGeneratorSwitch::_dump(string indent, bool methods_present) {
    cout << indent << "switch on " << g_variable_name[switch_var] << endl;
    cout << indent << "immediately:" << endl;
    immediate_generator->_dump(indent + "  ", methods_present);
    for (int i = 0; i < g_variable_domain[switch_var]; i++) {
        cout << indent << "case " << i << ":" << endl;
        generator_for_value[i]->_dump(indent + "  ", methods_present);
    }
    cout << indent << "always:" << endl;
    default_generator->_dump(indent + "  ", methods_present);
}


SuccessorGeneratorGenerate::SuccessorGeneratorGenerate(istream &in, 
                                                       bool methods_present) {
    int count_op, count_m;
    in >> count_op;
    if (methods_present) {
        in >> count_m;
        // cout << "methods_present, count_op = " << count_op << ", count_m = " << count_m << endl;
    }
    for (int i = 0; i < count_op; i++) {
        int op_index;
        in >> op_index;
        op.push_back(&g_operators[op_index]);
    }

    if(methods_present) {
        for (int i = 0; i < count_m; i++) {
            int m_index;
            in >> m_index;
            m.push_back(&g_methods[m_index]);
        }
    }
}

void SuccessorGeneratorGenerate::generate_applicable_ops_and_methods(const State &,
                                                         vector<const Operator *> &ops,
                                                         vector<const Method *> &methods){
    ops.insert(ops.end(), op.begin(), op.end());
    methods.insert(methods.end(), m.begin(), m.end());
}

void SuccessorGeneratorGenerate::generate_applicable_ops(const State &,
                                                         vector<const Operator *> &ops){
    ops.insert(ops.end(), op.begin(), op.end());
}



void SuccessorGeneratorGenerate::_dump(string indent, bool methods_present) {
    cout << indent << "ops:" << op.size() << endl;
    for (int i = 0; i < op.size(); i++) {
        cout << indent;
        op[i]->dump();
    }
    if (methods_present) {
        cout << indent << "methods:" << m.size() << endl;
        for (int i = 0; i < m.size(); i++) {
            cout << indent;
            m[i]->dump();
        }
    }
}

SuccessorGenerator *read_successor_generator(istream &in) {
    string type;
    in >> type;
    if (type == "switch") {
        return new SuccessorGeneratorSwitch(in, false);
    } else if (type == "check") {
        return new SuccessorGeneratorGenerate(in, false);
    }
    cout << "Illegal successor generator statement!" << endl;
    cout << "Expected 'switch' or 'check', got '" << type << "'." << endl;
    exit(1);
}

SuccessorGenerator *read_successor_generator_with_methods(istream &in) {
    string type;
    in >> type;
    if (type == "switch") 
        return new SuccessorGeneratorSwitch(in, true);
    else if (type == "check")
        return new SuccessorGeneratorGenerate(in, true);
    cout << "Illegal successor generator statement!" << endl;
    cout << "Expected 'switch' or 'check', got '" << type << "'." << endl;
    exit(1);
}
