#include "text_utils.h"
#include "settings.h"
#include "file_utils.h"
#include <fstream>
#include <stdlib.h>
#include <string.h>

using namespace umbc;

bool settings::quiet=false;
bool settings::annotate=true;
bool settings::debug=false;

namespace umbc {
  namespace settings {

    class pval {
    public:
      pval(double v) : dblV(v) {
	boolV = (v!=0);
	char q[32];
	sprintf(q,"%lf",v);
	stringV = q;
	intV=(int)dblV;
      };
      pval(int v) : intV(v) {
	boolV = (v!=0);
	char q[32];
	sprintf(q,"%d",v);
	stringV = q;
	dblV=intV;
      };
      pval(string v) : stringV(v) {
	intV = textFunctions::numval(v);
	dblV = textFunctions::dubval(v);
	boolV = textFunctions::boolval(v);
      };
      pval(bool v) : boolV(v) {
	if (v) stringV = "t"; else stringV = "f";
	if (v) intV = 1; else intV = 0;
	dblV=intV;
      };

      int    getIntV() { return intV; };
      double getDblV() { return dblV; };
      bool   getBoolV() { return boolV; };
      string getStrV() { return stringV; };


    private:
      int intV;
      bool boolV;
      double dblV;
      string stringV;
      
    };

    map<string,pval*> gs_map;

  };
};

void clearKey(string name) {
  if (settings::gs_map.find(name) != settings::gs_map.end()) {
    settings::pval* pref = settings::gs_map[name];
    settings::gs_map.erase(settings::gs_map.find(name));
    delete pref;
  }
}

void settings::setSysProperty(string name, int val) {
  clearKey(name);
  gs_map[name]=new pval(val);
}

void settings::setSysProperty(string name, bool val) {
  clearKey(name);
  gs_map[name]=new pval(val);
}

void settings::setSysProperty(string name, string val) {
  clearKey(name);
  gs_map[name]=new pval(val);
}

// def == default
int settings::getSysPropertyInt(string n,int def) {
  if (gs_map[n]==NULL) {
    gs_map[n]=new pval(def);
    return def;
  }
  else 
    return gs_map[n]->getIntV();
}

double settings::getSysPropertyDouble(string n,double def) {
  if (gs_map[n]==NULL) {
    gs_map[n]=new pval(def);
    return def;
  }
  else 
    return gs_map[n]->getDblV();
}

bool settings::getSysPropertyBool(string n,bool def) {
  if (gs_map[n]==NULL) {
    gs_map[n]=new pval(def);
    return def;
  }
  else 
    return gs_map[n]->getBoolV();
}

string settings::getSysPropertyString(string n,string def) {
    if (gs_map[n]==NULL) {
    gs_map[n]=new pval(def);
    return def;
  }
  else 
    return gs_map[n]->getStrV();
}

void settings::args2SysProperties(int argc, char** args) {
  args2SysProperties(argc,args,"");
}

void settings::args2SysProperties(int argc, char** args,string prefix) {
  int cnt=0,acnt=0;
  while (cnt < argc) {
    if (strncmp(args[cnt],"--",2)==0) {
      // it's a keyword
      char* k = args[cnt];
      k++; k++;
      string q = k;
      cnt++;
      if (cnt == argc) {
	cerr << "malformed argument list; " << q << " has no value." << endl;
      }
      else {
	string q2 = args[cnt];
	if ((prefix != "") && (q.find('.') == string::npos))
	  q=prefix+"."+q;
	// it's too early to annotate -- the logger uses settings!
	// uLog::annotate(UMBCLOG_VRB,"cmdline: "+q+"="+q2);
	cout << "cmdline: "+q+"="+q2 << endl;
	setSysProperty(q,q2);
	cnt++;
      }
    }
    else {
      // stray argument
      char a[8];
      sprintf(a,"arg%d",acnt);
      string q=args[cnt];
      string q2=a;
      setSysProperty(q,q2);
      acnt++;
      cnt++;
    }
  }
}

void settings::readPropertiesFromFile(const string& complete_path) {
  readPropertiesFromFile(complete_path,"");
}

void settings::readPropertiesFromFile(const string& complete_path,
				      const string& prefix) {
  ifstream in;
  in.open(complete_path.c_str());
  int x=0;
  if (in.is_open()) {
    string line;
    while (!in.eof()) {
      x++;
      getline (in,line);
      line = textFunctions::trimWS(line);
      if (textFunctions::prefixMatchNoWS(line,"#") || (line.size()==0)) {}
      else {
	size_t loes = line.find('=');
	if (loes == string::npos) {
	  if (prefix != "") line = prefix+"."+line;
	  setSysProperty(line,true);
	  // it's too early to annotate -- the logger uses settings!
	  cout << prefix+": "+line+" is set" << endl;
	}
	else {
	  string param = textFunctions::trimWS(line.substr(0,loes));
	  string val = textFunctions::trimWS(line.substr(loes+1,line.size()-loes));
	  if (prefix != "")
	    param=prefix+"."+param;
	  // it's too early to annotate -- the logger uses settings!
	  cout << prefix+": "+param+"="+val << endl;
	  setSysProperty(param,val);
	}
      }
    }
    in.close();
  }
}

void settings::readSystemProps(const string& sysname) {
  readPropertiesFromFile(file_utils::inHomeDirectory("."+sysname+"_settings",
						     NULL));
}

void settings::readSystemPropsCWD(const string& sysname) {
  readPropertiesFromFile("./"+sysname+"_settings.tet");
}

void settings::readSystemPropsInDir(const string& dname,
				    const string& sysname) {
  string tfn = dname+"/"+sysname+"_settings.tet";
  readPropertiesFromFile(tfn);
}

void settings::dumpSystemProps(ostream& where) {
  for (map<string,pval*>::iterator i = gs_map.begin();
       i != gs_map.end();
       i++) {
    where << describeSystemProp(i->first) << endl;
  }
}

string settings::describeSystemProp(string setting) {
  if (gs_map.find(setting) != gs_map.end()) {
    pval* pv = gs_map[setting];
    char buff[1024];
    sprintf(buff,"property(%s,@0x%0lx,%db,%d,%s)",setting.c_str(),
	    (unsigned long int)pv,pv->getBoolV(),pv->getIntV(),pv->getStrV().c_str());
    return buff;
  }
  else return "property("+setting+",unset)";
}

settings::systemPreInit mci("umbcutil");
