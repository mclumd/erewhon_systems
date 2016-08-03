#include "umbc/instrumentation.h"
#include "umbc/logger.h"
#include "umbc/declarations.h"
#include <math.h>

using namespace std;
using namespace umbc;

int main(int argc, char** argv) {
  uLog::setAnnotateMode(UMBCLOG_XTERM);
  if (argc < 2) 
    uLog::annotate(UMBCLOG_ERROR,"usage: " + (string)argv[0] + " <outfile>");
  else {
    int counter=0;
    double c,s;
    instrumentation::dataset d((string)argv[1]);
    instrumentation::int_ptr_instrument i1("counter",&counter);
    instrumentation::dbl_ptr_instrument i2("cosine",&c);
    instrumentation::dbl_ptr_instrument i3("sine",&s);
    instrumentation::decl_based_instrument i4("sine","over");
    d.add_instrument(i1);
    d.add_instrument(i2);
    d.add_instrument(i3);
    d.add_instrument(i4);
    for (int i=0;i<100;i++) {
      counter++;
      c=cos((double)counter/25);
      s=sin((double)counter/25);
      if ((c > 0.9) || (s > 0.9))
	declarations::declare("over");
      d.writeline();
    }
  }
  return 0;
}
