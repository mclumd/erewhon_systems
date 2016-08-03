from Leaf import Leaf
import random

from utils.block import Block
from goalgen.goal import Goal

class Leaf2(Leaf):

    # Returns True if the given blockset satisfies the rule associated with scenario 2
    # goal(A,B) :- on(A,C), on(B,D), on(D,C), A<>D.
    def evaluate(self, blockset):

        print "IN LEAF 2"

        # iterate me, over all groundings of variables, if one is found, break, if not, rule not satisfied
        for a in range(len(blockset)):
            for b in range(len(blockset)):
                for c in range(len(blockset)):
                    for d in range(len(blockset)):
                        onAC = blockset[a].on == blockset[c]
                        onBD = blockset[b].on == blockset[d]
                        onDC = blockset[d].on == blockset[c]
                        AnotD = blockset[a] != blockset[d]

                        if onAC and onBD and onDC and AnotD:
                            return Goal(Goal.GOAL_ON, [blockset[a], blockset[b]])

        return None