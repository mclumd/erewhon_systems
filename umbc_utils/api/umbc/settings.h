#ifndef UMBC_SETTINGS_HEADER
#define UMBC_SETTINGS_HEADER

#include <map>
#include <string>
#include <iostream>

using namespace std;

/** \file
 *  \brief general settings to be accessible from all of MCL-Core
 * currently contains flags for output
 */

namespace umbc {

  namespace settings {
    //  hard coded settings...
    
    //! if true then minimal (no) output
    extern bool quiet;
    
    //! if true then output formatted/HTML output
    extern bool annotate;
    
    //! if true then debugging output
    extern bool debug;
        
    //! this is an API for general-purpose global properties...
    //! will be made available through /api
    void setSysProperty(string name,int val);
    void setSysProperty(string name,string val);
    void setSysProperty(string name,bool val);

    int    getSysPropertyInt(string name,int def=0);
    double getSysPropertyDouble(string name,double def=0);
    bool   getSysPropertyBool(string name,bool def=false);
    string getSysPropertyString(string name,string def="none");

    void args2SysProperties(int argc, char** args, string prefix);
    void args2SysProperties(int argc, char** args);

    void readPropertiesFromFile(const string& complete_path,
				const string& prefix);
    void readPropertiesFromFile(const string& complete_path);
    void readSystemProps(const string& sysname);
    void readSystemPropsCWD(const string& sysname);
    void readSystemPropsInDir(const string& dname,const string& sysname);

    void dumpSystemProps(ostream& where);
    string describeSystemProp(string prop);

    class systemPreInit {
    public:
      systemPreInit(string system) { readSystemProps(system); };
    };
    
  };
};

#endif
