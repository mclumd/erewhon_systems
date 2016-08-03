#include "scoring.h"
#include "declarations.h"
#include "timer.h"
#include <iostream>
#include <fstream>
#include <stdlib.h>

using namespace umbc;

void scoring_system::write_score() {
  ofstream fileStream;
  fileStream.open(filename.c_str(),ios::out|ios::app);
  if (fileStream.is_open()) {
    fileStream << "(" << declarations::get_declaration_count("simStep")
	       << "," << get_score()
	       << ")" << endl;
    fileStream.close();
  }
  else {
    cerr << "could not open scoring file " << filename << "... eixiting..."
	 << endl;
    exit(-1);
  }
}

void scoring_system::write_hdr() {
  ofstream fileStream;
  fileStream.open(filename.c_str(),ios::out);
  if (fileStream.is_open()) {
    fileStream << "# (time,score)" << endl;
    fileStream.close();
  }
  else {
    cerr << "could not open scoring file " << filename << "... eixiting..."
	 << endl;
    exit(-1);
  }  
}

string scoring_system::default_filename() {
  char fname[255];
  sprintf(fname,"logs/score_%9lf.log",timer::getTimeDouble());
  string poop = fname;
  return fname;
}

void decl_based_scorer::update_score() {
  score = 0.0;
  for ( map<string, double>::const_iterator it = scoremap.begin(); 
	it != scoremap.end(); 
	it++ ) {
    string key = it->first;
    double val = it->second;
    score += val * declarations::get_declaration_count(key);
  }
}
