#include <iostream>
#include "token_machine.h"

using namespace std;
using namespace umbc;

int main(int argc, char** argv) {
  string mclex = "ok([response(typ=suggestion,ref=0x00000001,code=crc_sensor_diag,action=true,abort=true,text=\"MCL response = (15,runSensorDiagnostic,crc_sensor_diag)\")])";
  cout << "MCLS=" << mclex << endl;
  cout << "MCLF=" << textFunctions::getFunctor(mclex) << endl;
  cout << "MCLP=" << textFunctions::getParameters(mclex) << endl;
  string gp = textFunctions::getParameters(mclex);
  string tgp = textFunctions::trimParens(gp);
  listStringProcessor lstr(tgp,tokenMachine::DELIMITER_BRACKETS);
  lstr.printWSource();
  cout << " LOOP OVER ITEMS..." << endl;
  while (lstr.hasMoreItems()) {
    string ri = lstr.getNextItem();
    keywordParamMachine rikwpm(textFunctions::getParameters(ri),tokenMachine::DELIMITER_PARENS);
    // rikwpm.trimParens();
    rikwpm.printSource();
    rikwpm.printWSource();
  }

  return 0;
}
