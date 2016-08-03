
#include <iostream>
#include "settings.h"

using namespace std;
using namespace umbc;

int main(int argc, char** argv) {
  settings::args2SysProperties(argc,argv);
  cout << settings::getSysPropertyInt("port") << endl;
  return 0;
}
