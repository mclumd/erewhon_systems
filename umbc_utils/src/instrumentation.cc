#include "instrumentation.h"
#include "declarations.h"
#include "settings.h"
#include "logger.h"
#include <fstream>

using namespace umbc;

/***********************************************************
 ** DATASET CLASS (for logging data to flat-text)         **
 ***********************************************************/

instrumentation::dataset::dataset(string filename,int creation_mode) :
  fn(filename),state(STATE_INIT),write_mode(creation_mode),write_header(true),
  comment_header(false),base_index(0) {
  // handle opening the file and writing the header....
  autoset_format();
}

void instrumentation::dataset::add_instrument(instrument& i) { 
  is.push_back(i.clone()); 
}

void instrumentation::dataset::autoset_format() {
  string cfg_val = 
    settings::getSysPropertyString("utils.instrumentation.format","gnuplot");
  if (cfg_val == "gnuplot")
    set_format(ASCII_GNUPLOT);
  else if (cfg_val == "flat")
    set_format(ASCII_FLAT);
  else set_format(ASCII_FLAT);
}

void instrumentation::dataset::set_format(instrumentation_format_t newf) {
  cout << "output to " << fn << " set to " << newf << endl;
  switch (newf) {
  case ASCII_GNUPLOT:
    set_ascii_delim("\n");
    set_ascii_sep("\t");
    set_ascii_com("# ");
    write_header=true;
    comment_header=true;
    base_index=1;
    break;
  case ASCII_FLAT:
  default:
    set_ascii_delim("\n");
    set_ascii_sep(",");
    set_ascii_com("# ");
    write_header=true;
    comment_header=false;
    base_index=0;
    break;
  }
}

void instrumentation::dataset::writeline() {
  if (state == STATE_INIT) startfile(write_mode);
  ofstream fileStream(fn.c_str(),ios::app);
  if (fileStream.is_open()) {
    for (instrument_list_t::iterator ili = is.begin();
	 ili != is.end();
	 ili++) {
      if (ili != is.begin()) fileStream << ascii_separator;
      fileStream << (*ili)->value();
    }
    fileStream << ascii_delimiter;
    fileStream.close();
  }
  else {
    uLog::annotate(UMBCLOG_ERROR,"unable to open '"+fn+"' for writing!");
  }
}

void instrumentation::dataset::write_hdr(ofstream& fileStream) {
  if (should_comment_header()) fileStream << ascii_comment;
  int index=base_index;
  for (instrument_list_t::iterator ili = is.begin();
       ili != is.end();
       ili++) {
    if (ili != is.begin()) fileStream << ascii_separator;
    char k[16];
    sprintf(k,"(%d)",index);
    fileStream << (*ili)->get_name() << k;
    index++;
  }
  fileStream << ascii_delimiter;
}

void instrumentation::dataset::startfile(int mode) {
  bool is_new=false;
  if (file_utils::establish_file(fn,mode,&is_new)) {
    if (is_new) {
      ofstream fileStream(fn.c_str(),ios::app);
      if (should_write_header()) write_hdr(fileStream);
    }
    state=STATE_WRITING;
  }
  else
    uLog::annotate(UMBCLOG_ERROR,"unable to open '"+fn+"' for writing!");
}

/***********************************************************
 ** INSTRUMENT CLASSES (for specifying data sources)      **
 ** extend "instrument" if you don't find what you need   **
 ***********************************************************/

double instrumentation::decl_based_instrument::value() {
  return declarations::get_declaration_count(declaration);
}
