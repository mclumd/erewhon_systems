#include <iostream>
#include "file_utils.h"

using namespace std;
using namespace umbc;

int main(int argc, char** argv) {
  // these are file utils...
  string dfn = "/bootang/wutang/foo.dimple/crack.head";
  cout << "full string = '" << dfn << "'" << endl;
  cout << "path = '" << file_utils::fileNamePath(dfn) << "'" << endl;
  cout << "file = '" << file_utils::fileNameRoot(dfn) << "'" << endl;
  cout << "ext  = '" << file_utils::fileNameExt(dfn) << "'" << endl;
  dfn = "cracker.jack";
  cout << "full string = '" << dfn << "'" << endl;
  cout << "path = '" << file_utils::fileNamePath(dfn) << "'" << endl;
  cout << "file = '" << file_utils::fileNameRoot(dfn) << "'" << endl;
  cout << "ext  = '" << file_utils::fileNameExt(dfn) << "'" << endl;
  dfn = "/poop/poopie/doodoo/";
  cout << "full string = '" << dfn << "'" << endl;
  cout << "path = '" << file_utils::fileNamePath(dfn) << "'" << endl;
  cout << "file = '" << file_utils::fileNameRoot(dfn) << "'" << endl;
  cout << "ext  = '" << file_utils::fileNameExt(dfn) << "'" << endl;
  return 0;
}
