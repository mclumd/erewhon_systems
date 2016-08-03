#include <iostream>
#include "token_machine.h"

using namespace std;
using namespace umbc;

int main(int argc, char** argv) {
  char foo[200]="(a,b,c)\n";
  string foos = foo;
  paramStringProcessor psp(foos);
  while (psp.hasMoreParams())
    cout << " param = " << psp.getNextParam() << endl;

  char foo2[200] = "{a=1,a.b=2,b=forty, q=\"douchey\", c=s1000}\n";
  string sfoo2 = foo2;
  keywordParamMachine kwm(sfoo2);
  while (kwm.hasMoreParams()) {
    string kws = kwm.getNextKWP();
    cout << " <" << kwm.keyword_of(kws) << " eq "
	 << kwm.value_of(kws) << ">" << endl;
  }

  return 0;
}
