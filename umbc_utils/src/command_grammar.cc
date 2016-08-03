#include "command_grammar.h"
#include "text_utils.h"
#include "token_machine.h"

#include <algorithm>

using namespace umbc;

command_grammar::~command_grammar() { }

// NOTE:
//
// it's unclear to me whether or not [] and {} will
// cause problems later on downstream in grammar generation.
// particularly, vis-a-vis the <> insertion part of the grammar dump.
// if it happens to, then the de_markup stuff will have to be fleshed 
// out and inserted into the process...

string de_markup_rhs(string rhs) {
  return textFunctions::trimBrackets(rhs);
}

// okay, end of de_markup business

void command_grammar::add_production(string left, string right) {
  if (productions.find(left) == productions.end()) {
    productions[left]=new list<string>();
  }
  list<string>* rhs = productions[left];
  if (find(rhs->begin(),rhs->end(),right) == rhs->end()) {
    rhs->push_back(right);
  }
}

bool command_grammar::is_terminal(string literal) {
  return (productions.find(literal) == productions.end());
}

string command_grammar::to_string() {
  string rv="";
  for(prod_type::const_iterator it = productions.begin(); 
      it != productions.end(); 
      ++it) {
    string cl = "<"+it->first+"> ~> ";
    int i=0;
    for(list<string>::const_iterator sit = it->second->begin(); 
	sit != it->second->end(); 
	++sit) {
      cl += production_string(*sit);
      if (i+1 < (int)it->second->size())
	cl+= "| ";
      i++;
    }
    rv+=cl+"\n";
  }
  return rv;
}

string command_grammar::production_string(string prhs) {
  tokenMachine tm(prhs);
  string op="";
  while(tm.moreTokens()) {
    string tt = tm.nextToken();
    if (is_terminal(tt))
      op+=tt+" ";
    else 
      op+="<"+tt+"> ";
  }
  return op;
}
