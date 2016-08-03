#include <iostream>
#include "text_utils.h"
#include "token_machine.h"
#include "file_utils.h"

using namespace std;
using namespace umbc;

bool testPLE(char inp,string protect,string o,string c,bool* e,string targ) {
  string r = textFunctions::adjustProtectLevelEnhanced(inp,protect,o,c,e);
  if (r != targ) {
    cerr << "Fail: protect=" << protect << " input=" << inp << " target="
    	 << targ << " value=" << r << endl;
    return true;
  }
  else {
    cerr << "OK: protect=" << protect << " input=" << inp << " target="
    	 << targ << " value=" << r << endl;    
    return false;
  }
}

int main(int argc, char** argv) {
  string os = "\"([{";
  string cs = "\")]}";
  bool e=true;
  if (testPLE('\"',"[\"",os,cs,&e,"[")) {};
  if (testPLE('(',"(",os,cs,&e,"(")) {};
  string ts = "f(token=\"number one\") c[token 2]";
  int p = 0;
  cout << "t1= '" << textFunctions::readUntilWSEnhanced(ts,p,ts.size(),&p)
       << "'" << endl;
  cout << "t1= '" << textFunctions::readUntilWSEnhanced(ts,p,ts.size(),&p)
       << "'" << endl;
  
  string mclex = "ok([response(typ=suggestion,ref=0x00000001,code=crc_sensor_diag,action=true,abort=true,text=\"MCL response = (15,runSensorDiagnostic,crc_sensor_diag)\")])";

  cout << "source=" << mclex << endl;
  cout << "Param=" << textFunctions::getParameters(mclex) << endl;
  cout << "trimP=" << textFunctions::trimParens(textFunctions::getParameters(mclex)) << endl;

  return 0;

}
