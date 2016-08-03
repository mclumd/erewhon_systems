import os
import sys
sys.path.append("../Goal_Gen")
sys.path.append("../Goal_Gen/Goal_Gen_2013_03_30")
from Block import Block
from Goal_Gen_2013_03_30 import GoalGen20130330

alispcmd = "/usr/local/allegrocommonlisp-8.2/alisp -#! ../../SHOP_2_7/GDP/trunk/shop2-load.lisp "
problemfile = "problemfile.lisp"
outputfile = "shop2_output"
domainfile = "../SHOP_2_7/GDP/trunk/blocks-htn.lisp"

def createstartstate():
    table = Block(Block.TABLE, 1)
    
    # make height 2 tower topped by triangle
    t1 = Block(Block.SQUARE, 2)
    t2 = Block(Block.SQUARE, 3)
    t3 = Block(Block.TRIANGLE, 4)

    # place single square on table
    t4 = Block(Block.SQUARE, 5)

    t1.place(table)
    t2.place(t1)
    t3.place(t2)
    t4.place(table)

    return [table, t1, t2, t3, t4]

def main():
    simtogenblockset = createstartstate()
    gg = GoalGen20130330()

    while True:
        # make problem file
        gg.makeshop2pfile(simtogenblockset, problemfile)
        os.system(alispcmd + domainfile + ' ' + problemfile + ' ' + outputfile)

        # take output, feed to world sim
        pass

        # take world sim output, place into simtogenblockset
        pass

        raw_input("Press enter to continue...")

if __name__ == "__main__":
    main()