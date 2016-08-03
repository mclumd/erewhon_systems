from block import Block
from Goal import Goal

# Take block set, give goal.
class GoalGen:
    def __init__(self):
        pass

    def makeshop2pfile(self, blockset, filename):
        f = open(filename, 'w')

        goal = self.givegoal(blockset)

        assert goal != None
        assert goal.goaltype == Goal.GOAL_ON

        f.write(";;-------------------------------\n")
        f.write("(in-package :shop2)\n")
        f.write(";;---------------------------------------------\n")
        f.write("\n")
        f.write("(defproblem p_some_problem blocks-htn\n")
        f.write("(\n")
        f.write("    (arm-empty)\n")

        for block in blockset:
            if block.blocktype != Block.TABLE:
                f.write("    (block b" + str(block.blockid) + ")\n")

        for block in blockset:
            if block.blocktype != Block.TABLE:
                if block.blockon == None:
                    pass
                elif block.blockon.blocktype == Block.TABLE:
                    f.write("    (on-table b" + str(block.blockid) + ")\n")
                else:
                    f.write("    (on b" + str(block.blockid) + " b" + str(block.blockon.blockid) + ")\n")

                if block.isclear:
                    f.write("    (clear b" + str(block.blockid) + ")\n")
            if not block.isonfire:
                    f.write("    (notonfire " + str(block.blockid) + ")\n")

        f.write(")\n")
        f.write("(;Goal Task Network\n")
        f.write("    (achieve-goals (\n")
        f.write("        (arm-empty)\n")        # added 2013_05_17
        f.write("        (on b" + str(goal.goalargs[0].blockid) + " b" + str(goal.goalargs[1].blockid) + ")\n")
        for block in blockset:
            if block.isonfire:
                f.write("        (notonfire " + str(block.blockid) + ")\n")
        f.write(")));End of goal task network\n")
        f.write(")\n")
        f.close()

    def givegoal(self, blockset):
        pass


