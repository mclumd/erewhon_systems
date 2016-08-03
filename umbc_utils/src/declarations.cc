#include "declarations.h"

#include <stdio.h>
#include <iostream>
#include <map>

using namespace umbc;

map<string,int> dec_cnts;

void do_declare( const char* dec, int k=1 ) {
  // cout << "declaration: " << dec << endl;
  string n = dec;
  if (dec_cnts.find(n) != dec_cnts.end())
    dec_cnts[n]+=k;
  else
    dec_cnts[n]=k;
}

void declarations::declare( string dec ) {
  do_declare(dec.c_str());
}

void declarations::make_declaration( int dcount, ... ) {
  va_list arguments;
  va_start( arguments, dcount );
  for ( int x = 0 ; x < dcount ; x++ ) {
    char* l = va_arg( arguments, char*);
    do_declare( l );
  }
}

void declarations::declare_n( string dec, int cnt ) {
  do_declare( dec.c_str(),cnt );
}

int declarations::get_declaration_count( string desc ) {
  map<string,int>::iterator q = dec_cnts.find(desc);
  if (q == dec_cnts.end())
    return 0;
  else
    return q->second;
}

void declarations::clear_declaration_counts() {
  dec_cnts.clear();
}

void declarations::clear_declaration_count( string dec ) {
  dec_cnts[dec]=0;
}

void declarations::set_dec_cnt( string dec, int n ) {
  clear_declaration_count(dec);
  declare_n(dec,n);
}

string declarations::dec_cnts_as_str() {
  string q="{ ";
  char   qb[128];
  for ( map<string,int>::iterator i = dec_cnts.begin();
	i != dec_cnts.end();
	i++) {
    sprintf(qb,"%.64s=%d",i->first.c_str(),i->second);
    q+=qb;
    q+=" ";
  }
  q+="}";
  return q;
}
