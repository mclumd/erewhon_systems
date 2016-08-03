from Leaf import Leaf
import random

from Goal_Gen.block import Block
from Goal_Gen.Goal import Goal

class Leaf3(Leaf):

    # Returns True if the given blockset satisfies the rule associated with scenario 3
    # goal(A,B) :- clear(B), square(B), triangle(A).
    def evaluate(self, blockset):

        print "In leaf3"

        # iterate me, over all groundings of variables, if one is found, break, if not, rule not satisfied
        for a in range(len(blockset)):
            for b in range(len(blockset)):
                clearB = blockset[b].isclear
                squareB = blockset[b].blocktype == Block.SQUARE
                triangleA = blockset[a].blocktype == Block.TRIANGLE

                if clearB and squareB and triangleA:
                    return Goal(Goal.GOAL_ON, [blockset[a], blockset[b]])

#        print "blockset"
#        print blockset

#        for block in blockset:
#            print block.isclear

        return None



