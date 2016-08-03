#include "exceptions.h"
#include <stdlib.h>
#include <iostream>

using namespace std;
using namespace umbc;

exceptions::mcu_exception default_exception;
exceptions::mcu_exception *last_exception = &default_exception;

char mcl_perror[2048];

void mc_utils_unexpected_handler() {
  cerr << "Exception!" << endl;

#if defined(MCU_ABORTS_ON_EXCEPTION)
  cerr << "exception!" << endl;
  try {
    throw;
  }
  catch (exception& e) {
    cerr << "MCU~> " << e.what() << endl;
    abort();
  }
  catch (...) {
    cerr << "MCU~> unhandled exception!" << endl;
    abort();
  }
#elif defined(MCU_RETHROWS_ON_EXCEPTION)
  throw;
#endif
}

void mc_utils_terminate_handler() {
  try {
    throw;
  }
  catch (exception& e) {
    cerr << "MCU~> " << e.what() << endl;
    abort();
  }
  catch (...) {
    cerr << "MCU~> unhandled exception!" << endl;
    abort();
  }
}

void exceptions::set_exception_handlers() {
  cout << "exception!" << endl;
  set_unexpected(mc_utils_unexpected_handler);
  set_terminate(mc_utils_terminate_handler);
}

void exceptions::signal_exception(string ms) {
  // this does not look good... did I really write this code?
  last_exception = new mcu_exception(ms);
  cerr << "~~>> MCu exception: " << last_exception->what() << endl;
  throw last_exception;
}
