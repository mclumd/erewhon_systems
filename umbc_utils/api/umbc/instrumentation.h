#ifndef UMBC_INSTRUMENTATION_HEADER
#define UMBC_INSTRUMENTATOIN_HEADER

#include "file_utils.h"
#include <iostream>
#include <string>
#include <list>
using namespace std;

/** \file 
 * \brief a class that provides instrumentation for experiments.
 * a framework for specifying system measurables and writing them to
 * a flat text file
 */

namespace umbc {

  namespace instrumentation {

    enum instrumentation_format_t { ASCII_GNUPLOT, ASCII_FLAT };

    class instrument;
    typedef list<instrument*> instrument_list_t;
    
    class dataset {
    public:
      dataset(string filename,int creation_mode=file_utils::MODE_MOVE);
      void add_instrument(instrument& i);

      virtual void writeline();

      virtual void set_format(instrumentation_format_t newf);

      virtual ~dataset() {};
      
    protected:
      enum { STATE_INIT, STATE_WRITING };
      void set_ascii_delim(string delim) { ascii_delimiter=delim; };
      void set_ascii_sep  (string sep)   { ascii_separator=sep; };
      void set_ascii_com  (string com)   { ascii_comment=com; };
      virtual bool should_write_header() { return write_header; };
      virtual bool should_comment_header() { return comment_header; };
      
    private:
      string fn;
      int state,write_mode;
      instrument_list_t is;

      bool   write_header,comment_header;
      string ascii_delimiter,ascii_separator,ascii_comment;
      int    base_index;

      void startfile(int mode);
      void write_hdr(ofstream& fileStream);
      void autoset_format();

    };
    
    class instrument {
    public:
      instrument(string name) : nm(name) {};
      virtual double value()=0;
      virtual instrument* clone()=0;
      virtual string get_name() { return nm; };
      virtual ~instrument() {};
      
    protected:
      string nm;
      
    };

    class int_ptr_instrument : public instrument {
    public:
      int_ptr_instrument(string name, int* src) : 
	instrument(name),source(src) {};
      virtual double value() { return *source; };
      virtual instrument* clone() { return new int_ptr_instrument(*this); };
      
    private:
      int* source;
    };
    
    class dbl_ptr_instrument : public instrument {
    public:
      dbl_ptr_instrument(string name, double* src) : 
	instrument(name),source(src) {};
      virtual double value() { return *source; };
      virtual instrument* clone() { return new dbl_ptr_instrument(*this); };
      
    private:
      double* source;
    };
    
    class decl_based_instrument : public instrument {
    public:
      decl_based_instrument(string name, string decl) :
	instrument(name),declaration(decl) {};
      virtual double value();
      virtual instrument* clone() { return new decl_based_instrument(*this); };
      
    private:
      string declaration;
      
    };

  };

};

#endif
