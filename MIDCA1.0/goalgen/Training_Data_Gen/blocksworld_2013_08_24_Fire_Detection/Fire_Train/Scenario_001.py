import sys
sys.path.append("..")
import random
from Scenario import Scenario
from ProbGen import ProbGen
from Goal import Goal

# see README
class Scenario001(Scenario):

    def genex(self, tag):
        [p, posgoals, neggoals] = self.genex_posneg(tag)

        # Generate example
        ex = p.give_ex(scenarioname="scen_001")
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
        onfire = random.choice(range(len(blocks)))
        blocks[onfire].isonfire = True

        # positive goal: extinguish block on fire
        posgoals = [Goal(Goal.GOAL_EXTINGUISH, [blocks[onfire]]) for tv in range(len(blocks)-1)]

        # generate a few negative goals
        neggoals = []

        for i in range(len(blocks)):
            if i != onfire:
                neggoals.append(Goal(Goal.GOAL_EXTINGUISH, [blocks[i]]))

        return [p, posgoals, neggoals]

