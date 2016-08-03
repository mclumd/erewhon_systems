#include <list>

using namespace std;

namespace umbc {
  namespace dijkstra {
    list<int> shortestPath(int* cost_mx,int num_pts,
			   int source,int dest,long* cost);
  }
}
