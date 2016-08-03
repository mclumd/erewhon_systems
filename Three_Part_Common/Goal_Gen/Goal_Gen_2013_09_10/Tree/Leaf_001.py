from Leaf import Leaf
import random

from Goal_Gen.block import Block
from Goal_Gen.Goal import Goal

class Leaf1(Leaf):

    # Returns True if the given blockset satisfies the rule associated with scenario 1
    # goal(A,B) :- on(A,C), on(B,D), on(C,B), not(goal(_1,C)).
    def evaluate(self, blockset):
        # iterate me, over all groundings of variables, if one is found, break, if not, rule not satisfied
        for a in range(len(blockset)):
            for b in range(len(blockset)):
                for c in range(len(blockset)):
                    for d in range(len(blockset)):
                        onAC = blockset[a].blockon == blockset[c]
                        onBD = blockset[b].blockon == blockset[d]
                        onCB = blockset[c].blockon == blockset[b]

                        if onAC and onBD and onCB:
                            return Goal(Goal.GOAL_ON, [blockset[a],blockset[b]])

        return None
