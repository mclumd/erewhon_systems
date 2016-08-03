#include <iostream>
#include <limits>
#include "dijkstra.h"

using namespace std;
using namespace umbc;

#define PTS 5

void set(int s,int d,int* v,int c) {
  v[s*PTS+d]=c;
  v[d*PTS+s]=c;
}

void dump(list<int>& a) {
  if (a.empty()) 
    cout << "no path.";
  for (list<int>::iterator i = a.begin();
       i!=a.end();
       i++) {
    if (i != a.begin()) cout << "~>";
    cout << *i;
  }
  cout << endl;
}

int main(int argc, char** argv) {
  int cost_mx[PTS*PTS];
  for (int s = 0; s< PTS; s++) 
    for (int d = 0; d<PTS; d++)
      if (s==d) set(s,d,cost_mx,0);
      else set(s,d,cost_mx,std::numeric_limits< int >::max());
  set(0,2,cost_mx,3);
  set(2,4,cost_mx,4);
  set(2,3,cost_mx,7);
  set(4,3,cost_mx,2);
  long c=-22;
  {
    list<int> q = dijkstra::shortestPath(cost_mx,PTS,0,3,&c);
    dump(q);  
  }
  {
    list<int> q = dijkstra::shortestPath(cost_mx,PTS,2,1,&c);
    dump(q);  
  }
  cout << "ok?" << endl;
  // dijkstra::shortestPath(cost_mx,PTS,1,3,&c);

}
