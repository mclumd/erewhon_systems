#ifndef RC_MIXINS_H
#define RC_MIXINS_H

#include <string>

namespace raccoon {
  
  using namespace std;

  namespace mixins {
    
    class has_name {
    public:
      has_name(string nm) : my_name(nm) {};
      
      string get_name() { return my_name; };
      void   set_name(string nm) { my_name=nm; };
      
      virtual string class_name()=0;
      
    protected:
      string my_name;
      
    };
    
  };
  
};

#endif
