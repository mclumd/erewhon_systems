from Leaf import Leaf
import random

from utils.block import Block
from goalgen.goal import Goal

class Leaf1(Leaf):

    # Returns True if the given blockset satisfies the rule associated with scenario 1
    # goal(A,B) :- on(A,C), on(B,D), on(C,B), not(goal(_1,C)).
    def evaluate(self, blockset):
        # iterate me, over all groundings of variables, if one is found, break, if not, rule not satisfied
        for a in range(len(blockset)):
            for b in range(len(blockset)):
                for c in range(len(blockset)):
                    for d in range(len(blockset)):
                        onAC = blockset[a].on == blockset[c]
                        onBD = blockset[b].on == blockset[d]
                        onCB = blockset[c].on == blockset[b]

                        if onAC and onBD and onCB:
                            return Goal(Goal.GOAL_ON, [blockset[a],blockset[b]])

        return None
