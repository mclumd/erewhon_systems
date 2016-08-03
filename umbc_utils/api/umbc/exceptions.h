#ifndef MC_UTILS_EXCEPTIONS_H
#define MC_UTILS_EXCEPTIONS_H

#include <exception>
#include <string>

using namespace std;

#define MCU_ABORTS_ON_EXCEPTION
// #define MCU_RETHROWS_ON_EXCEPTION

namespace umbc {

  namespace exceptions {

    /** \file
     * \brief MC UTILS high level exception handling.
     * contains code for throwing and handling exceptions.
     */
    
    class mcu_exception : public exception {
    public:
      
      mcu_exception() : exception(),msg("unspecified exception.") {};
      mcu_exception(string m) : exception(),msg(m) 
	{ 
	  // cout << "constructing ex : " << msg.c_str() << endl;
	  // cout << "constructing ex : " << msg << endl;
	  // cout << "constructing ex : " << what() << endl;
	};
      virtual ~mcu_exception() throw() {};
      
      virtual const char *what() {
	return msg.c_str();
      };
      
    protected:
      string msg;
      
    };

    //! sets up the default exception handlers
    void set_exception_handlers();

    //! signals a known exception
    void signal_exception(string msg);
  };

};

#endif

