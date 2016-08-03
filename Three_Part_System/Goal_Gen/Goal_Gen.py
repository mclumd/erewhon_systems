from Block import Block
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
                if block.on == None:
                    pass
                elif block.on.blocktype == Block.TABLE:
                    f.write("    (on-table b" + str(block.blockid) + ")\n")
                else:
                    f.write("    (on b" + str(block.blockid) + " b" + str(block.on.blockid) + ")\n")

                if block.clear:
                    f.write("    (clear b" + str(block.blockid) + ")\n")

        f.write(")\n")
        f.write("(;Goal Task Network\n")
        f.write("    (achieve-goals (\n")
        f.write("(on b" + str(goal.goalargs[0].blockid) + " b" + str(goal.goalargs[1].blockid) + ")\n")
        f.write(")));End of goal task network\n")
        f.write(")\n")
        f.close()

    def givegoal(self, blockset):
        pass


