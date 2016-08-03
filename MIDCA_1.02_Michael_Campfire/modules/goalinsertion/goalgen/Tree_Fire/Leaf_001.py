from Leaf import Leaf
import random

from utils.block import Block
from modules.goalinsertion.goalgen.goal import Goal

class Leaf1(Leaf):

    # Returns a Goal if the given blockset satisfies the rule associated with scenario 1
    # goal(A) :- onfire(A), notcampfire(A).
    def evaluate(self, blockset):

        print "BBBBLLLLLLLLLLLLLLLLLLLLAAAAAAAAAAAAAAAAAAARRRRRRRRRRRRRGGGGGGGGGGGGGGHHHHHHHHHHHHHH!!!!!!!!!!!: scen_1"

        # iterate me, over all groundings of variables, if one is found, break, if not, rule not satisfied
        for a in range(len(blockset)):
            onfireA = blockset[a].onfire
            notcampfireA = blockset[a].notcampfire
            if onfireA and notcampfireA:
                return Goal(Goal.GOAL_NO_FIRE, [blockset[a]])

        return None
