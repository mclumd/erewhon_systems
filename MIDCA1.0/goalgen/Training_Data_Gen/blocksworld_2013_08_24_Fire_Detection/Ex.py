from Block import Block

class Ex:
    def __init__(self, scenarioname="None", blocks=[], posgoals=[], neggoals=[]):
        self.scenarioname = scenarioname
        self.blocks = blocks
        self.posgoals = posgoals
        self.neggoals = neggoals

    # Returns [scenName, on, clear, triangle, square, table]
    # where each element is a string representatino suitable for Tilde input
    def tildeme(self):
        [scenName, on , clear, triangle, square, table, onfire] = ["", "", "", "", "", "", ""]

        scenName = self.scenarioname + ".\n"

        # Make on, clear, triangle, square, table
        for block in self.blocks:
            if block.blockon != None:
                on += "on(o" + block.blockid + ",o" + block.blockon.blockid + ").\n"

            if block.clear:
                clear += "clear(o" + block.blockid + ").\n"

            if block.blocktype == Block.TRIANGLE:
                triangle += "triangle(o" + block.blockid + ").\n"

            if block.blocktype == Block.SQUARE:
                square += "square(o" + block.blockid + ").\n"

            if block.blocktype == Block.TABLE:
                table += "table(o" + block.blockid + ").\n"

            if block.isonfire:
                onfire += "onfire(o" + block.blockid + ").\n"

        return [scenName, on , clear, triangle, square, table, onfire]

    # Returns [posGoals, negGoals, on, clear, triangle, square, table, constants, defTests]
    # where each element is a string representation suitable for FOIL input
    def foilme(self):
        [posGoals, negGoals, on, clear, triangle, square, table, onfire, constants, defTests] = ["","","","","","","","","",""]

        # Make posGoal, defTests
        for goal in self.posgoals:
            posGoals += goal.foilme() + "\n"
            defTests += goal.foilme() + ": +\n"

        # Make negGoal, defTest
        for goal in self.neggoals:
            negGoals += goal.foilme() + "\n"
            defTests += goal.foilme() + ": -\n"

        # Make on, clear, triangle, square, constants
        for block in self.blocks:
            if block.blockon != None:
                on += block.blockid + "," + block.blockon.blockid + "\n"

            if block.clear:
                clear += block.blockid + "\n"

            if block.blocktype == Block.TRIANGLE:
                triangle += block.blockid + "\n"

            if block.blocktype == Block.SQUARE:
                square += block.blockid + "\n"

            if block.blocktype == Block.TABLE:
                table += block.blockid + "\n"

            if block.isonfire:
                onfire += block.blockid + "\n"

            constants += block.blockid + ","

        return [posGoals, negGoals, on, clear, triangle, square, table, onfire, constants, defTests]

    # Returns string of blocks
    def tostring(self):
        toreturn = ""
        for block in self.blocks:
            toreturn += block.tostring() + "\n"
        return toreturn

