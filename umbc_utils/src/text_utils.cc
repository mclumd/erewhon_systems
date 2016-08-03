#include "text_utils.h"
#include <errno.h>
#include <iostream>
#include <fstream>
#include <cctype>
#include <algorithm>
#include <limits>

using namespace umbc;

//////////////////////////////////////////////////////////////////
//
//                     THIS IS TEXT UTILITIES !
//
//////////////////////////////////////////////////////////////////

string textFunctions::DEFAULT_OPEN_PROTECTORS  = "([{\"";
string textFunctions::DEFAULT_CLOSE_PROTECTORS = ")]}\"";

double textFunctions::dubval(string q) {
  double r;
  char * poo;
  r=strtod(q.c_str(),&poo);
  return r;
}

string textFunctions::num2string(int q) {
  char buff[64];
  sprintf(buff,"%d",q);
  return buff;
}

string textFunctions::num2string(double q) {
  char buff[64];
  sprintf(buff,"%f",q);
  return buff;
}

int textFunctions::numval(string q) {
  errno = 0;
  long qv = strtol(q.c_str(),NULL,0);
  // cout << "in numval: (" << q << ") qv = " << qv 
  // << " j = " << std::numeric_limits<int>::max() << endl;
  // if (errno != 0) perror("numval");
  if ((errno == 0) && (qv > std::numeric_limits<int>::max())) errno = ERANGE;
  return qv;
}

long textFunctions::longval(string q) {
  errno = 0;
  long qv = strtol(q.c_str(),NULL,0);
  return qv;
}

unsigned int textFunctions::unumval(string q) {
  long qv = strtol(q.c_str(),NULL,0);
  return (unsigned int)qv;
}

bool textFunctions::boolval(string q) {
  if ((q == "true") || (q == "TRUE") || (q == "True") || (q == "t"))
    return true;
  else return false;
}

int textFunctions::valueOrHash(string q) {
  int rv = numval(q);
  if (rv == 0)
    return hashKey(q);
  else
    return rv;
}

string textFunctions::str2lower(string source) {
  string rv = source;
  transform(rv.begin(), rv.end(), rv.begin(), (int(*)(int))tolower);
  return rv;
}

string textFunctions::str2upper(string source) {
  string rv = source;
  transform(rv.begin(), rv.end(), rv.begin(), (int(*)(int))toupper);
  return rv;
}

int textFunctions::hashKey(string q) {
  int hk=0;
  for (int k=2; k < (int)q.length(); k++)
    hk = (hk<<4)^(hk>>28)^q[k];
  hk &= 0x0FFFFFFF;
  return hk;
}

void textFunctions::adjustProtectLevel(char c,int *p) {
  if (c == '(')
    (*p)++;
  else if (c == ')')
    (*p)--;
  if (*p < 0) *p=0;
}

string textFunctions::adjustProtectLevelEnhanced(char c,string protect,
						 string open,string close,
						 bool* error) {
  size_t oind = open.find(c);
  // if it's found in the opener list...
  if (oind != string::npos) {
    // first check to make sure that the closer is not the same
    // and we're already in one of those protect passages
    if ((close[oind] == c) && 
	(protect.size() > 0) &&
	(protect[protect.size()-1] == open[oind]))
      // this is like " or '
      return protect.substr(0,protect.size()-1);
    else
      // this is like ( or [
      return protect+c;
  }
  else {
    // now check to see if we are closing a symmetric protect
    size_t cind = close.find(c);
    if (cind != string::npos) {
      if ((protect.size() > 0) &&
	  (protect[protect.size()-1] == open[cind]))
	// this would be a ) or a ] matching a ( or a [
	return protect.substr(0,protect.size()-1);
      else {
	// this is a mismatched closer...
	if (error != NULL) *error=true;
	cerr << "parse error - closed protect while unopened: " 
	     << "cind=" << cind << " top(protect)=" 
	     << protect[protect.size()-1]
	     << " close[cind]=" << close[cind]
	     << " open[cind]=" << open[cind]
	     << endl;
	return protect;
      }
    }
    else return protect;
  }
}

bool textFunctions::isWS(char c) {
  return (isspace(c) != 0);
}

bool textFunctions::isEscape(char c) {
  return (c == '\\');
}

bool textFunctions::prefixMatchNoWS(string src,string prefix) {
  for (size_t i=0;i<src.size();i++) {
    if (!isWS(src[i])) {
      // cout << "  " << src << endl;
      // cout << "nonWS @" << i << " find is @" << src.find(prefix,i) << endl;
      if (src.find(prefix,i) != i)
	return false;
      else
	return true;
    }
  }
  return false;
}

bool textFunctions::firstNonWSinBag(string src,string charbag) {
  for (size_t i=0;i<src.size();i++) {
    if (!isWS(src[i])) {
      if (charbag.find(src[i]) != string::npos)
	return false;
      else
	return true;
    }
  }
  return false;
}

string textFunctions::readUntilWS(string k,int start,int end,int *nextStart) {
  // reads until ws char is found
  bool reading=false,escape=false;
  int protect=0,tstart=end;
  for (*nextStart=start;*nextStart < end;(*nextStart)++) {
    if (escape)     // eat the escape character
      escape=false;
    else {
      adjustProtectLevel(k[*nextStart],&protect); // up or down based on parens
      if (isEscape(k[*nextStart]))
	{ reading=true; escape=true; }
      else {
	if (isWS(k[*nextStart])) {
	  if (reading) {
	    if (protect == 0) { // terminate condition (isWS(char) && !protect)
	      return k.substr(tstart,*nextStart-tstart);
	    }
	  }
	}
	else if (!reading) {
	  reading = true;
	  tstart=*nextStart;
	}
      }
    }
  }
  if ((tstart == *nextStart) || (*nextStart > (int) k.size()))
    return "";
  else {
    return k.substr(tstart,*nextStart-tstart);
  }
}

