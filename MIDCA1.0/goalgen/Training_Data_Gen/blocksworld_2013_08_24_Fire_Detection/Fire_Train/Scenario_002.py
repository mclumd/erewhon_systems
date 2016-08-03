import sys
sys.path.append("..")
import random
from Scenario import Scenario
from ProbGen import ProbGen
from Goal import Goal

# see README
class Scenario002(Scenario):

    def genex(self, tag):
        [p, posgoals, neggoals] = self.genex_posneg(tag)

        # Generate example
        ex = p.give_ex(scenarioname="scen_002")
        ex.posgoals = posgoals
        ex.neggoals = neggoals

        return ex

    def genex_posneg(self, tag):

        p = ProbGen(tag)

        # retrieve table
        table = p.table

        # make single tower
        tower = p.squaretower(random.choice([2,3]))

        # make single triangle on ground
        triangle = p.groundtriangles(1)[0]

        # make single square on ground
        square = p.groundsquares(1)[0]

        # collect blocks
        blocks = [table, triangle, square] + tower

        # no positive goal
        posgoals = []

        # generate a few negative goals
        neggoals = []

        for i in range(len(blocks)):
            neggoals.append(Goal(Goal.GOAL_EXTINGUISH, [blocks[i]]))

        return [p, posgoals, neggoals]
