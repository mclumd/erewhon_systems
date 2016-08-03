import os
from Scenario_001 import Scenario001
from Scenario_002 import Scenario002

def main():
    # Make input files for FOIL

    print "generating files..."

    s1 = Scenario001(2)
    s2 = Scenario002(2)

    s1.genexs(tagstub=1)
    s2.genexs(tagstub=2)

    try:
        os.remove("data/TildeTrain.kb")
    except:
        pass

#    s1.tofileTildeStyle("data/TildeTrain.kb", modelstartcount = 0)
#    s2.tofileTildeStyle("data/TildeTrain.kb", modelstartcount = 2)

    s1.tofile("data/Scen_001.d")
    s2.tofile("data/Scen_002.d")

if __name__ == "__main__":
    main()



