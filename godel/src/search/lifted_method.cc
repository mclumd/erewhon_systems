#include "lifted_method.h"
#include "globals.h"

#include <vector>
#include <string>
#include <iostream>
#include <sstream>

Literal::Literal (string raw_input) {
    stringstream ss (raw_input);
    string word;

    getline (ss, word, ' ');
    if (word != "not") {
        pred = word;
        negation = false;
    }

    else {
        negation = true;
        ss >> ws;
        getline (ss, word, ' ');
        pred = word;
    }

    // now you've sorted out negation and predicate
    // time to take args in
    ss >> ws;
    while (getline (ss, word, ' ')) {
        args.push_back (word);
        ss >> ws;
    }
}

void Literal::dump (string indent) {
    if (negation)
        cout << indent << "not ";
    else cout << indent; 
    cout << pred << " ";
    for (int i = 0; i < args.size(); i++) 
        cout << args[i] << " ";
    cout << endl;
}

string Literal::to_str () const {
    stringstream result_s;
    if (negation)
        result_s << "not ";
    result_s << pred;
    for (int i = 0; i < args.size(); i++)
        result_s << " " << args[i];

    return result_s.str(); 
}

string Literal::to_str (map<string, string> &groundings) const {
    stringstream result_s;
    if (negation)
        result_s << "not ";
    result_s << pred;
    for (int i = 0; i < args.size(); i++)
        result_s << " " << groundings.find(args[i])->second;

    return result_s.str();    
}


LiftedMethod::LiftedMethod (istream &in) {
    cout << "entered LiftedMethod constructor" << endl; 
    check_magic (in, "begin_lifted_method");

    in >> ws;
    getline (in, name);
    cout << "name is " << name << endl;

    int num_args;
    in >> num_args;
    in >> ws;
    cout << "num_args is " << num_args << endl;

    args.reserve (num_args);
    for (int i = 0; i < num_args; i++) {
        string arg;
        getline (in, arg);
        args.push_back (arg);
        cout << "arg " << i << " is " << arg << endl;
        in >> ws;
    }

    // time to read in the goal
    int num_goals;
    in >> num_goals;
    in >> ws;

    for (int i = 0; i < num_goals; i++) {
        string line;
        getline (in, line);
        goal.push_back (Literal(line));
    }

    // time to read in the preconditions
    int num_pre;
    in >> num_pre;
    in >> ws;

    for (int i = 0; i < num_pre; i++) {
        string line;
        getline (in, line);
        precondition.push_back (Literal(line));
    }

    // time to read in the subgoals
    int num_subgoals;
    in >> num_subgoals;
    in >> ws;

    for (int i = 0; i < num_subgoals; i++) {
        int num_terms_in_subgoal;
        in >> num_terms_in_subgoal;
        in >> ws;
        Conjunction sg;
        subgoals.push_back (sg);
        Conjunction &sg_ref = subgoals[i];
        for (int j = 0; j < num_terms_in_subgoal; j++) {
            string line;
            getline (in, line);
            sg_ref.push_back (Literal(line));
        }
    }

    cout << "reached end of LiftedMethod constructor" << endl;

    check_magic (in, "end_lifted_method");
}

void LiftedMethod::dump () {
    cout << name << " ("; 

    for (int i = 0; i < args.size(); i++) {
        cout << args[i] << " ";
    }
    cout << ")" << endl;

    cout << "goal:" << endl;
    for (int i = 0; i < goal.size(); i++) {
        cout << " -- " << i << ": "; 
        goal[i].dump (""); 
    }

    cout << "precondition:" << endl;
    for (int i = 0; i < precondition.size(); i++) {
        cout << " -- " << i << ": "; 
        precondition[i].dump (""); 
    }

    cout << "subgoals:" << endl;
    for (int i = 0; i < subgoals.size(); i++) {
        cout << "  subgoal " << i << endl;
        Conjunction &s = subgoals[i];
        for (int j = 0; j < s.size(); j++) {
            cout << " -- " << j << ": "; 
            s[j].dump ("  "); 
        }
    }
}