string textFunctions::readUntilWSEnhanced(string k,int start,int end,int *nextStart) {
  // reads until ws char is found
  bool reading=false,escape=false;
  string protect="";
  int tstart=end;
  for (*nextStart=start;*nextStart < end;(*nextStart)++) {
    if (escape)     // eat the escape character
      escape=false;
    else {
      bool apl_error=false;
      string np = adjustProtectLevelEnhanced(k[*nextStart],protect,
					     DEFAULT_OPEN_PROTECTORS,
					     DEFAULT_CLOSE_PROTECTORS,
					     &apl_error);
      if (np != protect) {}
	// cout << "protect changed to <" << np << ">" << endl;
      protect = np;
      if (apl_error) {
	// cerr << "ERR: " << k << "@" << *nextStart << endl;
      }
      if (isEscape(k[*nextStart]))
	{ reading=true; escape=true; }
      else {
	if (isWS(k[*nextStart])) {
	  if (reading) {
	    // terminate condition (reading && isWS(char) && !protect)
	    if (protect.size() == 0) { 
	      return k.substr(tstart,*nextStart-tstart);
	    }
	  }
	}
	else if (!reading) {
	  // this is the first nonWS character...
	  reading = true;
	  tstart=*nextStart;
	}
      }
    }
  }
  if ((tstart == *nextStart) || (*nextStart > (int) k.size()))
    return "";
  else {
    return k.substr(tstart,*nextStart-tstart);
  }
}

void textFunctions::dumpTokens(string k) {
  int foo=0,x=0;
  while ((unsigned int)foo != k.size()) {
    x++;
    string q = readUntilWS(k,foo,k.size(),&foo);
  }
}

string textFunctions::file2string(string fn,bool convert_eol_to_ws) {
  return file2string(fn,"#",convert_eol_to_ws);
}

string textFunctions::file2string(string fn,string comment_pre,bool convert_eol_to_ws) {
  string rv="";
  ifstream in;
  in.open(fn.c_str());
  int x=0;
  if (in.is_open()) {
    string line;
    while (!in.eof()) {
      x++;
      getline (in,line);
      if ((line.empty() && convert_eol_to_ws) ||
	  ((comment_pre != "") && prefixMatchNoWS(line,comment_pre))) {}
      else if (rv.empty())
	rv=line;
      else {
	if (convert_eol_to_ws)
	  rv+=" "+line;
	else
	  rv+="\n"+line;
      }
    }
    in.close();
    if (!convert_eol_to_ws) rv+="\n";
    return rv;
  }
  else return "";
}

string textFunctions::dequote(string src) {
  if ((src.size() >= 2) && (src[0] == '"') && (src[src.size()-1] == '"')) {
    src = src.substr(1,src.size()-2);
  }
  return src;
}

// void textFunctions::dumpTokArrStr(string tas) {
//   tokenMachine tm(tas);
//   while (tm.moreTokens()) {
//     string tt = tm.nextToken();
//     std::replace( tt.begin(), tt.end(), '^', ' ' );
//     cout << " " << tt << endl;
//   }
// }

string textFunctions::substChar(const string source, char c_was, char c_is) {
  string rv=source;
  for (size_t i=0;i<source.length();i++) {
    // printf("%d: %c versus %c\n",i,source.at(i),c_was);
    if (source.at(i) == c_was) {
      // printf("equals.\n");
      rv.replace(i,1,1,c_is);
    }
  }
  return rv;
}

string textFunctions::getFunctor(const string source) {
  for (size_t i=0; i<source.length(); i++) {
    if (source.at(i) == '(') {
      return source.substr(0,i);
    }
  }
  return source;
}

string textFunctions::getParameters(const string source) {
  int start=-1,end=-1;
  for (size_t i=0; i<source.length(); i++) {
    if (source.at(i) == '(') {
      start=i;
      break;
    }
  }
  if (start == -1)
    return "";
  for (int i2=source.length()-1; i2 > start; i2--) {
    if (source.at(i2) == ')') {
      end = i2;
      break;
    } 
  }
  if (start < end)
    return source.substr(start,end);
  else return "";
}

string textFunctions::trimParens(string src) {
  if ((src[0] == '(') && (src[src.length()-1] == ')')) {
    // printf("parens mashed.\n");
    return src.substr(1,src.length()-2);
  }
  return src;
}

string textFunctions::trimBrackets(string src) {
  if ((src[0] == '[') && (src[src.length()-1] == ']')) {
    // printf("parens mashed.\n");
    return src.substr(1,src.length()-2);
  }
  return src;
}

string textFunctions::trimAngleBrackets(string src) {
  if ((src[0] == '<') && (src[src.length()-1] == '>')) {
    // printf("parens mashed.\n");
    return src.substr(1,src.length()-2);
  }
  return src;
}

string textFunctions::trimBraces(string src) {
  if ((src[0] == '{') && (src[src.length()-1] == '}')) {
    // printf("parens mashed.\n");
    return src.substr(1,src.length()-2);
  }
  return src;
}

string textFunctions::trimWS(const string& src) {
  size_t newstart=0;
  size_t newend=src.size();
  while (!isgraph(src[newstart]) && (newstart < newend))
    newstart++;

  while (!isgraph(src[newend-1]) && (newend > newstart))
    newend--;

  return src.substr(newstart,newend);
}
