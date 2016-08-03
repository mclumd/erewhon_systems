import random
from ProbGen import ProbGen
from Goal import Goal

# Place triangle onto open tower. All open towers of height 4+
class Scenario:
    def __init__(self, excount=10000, delimiter="0987890"):
        self.examples = []
        self.excount = excount
        self.delimiter = delimiter

    def genex(self, tag):
        pass # to be implemented by subclass

    def genexs(self, tagstub):
        for i in range(self.excount):
            # add a new example
            self.examples.append(self.genex(str(tagstub) + self.delimiter + str(i) + self.delimiter))

    # Writes output to a file formatted to be input to FOIL
    def tofile(self, filename):
        v = ["","","","","","","","","",""] # [posGoals, negGoals, on, clear, triangle, square, table, onfire, constants, defTests]
        for ex in self.examples:
            self.vectoradd(v, ex.foilme())

        towrite = "X: " + v[8][:-1] + ".\n\n"
#        towrite += "goal(X,X)\n"                   # for goal of on
        towrite += "goal(X)\n"                      # for goal of extinguish
        towrite += v[0] + ";\n"
        towrite += v[1] + ".\n"
        towrite += "*on(X,X)\n" + v[2] + ".\n"
        towrite += "*clear(X)\n" + v[3] + ".\n"
        towrite += "*triangle(X)\n" + v[4] + ".\n"
        towrite += "*square(X)\n" + v[5] + ".\n"
        towrite += "*table(X)\n" + v[6] + ".\n"
        towrite += "*onfire(X)\n" + v[7] + ".\n"
        towrite += "\ngoal\n" + v[9] + ".\n"

        f = open(filename, "w")
        f.write(towrite)
        f.close()

    def tofileTildeStyle(self, filename, modelstartcount=0):

        f = open(filename, "a")

        for i in range(len(self.examples)):
            f.write("begin(model(" + str(i + modelstartcount) + ")).\n")
            [scenName, on, clear, triangle, square, table, onfire] = self.examples[i].tildeme()
            f.write(scenName + on + clear + triangle + square + table + onfire)
            f.write("end(model(" + str(i + modelstartcount) + ")).\n\n")

        f.close()

    # v1 = v1 + v2 component-wise
    def vectoradd(self, v1, v2):
        assert len(v1) == len(v2)
        for i in range(len(v1)):
            v1[i] += v2[i]


