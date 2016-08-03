#include "file_utils.h"
#include "exceptions.h"
#include <stdlib.h>
#include <fstream>
#include <sys/stat.h>

using namespace umbc;

bool file_utils::establish_file(const string& fn,int mode,bool* is_new) {    
  if (is_new) *is_new = false;
  switch (mode) {
  case MODE_OVERWRITE: {
    ofstream fileStream(fn.c_str(),ios::out);
    if (fileStream.is_open()) {
      if (is_new) *is_new = true;
      return true;
    }
    else return false;
  }
  case MODE_APPEND: {
    if (file_exists(fn))
      return true;
    else {
     ofstream fileStream(fn.c_str(),ios::out);
     if (fileStream) {
       if (is_new) *is_new=true;
       return true;
     }
     else return false;
    }
  }
  case MODE_MOVE: {
    file_utils::backup_if_exists(fn);
     ofstream fileStream(fn.c_str(),ios::out);
     if (fileStream) {
       if (is_new) *is_new=true;
       return true;
     }
     else return false;
  }
  }
  exceptions::signal_exception("unknown mode for '"+fn+"'!!!");
  return false;  // won't get here but keeps -Wall quiet
}

#define TOO_MANY_BACKUPS 512

bool file_utils::backup_if_exists(const string& filename) {
  if (!file_exists(filename))
    return false;
  else {
    for (int i = 1; i < TOO_MANY_BACKUPS; i++) {
      char bufn[1024];
      sprintf(bufn,"%s~%d~",filename.c_str(),i);
      if (!file_exists((string)bufn)) {
	ifstream i(filename.c_str(),ios_base::in|ios_base::binary);
	ofstream o(bufn,ios_base::out|ios_base::binary);
	o << i.rdbuf();  
	return true;
      }
    }
    // too many backups!
    exceptions::signal_exception("too many backups of '"+filename+"'!!!");
    return false;  // won't get here but keeps -Wall quiet
  }
}

bool file_utils::file_exists(const string& filename) {
  struct stat f_stat;
  int srv;

  srv = stat(filename.c_str(),&f_stat);
  if(srv == 0) {
    // check to make sure it's a regular file...
    if (S_ISREG(f_stat.st_mode))
      return true;
    else
      return false;
  } else {
    // see "man -S2 stat" if this is not good enough
    return false;
  }
}


string file_utils::fileNameRoot(const string& source) {
  size_t lastslash = source.find_last_of('/');
  size_t firstdot  = string::npos;
  if (lastslash == string::npos) {
    lastslash=0;
    firstdot = source.find('.');
  }
  else {
    firstdot = source.find('.',lastslash);
    lastslash++;
  }
  if (firstdot == string::npos) return source.substr(lastslash);
  else return source.substr(lastslash,firstdot-lastslash);
}

string file_utils::fileNameExt(const string& source) {
  size_t lastslash = source.find_last_of('/');
  size_t firstdot  = string::npos;
  if (lastslash == string::npos) firstdot = source.find('.');
  else firstdot = source.find('.',lastslash);
  if (firstdot == string::npos) return "";
  else return source.substr(firstdot);
}

string file_utils::fileNamePath(const string& source) {
  size_t lastslash = source.find_last_of('/');
  if (lastslash == string::npos) return "";
  else return source.substr(0,lastslash+1);
}

string file_utils::inHomeDirectory(const string& file,bool* fail) {
  if (fail != NULL) *fail=false;
  const char* path2home = getenv("HOME");
  if (path2home) 
    return (string)path2home+"/"+file;
  else {
    if (fail != NULL) *fail=true;
    return file;
  }
}

string file_utils::inEnvDirectory(const string& env,
				  const string& file,bool* fail) 
  throw(unsetEnvVariableException) {

  if (fail != NULL) *fail=false;
  const char* path2env = getenv(env.c_str());
  if (path2env) 
    return (string)path2env+"/"+file;
  else {
    if (fail != NULL) {
      *fail=true;
      return file;
    }
    else throw unsetEnvVariableException(env);
    return file;    
  }

}
