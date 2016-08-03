import sys
sys.path.append("../")
from utils.block import Block
from goalgen.goal import Goal
from Tree_Fire.Tree import Tree as TreeFire

import socket
#host = 'localhost'
#port = 5155
size = 100000

class FireGoalGen:
    def __init__(self):
        self.counter = 0

    def give_goal(self, blockset, s):
#        tree = TreeFire()
#        return tree.givegoal(blockset)
        self.counter += 1
        if self.counter <= 1:
            return

        print "In gengoal_fire.py"

        if s:
            data = s.recv(size)
            print "This was given by Meta-AQUA: ", data

            pos1 = data.find("(BURNING (DOMAIN (VALUE ")
            pos2 = data.find("APPREHEND")
            if pos1 != -1:
                blockname = data[pos1+24:pos1+26]
                print "The block to extinguish is: " + blockname
                block = None
                for b in blockset:
                    if b.id == blockname:
                        block = b
                        break

                if block:
                    return Goal(Goal.GOAL_NO_FIRE, [block])
                else:
                    print "No such block!!!"
            elif pos2 != -1:
                return Goal(Goal.GOAL_APPREHEND, ["Gui Montag"])



