#ifndef BOLO_TIMER_H
#define BOLO_TIMER_H

#ifdef WIN32
#include <Winsock2.h>
#else
#include <sys/time.h>
#endif

#include <time.h>

#define usec_per_sec 1000000

namespace umbc {

  class timer {
  public:
    static double getTimeDouble();
    bool expired();
    timer();
    timer(int seconds, int useconds);
    void restart(int seconds, int useconds);
    void restartHz(float Hz);
    bool timeRemaining(int * sleft , int * usleft);

  private:
    struct timeval current,target;

  };

};

#endif
