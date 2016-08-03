#include "arguments.h"

#include <iostream>
#include <list>

int main(int argc, char** argv) {
  using namespace raccoon;
  using namespace std;
  assumed_dbl_arguments apak;
  apak.describe();
  apak.set_arg_paramstring("(3,5,-1)");
  apak.describe();
  cout << " arg0=" << apak.arg_as_dbl_by_index(0) << endl;

  list<int> foo;
  foo.push_back(2);
  cout << "list: ";
  for (list<int>::iterator i = foo.begin();
       i != foo.end();
       i++) cout << *i;
  cout << endl;
  foo.remove(2);
  cout << "list: ";
  for (list<int>::iterator i = foo.begin();
       i != foo.end();
       i++) cout << *i;
  cout << endl;
  
}
