#include "timer.h"

using namespace umbc;

#ifdef WIN32
#include <sys/timeb.h>
#include <sys/types.h>
#include <winsock2.h>
static void gettimeofday(struct timeval* t,void* timezone)
{       struct _timeb timebuffer;
        _ftime( &timebuffer );
        t->tv_sec=timebuffer.time;
        t->tv_usec=1000*timebuffer.millitm;
}
#endif

double timer::getTimeDouble() {
  timeval curr;
  gettimeofday(&curr,NULL);
  return curr.tv_sec+(double)curr.tv_usec/(double)usec_per_sec;
}

timer::timer() {
  gettimeofday(&target,NULL);
  gettimeofday(&current,NULL);
}

timer::timer(int seconds, int useconds) {
  gettimeofday(&current,NULL);
  int carry=0;
  target.tv_usec=current.tv_usec+useconds;
  if (target.tv_usec > usec_per_sec) {
    target.tv_usec = target.tv_usec % usec_per_sec;
    carry=1;
  }
  target.tv_sec=current.tv_sec+seconds+carry;
}

void timer::restart(int seconds, int useconds) {
  gettimeofday(&current,NULL);
  int carry=0;
  target.tv_usec=current.tv_usec+useconds;
  if (target.tv_usec > usec_per_sec) {
    target.tv_usec = target.tv_usec % usec_per_sec;
    carry=1;
  }
  target.tv_sec=current.tv_sec+seconds+carry;
}

void timer::restartHz(float Hz) {
  int sv=0,usv=0;
  usv = (int)((float)1000000 / Hz);
  restart(sv,usv);
}

bool timer::expired() {
  gettimeofday(&current,NULL);
  return ((current.tv_sec > target.tv_sec) ||
	  ((current.tv_sec == target.tv_sec) &&
	   (current.tv_usec > target.tv_usec)));
}

bool timer::timeRemaining(int * sleft , int * usleft) {
  if (expired()) {
    *sleft=0;
    *usleft=0;
    return false;
  }
  else {
    *sleft = target.tv_sec - current.tv_sec;
    if (current.tv_usec >= target.tv_usec)
      *usleft = target.tv_usec - current.tv_usec;
    else {
      *usleft = current.tv_usec - target.tv_usec;
      (*sleft)-=1;
    }
    return true;
  }
}
