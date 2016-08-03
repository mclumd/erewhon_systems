#ifndef MCU_COMMAND_GRAMMAR_H
#define MCU_COMMAND_GRAMMAR_H

#include <string>
#include <list>
#include <map>

using namespace std;

namespace umbc {

  typedef map<string,list<string>*> prod_type;
  
  class command_grammar {
  public:
    command_grammar() {};
    ~command_grammar();
    void   add_production(string left, string right);
    string to_string();
    
  private:
    prod_type productions;
    bool is_terminal(string literal);
    string production_string(string prhs);
    
  };
  
  class publishes_grammar {
  public:
    publishes_grammar() {};
    virtual ~publishes_grammar() {};
    virtual string grammar_commname()=0;
    virtual bool publish_grammar(command_grammar& cg)=0;
    
  };
  
};

#endif
