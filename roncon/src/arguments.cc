#include "arguments.h"
#include "umbc/token_machine.h"

using namespace raccoon;

void assumed_dbl_arguments::set_arg_paramstring(string pstring) {
  using namespace umbc;
  paramStringProcessor psp(pstring);
  cout << "parsing paramstring " << pstring << endl;
  int i=0;
  while (psp.hasMoreParams()) {
    string nv = psp.getNextParam();
    cout << " paramstring " << nv << ":" 
	 << textFunctions::dubval(nv) << endl;
    set_arg_by_index(i,textFunctions::dubval(nv));
    i++;
  }
  cout << " paramset_argpak ~~ " << describe() << endl;
}

string assumed_dbl_arguments::describe() {
  char b[256];
  string rv="<argPak: ";
  for (map<string,double>::iterator i = byname.begin();
       i != byname.end();
       i++) {
    sprintf(b,"%s=%lf ",i->first.c_str(),i->second);
    rv+=b;
  }
  rv+=">";
  return rv;
}
