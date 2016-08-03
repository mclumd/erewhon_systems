#include <iostream>
#include <fstream>
#include <list>

#include "logger.h"
#include "timer.h"
#include "settings.h"

using namespace umbc;

ostream *uLog::log = &cout;
ofstream uLog::fileStream ;

void uLog::setLogToStdOut() {
  closeIfFile();
  log = &cout;
}

void uLog::setLogToStdErr() {
  closeIfFile();
  log = &cerr;
}

void uLog::setLogToFile() {
  char fname[255];
  sprintf(fname,"logs/%9lf.log",timer::getTimeDouble());
  string poop = fname;
  setLogToFile(poop);
}

void uLog::setLogToFile(string filename) {
  closeIfFile();
  fileStream.open(filename.c_str(),ios::out);
  if (fileStream.is_open()) {
    log = &fileStream;
    setAnnotateMode(UMBCLOG_HTML);
    annotateHeader();
  }
  else {
    cerr << "WARNING: could not open " << filename << " for logging." << endl;
    setLogToStdErr();
  }
}

void uLog::closeIfFile() {
  if (fileStream.is_open()) {
    fileStream.close();
  }
}

void uLog::ifVerbose(string msg) { ifVerbose(msg); }

void uLog::ifVerbose(string msg,bool lf) {
  if (!settings::quiet) {
    *uLog::log << msg;
    if (lf) *uLog::log << endl;
  }
}

void uLog::ifDebug(string dmsg) { ifDebug(dmsg,false); }

void uLog::ifDebug(string dmsg,bool lf) {
  if (settings::debug) {
    *uLog::log << dmsg;  
    if (lf) *uLog::log << endl;
  }
}

////////////////////////////////////////////////////////////////////
//// annotation stuff...

string annote_open(annotationType atype);
string annote_close(annotationType atype);
string annote_lf();
unsigned int mcla_filter = 0;
annotationMode annotate_mode = UMBCLOG_XTERM;
list<annotationType> annotate_suppress;
int   indentLevel = 0;
char  uLog::annotateBuffer[1023];

void uLog::setAnnotateMode(annotationMode amode) {
  annotate_mode=amode;
}

void uLog::setAnnotateFilter(annotationType atype) {
  mcla_filter |= (1 << atype);
}

void uLog::unsetAnnotateFilter(annotationType atype) {
  mcla_filter &= !(1 << atype); 
}

inline bool filter(annotationType atype) {
  return (0 != (mcla_filter & (1 << atype)));
}

void uLog::annotateHeader() {
  *log << "<HEAD>\n"
	  << " <STYLE type=\"text/css\">\n"
	  << "  span { font-family: courier }\n"
	  << "  .error { font-weight : bold; font-size : 120%; color : red }\n"
	  << "  .warning { font-weight : bold; color : orange }\n"
	  << "  .vio     { background : #CCCCFF; color : #440000 }\n"
	  << "  .success { color : green }\n"
	  << "  .host { color : blue }\n"
	  << "  .hostx { font-weight : bold; color : blue }\n"
	  << "  .dbghost { font-size : 75%; color : blue }\n"
	  << " </STYLE>\n"
	  << "</HEAD>\n";
}

bool _suppress(annotationType atype) {
  // suppress if:
  //   annotate settings is off
  //   atype is filtered
  //   there is a type on the suppression vector
  return (!settings::annotate ||
	  filter(atype) ||
	  (annotate_suppress.size() > 0));
}

void uLog::annotateFromBuffer(annotationType atype) { 
  annotate(atype,annotateBuffer,true); 
}

void uLog::annotate(annotationType atype) { 
  annotate(atype,"",false); 
}

void uLog::annotate(string annotation) { 
  annotate(ULAT_NORMAL,annotation,false); 
}

void uLog::annotate(annotationType atype, string annotation) { 
  annotate(atype,annotation,true); 
}

void uLog::annotate(annotationType atype, string annotation, bool lf) {
  if (!_suppress(atype)) {
    // bizarre, but it helps in debug
    string out = annote_open(atype);
    out += annotation;
    out += annote_close(atype);
    *log << out;
    if (lf) {
      *log << annote_lf() << endl;
    }
  }
}

void uLog::annotateStart(annotationType atype) {
  if (filter(atype)) annotate_suppress.push_front(atype);
  if (!_suppress(atype)) {
    *log << annote_open(atype) << endl;
  }
}

void uLog::annotateEnd(annotationType atype) {
  if (annotate_suppress.size() > 0) {
    if (annotate_suppress.front() == atype) 
      annotate_suppress.pop_front();
    else {
      cerr << "MCL_LOG_ERROR ~~> failed to match end " << atype 
	   << " with start " << annotate_suppress.front() << endl
	   << "                  annotation may become non-functional."
	   << endl;
    }
  }
  if (!_suppress(atype)) {
    *log << annote_close(atype) << endl;
  }  
}

string annote_open(annotationType atype) { 
  if (annotate_mode == UMBCLOG_HTML) {
    switch (atype) {
    case ULAT_PRE:
      return "<pre size=\"-1\">";
    case ULAT_GOOD:
      return "<span class=\"success\">";
    case ULAT_NOTGOOD:
      return "<span class=\"warning\">";
    case ULAT_BAD:
      return "<span class=\"error\">";
    case ULAT_VERYBAD:
      return "<span class=\"vio\">";
    case ULAT_NORMAL:
      return "<span class=\"msg\">";      
    case ULAT_LIGHT:
      return "<span style=\"color:gray; font-style:italic;\">";
    case ULAT_ALT1:
      return "<span class=\"host\">";      
    case ULAT_ALT2:
      return "<span class=\"hostx\">";      
    case ULAT_SEPERATOR:
      return "<hr>";
    case ULAT_BREAK:
      return "<br>";
    default:
      // cout << "open returning msg span." << endl;
      return "<span>";
    }
  }
  else if (annotate_mode == UMBCLOG_XTERM) {
    //bool blackback = settings::getSysPropertyBool("utils.blackback",false);
    switch (atype) {
    case ULAT_PRE:
      return "";
    case ULAT_GOOD:
      return "\033[0;32m";
    case ULAT_NOTGOOD:
      return "\033[1;31m";
    case ULAT_BAD:
      return "\033[1;31m";
    case ULAT_VERYBAD:
      return "\033[1;37;41m";
    case ULAT_SEPERATOR:
      return "------------------------------------------------------\n";
    case ULAT_BREAK:
      return "\n";
    case ULAT_NORMAL:
      //if (blackback) return "\033[0;39m";
      // else return "\033[0;30m";
      return "\033[0;39m";
    case ULAT_LIGHT:
      return "\033[1;30m";
    case ULAT_ALT1:
      return "\033[0;34m";
    case ULAT_ALT2:
      return "\033[0;35m";
    default:
      return "";
    }
  }
  else return "";
}

string annote_close(annotationType atype) { 
  if (annotate_mode == UMBCLOG_HTML) {
    switch (atype) {
    case ULAT_PRE:
      return "</pre>";
    default:
      return "</span>";
    }
  }
  else if (annotate_mode == UMBCLOG_XTERM) {
    return "\033[0;39m";
    // bool blackback = settings::getSysPropertyBool("utils.blackback",false);
    // if (blackback) return "\033[0;37m";
    // else return "\033[0;30m";
  }
  else return "";
}

string annote_lf() { 
  if (annotate_mode == UMBCLOG_HTML)
    return "<br>\n";
  else return ""; 
}
