#include "dijkstra.h"
#include <iostream>
#include <limits>

using namespace umbc;

#define INF   std::numeric_limits< int >::max()
#define UNDEF -99999

void extract_min(list<int>& S,list<int>& Q,
		 long* dist,
		 int* cost_mx,int num_pts,
		 int* start,int* end) {
  double mc=INF;
  // set the s/e to -1 in case the only paths left are INF
  // in that case, then start and end will remain in this error state
  *start=-1; *end=-1;
  for (list<int>::iterator Qi = Q.begin(); Qi != Q.end(); Qi++) {
    for (list<int>::iterator Si = S.begin(); Si != S.end(); Si++) {
      long edgeva = dist[*Si]+cost_mx[(*Qi)*num_pts+(*Si)];
      if (edgeva < mc) {
	*start=*Si;
	*end  =*Qi;
	mc = edgeva;
      }
    }
  }
}

list<int> trace(int* prev,int num,int src,int v,int u) {
  list<int> r;
  if (u!=src) {
    r.push_front(u);
    // cout << "adding " << u << " to trace." << endl;
  }
  if (v!=src) {
    r.push_front(v);
    // cout << "adding " << v << " to trace." << endl;
  }
  while((prev[v] != src) && (prev[v]!=UNDEF)) {
    // cout << "adding " << prev[v] << " to trace." << endl;
    r.push_front(prev[v]);
    v=prev[v];
  }
  return r;
}

list<int> dijkstra::shortestPath(int* cost_mx,int num_pts,int source,int dest,long *cost) {
  /* cout << "DIJKSTRA(mx@" << hex << cost_mx
     << ", pts=" << dec << num_pts
     << ", s=" << source << ", d=" << dest
     << ", cost@" << hex << cost << endl; */
  long dist[num_pts];
  int  prev[num_pts];
  list<int> Q;
  list<int> S;
  for (int i=0;i<num_pts;i++) {
    dist[i]=INF;
    prev[i]=UNDEF;
    Q.push_back(i);
  }
  dist[source]=0;
  Q.remove(source);
  S.push_back(source);
  while (!Q.empty()) {
    int v,u;
    extract_min(S,Q,dist,cost_mx,num_pts,&v,&u);
    // cout << "extracted: v=" << v << ",u=" << u << endl;
    // termination condition (success)
    if ((v <0) || (u <0)) {
      list<int> brv;
      *cost=-1;
      return brv;
    }      
    // termination condition (success)
    if (u == dest) {
      list<int> rv = trace(prev,num_pts,source,v,u);
      // dist[u];
      if (cost != NULL) {
	*cost=dist[v]+cost_mx[u*num_pts+v];
      }
      return rv;
    }
    Q.remove(u);
    S.push_front(u);
    // cout << "DIJ: " << v << " is added, arc from " << u 
    // << " cost=" << cost_mx[u*num_pts+v] << endl;
    dist[u]=dist[v]+cost_mx[u*num_pts+v];
    prev[u]=v;
  }
  list<int> brv;
  // cout << "uh oh, dijkstra failed." << endl;
  if (cost != NULL) *cost=-1;
  return brv;
}
