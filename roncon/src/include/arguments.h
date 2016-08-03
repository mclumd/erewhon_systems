#ifndef RC_ARGUMENTS_CLASS
#define RC_ARGUMENTS_CLASS

#include <stdio.h>
#include <map>
#include <string>
using namespace std;

namespace raccoon {

  class arguments {
  public:
    arguments() {};

    virtual int num_values()=0;
    
    virtual int arg_as_int_by_name(string name)=0;
    virtual int arg_as_int_by_index(int index)=0;
    
    virtual double arg_as_dbl_by_name(string name)=0;
    virtual double arg_as_dbl_by_index(int index)=0;
    
    virtual void set_arg_by_name(string name, int val)=0;
    virtual void set_arg_by_name(string name, double val)=0;
    virtual void set_arg_by_index(int index, int val)=0;
    virtual void set_arg_by_index(int index, double val)=0;
    virtual void set_arg_full(string name, int index, double val)=0;
    virtual void set_arg_full(string name, int index, int val)=0;

    virtual void set_arg_paramstring(string pstring)=0;

    virtual string describe()=0;
    
  };
  
  class assumed_dbl_arguments :public arguments {
  public:
    assumed_dbl_arguments() : arguments(),icount(0) {};
    assumed_dbl_arguments(double a1) : arguments(),icount(0)
      { set_arg_by_index(0,a1); };
    assumed_dbl_arguments(double a1, double a2) : arguments(),icount(0)
      { set_arg_by_index(0,a1); set_arg_by_index(1,a2); };

    virtual int num_values() {return icount;}
    
    virtual int arg_as_int_by_name(string name) { 
      if (byname.find(name) != byname.end()) return (int)byname[name]; 
      else return -99;
    };
    virtual int arg_as_int_by_index(int index) { 
      if (byindex.find(index) != byindex.end()) return (int)byindex[index]; 
      else return -99;
    };
    
    virtual double arg_as_dbl_by_name(string name) { 
      if (byname.find(name) != byname.end()) return byname[name]; 
      else return -99.99;
    };
    virtual double arg_as_dbl_by_index(int index) { 
      if (byindex.find(index) != byindex.end()) return byindex[index];
      else return -99.99;
    };
    
    virtual void set_arg_by_name(string name, int val)
      { byname[name]=val; byindex[next_open_index()]=val; };
    virtual void set_arg_by_name(string name, double val)
      { byname[name]=val; byindex[next_open_index()]=val; };

    virtual void set_arg_by_index(int index, int val)
      { byname[namefor(index)]=val; byindex[index]=val; };
    virtual void set_arg_by_index(int index, double val)
      { byname[namefor(index)]=val; byindex[index]=val; };

    virtual void set_arg_full(string name, int index, int val)
      { byname[name]=val; byindex[index]=val; };
    virtual void set_arg_full(string name, int index, double val)
      { byname[name]=val; byindex[index]=val; };

    virtual void set_arg_paramstring(string pstring);

    virtual string describe();
    
  private:
    map<string,double> byname;
    map<int,double> byindex;
    int icount;
    
    int next_open_index() {
      while (byindex.find(icount) != byindex.end())
	icount++;
      return icount;
    };
    
    string namefor(int i) {
      char b[32];
      sprintf(b,"index%d",i);
      return b;
    }
    
  };

};

#endif
