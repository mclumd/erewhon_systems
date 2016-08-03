#include <iostream>
#include "logger.h"

using namespace std;
using namespace umbc;

int main(int argc, char** argv) {
  uLog::setAnnotateMode(UMBCLOG_XTERM);
  uLog::annotate(UMBCLOG_PRE,"preformatted.");
  uLog::annotate(UMBCLOG_ERROR,"error.");
  uLog::annotate(UMBCLOG_HOSTERR,"host error.");
  uLog::annotate(UMBCLOG_WARNING,"warning.");
  uLog::annotate(UMBCLOG_SUCCESS,"success.");
  uLog::annotate(UMBCLOG_VIOLATION,"violation.");
  uLog::annotate(UMBCLOG_SEPERATOR,"seperator.");
  uLog::annotate(UMBCLOG_MSG,"message.");
  uLog::annotate(UMBCLOG_VRB,"verbose.");
  uLog::annotate(UMBCLOG_BREAK,"break.");
  uLog::annotate(UMBCLOG_HOSTMSG,"host message.");
  uLog::annotate(UMBCLOG_HOSTVRB,"host verbose.");
  uLog::annotate(UMBCLOG_DBG,"debug.");
  uLog::annotate(UMBCLOG_HOSTEVENT,"host event.");
}
