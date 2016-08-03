#ifndef LIFTED_METHOD_H
#define LIFTED_METHOD_H

/* This class defines a Lifted version of an HGN method */

#include <string>
#include <vector>
#include <iostream>
#include <map>

using namespace std;

struct Literal {
    bool negation;
    string pred;
    vector<string> args;

    Literal (string raw_input);
    void dump (string indent); 
    string to_str () const;
    string to_str (map<string, string> &groundings) const; 
};

typedef vector<Literal> Conjunction;

class LiftedMethod {
    string name;
    vector<string> args;
    Conjunction goal;
    Conjunction precondition;
    vector<Conjunction> subgoals;

    public:
    LiftedMethod (istream &in);
    const string &get_name () const {return name;}
    const vector<string> &get_args () const {return args;} 
    const Conjunction &get_goal () const {return goal;}
    const Conjunction &get_pre () const {return precondition;}
    const vector<Conjunction> &get_subgoals () const {return subgoals;}
    void dump ();
};

#endif
