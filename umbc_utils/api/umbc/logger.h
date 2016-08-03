#ifndef UMBC_LOG_HEADER
#define UMBC_LOG_HEADER

#include <iostream>
#include <string>
using namespace std;

/** \file 
 * \brief a class that provides access to a flexible log stream.
 * a limited logger class that provides a static log stream called 
 * 'log' that can be set to cout, cerr, or a file.
 * everything being static introduces some serious limitations, the 
 * main one being that you can't write to more than one file.
 */

namespace umbc {

  enum annotationMode { UMBCLOG_TEXT, UMBCLOG_HTML, UMBCLOG_XTERM };

  enum annotationType { ULAT_NORMAL,    //!< no special adornments
			ULAT_PRE,       //!< pre-formatted
			ULAT_GOOD,
			ULAT_NOTGOOD,
			ULAT_BAD,
			ULAT_VERYBAD,
			ULAT_LIGHT,     //!< light in color
			ULAT_ALT1,
			ULAT_ALT2,

			ULAT_SEPERATOR,
			ULAT_BREAK
  };
  
  // THESE ARE LEGACY ANNOTATIONS... EXTEND AND USE GENERIC STUFF ABOVE
  // AND MAKE YOUR MAPPING AT THE APPLICATION LEVEL SO WE CAN MAKE THESE
  // GO AWAY!
  // scheduled to go away soon...
  #define UMBCLOG_NONE ULAT_NORMAL
  #define UMBCLOG_PRE ULAT_PRE
  #define UMBCLOG_WARNING ULAT_NOTGOOD
  #define UMBCLOG_ERROR ULAT_BAD
  #define UMBCLOG_VIOLATION ULAT_VERYBAD
  #define UMBCLOG_SUCCESS ULAT_GOOD
  #define UMBCLOG_LIST ULAT_NORMAL
  #define UMBCLOG_MSG ULAT_NORMAL
  #define UMBCLOG_DBG ULAT_ALT1 
  #define UMBCLOG_VRB ULAT_LIGHT
	 
  #define UMBCLOG_HOSTMSG ULAT_ALT2 
  #define UMBCLOG_HOSTEVENT ULAT_ALT2 
  #define UMBCLOG_HOSTDBG ULAT_LIGHT 
  #define UMBCLOG_HOSTVRB ULAT_LIGHT
  #define UMBCLOG_HOSTERR ULAT_BAD
	 
  #define UMBCLOG_SEPERATOR ULAT_SEPERATOR
  #define UMBCLOG_BREAK ULAT_BREAK

  /** The class of flexible MCL log streams
   */
  class uLog {
  public:
    uLog() {};
    
    //! sets the static log object to cout
    static void setLogToStdOut();
    //! sets the static log object to cerr
    static void setLogToStdErr();
    //! sets the static log object to a file with a dynamically generated name
    static void setLogToFile();
    //! sets the log file to the specified filename
    static void setLogToFile(string filename);
    
    //! convenience function that checks !mclSettings::quiet
    static void ifVerbose(string msg);
    
    //! annotation modes
    static void setAnnotateMode(annotationMode amode);
    
    //! annotation mode initializer
    static void annotateHeader();
    
    //! annotation mode filtering
    void setAnnotateFilter  (annotationType atype);
    //! annotation mode filtering
    void unsetAnnotateFilter(annotationType atype);
    
    //! convenience function that checks mclSettings::annotate
    static void annotate(annotationType atype);
    static void annotate(string annotation);
    static void annotate(annotationType atype, string annotation);
    //! convenience function that checks mclSettings::annotate
    //! @param lf if true, inserts a LineFeed after MSG
    static void annotate(annotationType atype, string annotation,bool lf);
    //! convenience function that checks mclSettings::annotate
    static void annotateStart(annotationType atype);
    static void annotateEnd(annotationType atype);
    //! uses annotateBuffer to dump to annotation stream
    static void annotateFromBuffer(annotationType atype);
    
    //! convenience function that checks mclSettings::debug
    static void ifDebug(string dmsg);
    //! convenience function that checks !mclSettings::quiet
    //! @param lf if true, inserts a LineFeed after MSG
    static void ifVerbose(string msg,bool lf);
    //! convenience function that checks mclSettings::debug
    //! @param lf if true, inserts a LineFeed after MSG
    static void ifDebug(string dmsg,bool lf);
    
    //! the stream to write to.
    //! should be dereferenced as
    //! *uLog::log << "hello!";
    static ostream *log;
    
    static char     annotateBuffer[1023];
    
  private:
    
    //! fileStream object in case we are logging to file
    static ofstream fileStream;
    //! closes fileStream if it is open
    static void closeIfFile();
    
  };
};

#endif
