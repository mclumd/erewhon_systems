#ifndef UMBC_FILEUTILS_HEADER
#define UMBC_FILEUTILS_HEADER

#include <iostream>
#include <string>

#include "exceptions.h"

using namespace std;

namespace umbc {
  namespace file_utils {
    enum { MODE_OVERWRITE, MODE_APPEND, MODE_MOVE };

    class  unsetEnvVariableException : public exceptions::mcu_exception {

    public:
    unsetEnvVariableException(string m) : 
      mcu_exception("environment variable "+m+" is not set.") {};
      
    };

    bool establish_file(const string& fn,int mode,bool* is_new);
    bool backup_if_exists(const string& fn);
    bool file_exists(const string& fn);

    string fileNameRoot(const string& source);
    string fileNameExt(const string& source);
    string fileNamePath(const string& source);

    string inHomeDirectory(const string& file,bool* fail);
    string inEnvDirectory (const string& env,const string& file,bool* fail) throw(unsetEnvVariableException);

  };

};

#endif
