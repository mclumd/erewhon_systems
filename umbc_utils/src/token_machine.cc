#include "token_machine.h"

using namespace umbc;

///////////////////////////////////////////////////////////////////
///
///                  THIS IS THE TOKEN MACHINE !
///
///////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////
/// TRIM FUNCTIONS

void tokenMachine::trimParens() {
  int offset = ptr-ns;
  if ((src[ns] == '(') && (src[end-1] == ')')) {
    // printf("parens mashed.\n");
    ns++;
    end--;
  }
  ptr=ns+offset;
}

void tokenMachine::trimBraces() {
  int offset = ptr-ns;
  if ((src[ns] == '{') && (src[end-1] == '}')) {
    // printf("parens mashed.\n");
    ns++;
    end--;
  }
  ptr=ns+offset;
}


void tokenMachine::trimBrackets() {
  int offset = ptr-ns;
  if ((src[ns] == '[') && (src[end-1] == ']')) {
    // printf("parens mashed.\n");
    ns++;
    end--;
  }
  ptr=ns+offset;
}

void tokenMachine::trimAngleBrackets() {
  int offset = ptr-ns;
  if ((src[ns] == '<') && (src[end-1] == '>')) {
    // printf("parens mashed.\n");
    ns++;
    end--;
  }
  ptr=ns+offset;
}

void tokenMachine::trimQuotes() {
  int offset = ptr-ns;
  if ((src[ns] == '\'') && (src[end-1] == '\'')) {
    // printf("parens mashed.\n");
    ns++;
    end--;
  }
  ptr=ns+offset;
}

void tokenMachine::trimDoubleQuotes() {
  int offset = ptr-ns;
  if ((src[ns] == '"') && (src[end-1] == '"')) {
    // printf("parens mashed.\n");
    ns++;
    end--;
  }
  ptr=ns+offset;
}

void tokenMachine::trimDelim(delimiterType dt) {
  switch (dt) {
  case DELIMITER_PARENS:
    trimParens(); break;
  case DELIMITER_BRACES:
    trimBraces(); break;
  case DELIMITER_BRACKETS: 
    trimBrackets(); break;
  case DELIMITER_ANGLE_BRACKETS:
    trimAngleBrackets(); break;
  case DELIMITER_QUOTES: 
    trimQuotes(); break;
  case DELIMITER_DOUBLE_QUOTES:
    trimDoubleQuotes(); break;
  }
}

void tokenMachine::trimWS() {
  // cout << "trimming ws(" << ns << "," << end << ")" << endl;
  // cout << "src[ns]=" << hex << (int)src[ns] << " src[end-1]=" << hex << (int)src[end] << endl;

  int offset = ptr-ns;
  while (!isgraph(src[ns]) && (ns < end)) {
    ns++;
    // cout << "(PRE)src[ns]=" << hex << (int)src[ns] << " src[end-1]=" << hex << (int)src[end-1] << endl;
  }

  while (!isgraph(src[end-1]) && (end > ns)) {
    end--;
    // cout << "(POS)src[ns]=" << hex << (int)src[ns] << " src[end-1]=" << hex << (int)src[end-1] << endl;
  }

  ptr=ns+offset;
  if (ptr > end) ptr=end;
  // cout << "trimming ws(" << ns << "," << end << "): '";
  // printWSource();
}

string tokenMachine::nextToken() {
  return textFunctions::readUntilWSEnhanced(src,ptr,end,&ptr);
}

string tokenMachine::rest() {
  return src.substr(ptr,end);
}

bool tokenMachine::moreTokens() {
  int q=-1;
  string j = textFunctions::readUntilWSEnhanced(src,ptr,end,&q);
  return (j.length() > 0);
}

bool tokenMachine::containsToken(string target) {
  int ptr_save=ptr;
  while (moreTokens()) {
    string j = nextToken();
    if (j == target) {
      ptr=ptr_save;
      return true;
    }
  }
  ptr=ptr_save;
  return false;
}

string tokenMachine::keywordValue(string keyword) {
  int ptr_save=ptr;
  while (moreTokens()) {
    string j = nextToken();
    if (j == keyword) {
      string rv;
      if (moreTokens())
	rv = nextToken();
      else 
	rv = "";
      ptr=ptr_save;
      return rv;
    }
  }
  ptr=ptr_save;
  return "";  
}

string tokenMachine::removeKWP(string keyword) {
  int ptr_save=ptr;
  string rv="";
  while (moreTokens()) {
    string j = nextToken();
    if (j == keyword) {
      if (moreTokens())
	nextToken();
    }
    else {
      rv+=j;
      if (moreTokens())
	rv+=" ";
    }
  }
  ptr=ptr_save;
  return rv;  
}

vector<string> tokenMachine::processAsStringVector(string q) {
  tokenMachine tm(q);
  tm.trimParens();
  bool running=true;
  vector<string> rv;
  while (running) {
    string nst = tm.nextToken();
    if (nst.size() > 0)
      rv.push_back(textFunctions::dequote(nst));
    else running=false;
  }
  return rv;
}

vector<double> tokenMachine::processAsDoubleVector(string q) {
  tokenMachine tm(q);
  tm.trimParens();
  bool running=true;
  vector<double> rv;
  while (running) {
    string nst = tm.nextToken();
    if (nst.size() > 0)
      rv.push_back(textFunctions::dubval(nst));
    else running=false;
  }
  return rv;
}

////////////////////////////////////////////////////////////////
// extension of the tokenMachine to do param list processing

string paramStringProcessor::getParam(int X) {
  int op = ptr;
  string rv="";
  reset();
  for (int k=0; ((k<=X) && moreTokens()); k++) {
    // cout << ".";
    if (k==X) rv=nextToken();
    else nextToken();
  }
  ptr=op;
  return rv;
}

///////////////////////////////////////////////////////////////////
///
///                  THIS IS THE KWP MACHINE !
///                 (keyword-parameter machine)
///////////////////////////////////////////////////////////////////

string keywordParamMachine::keyword_of(string token) {
  for (size_t i=0;i<token.size();i++) {
    if (token[i] == '=')
      return token.substr(0,i);
  }
  return token;
}

string keywordParamMachine::value_of(string token) {
  for (size_t i=token.size()-1;i>=0;i--) {
    if (token[i] == '=')
      return token.substr(i+1,token.size()-i);
  }
  return "";
}

string keywordParamMachine::getKWV(string kw) {
  int ptr_save=ptr;
  string rv="";
  while (moreTokens() && (rv.size()==0)) {
    string kwp = getNextKWP();
    // cout << "nkwp:=" << kwp << endl;
    if (keyword_of(kwp) == kw) {
      ptr=ptr_save;
      return value_of(kwp);
    }
  }
  ptr=ptr_save;
  return rv;
}
