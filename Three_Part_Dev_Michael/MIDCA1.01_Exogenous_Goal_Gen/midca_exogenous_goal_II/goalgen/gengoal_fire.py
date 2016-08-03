import sys
sys.path.append("../")
from utils.block import Block
from Tree_Fire.Tree import Tree as TreeFire
import goal

import socket
#host = 'localhost'
#port = 5155
size = 100000

class FireGoalGen:
    def __init__(self):
        self.counter = 0

    def give_goal(self, blockset, s):
        return

#        tree = TreeFire()
#        return tree.givegoal(blockset)
        self.counter += 1
        if self.counter <= 1:
            return

        print "In gengoal_fire.py"

        if s:
        	data = s.recv(size)
        	print "This was given by Meta-AQUA: ", data

