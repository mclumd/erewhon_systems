#ifndef MC_UTILS_DECLARATIONS_H
#define MC_UTILS_DECLARATIONS_H

#include <string>
#include <cstdarg>
using namespace std;

namespace umbc {

  namespace declarations {
    void make_declaration( int dcount, ... );
    void declare( string dec );
    void declare_n( string dec, int cnt );
    void set_dec_cnt( string dec, int n );
    void clear_declaration_counts();
    void clear_declaration_count( string dec );
    int  get_declaration_count( string dec );
    string dec_cnts_as_str();
  };

};

#endif
