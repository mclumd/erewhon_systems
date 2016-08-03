import time
import sys
sys.path.append("../")
from utils.block import Block
from goalgen.goal import Goal

from Tree_Fire.Tree import Tree as TreeFire

from XP_Goal.parser import *
from XP_Goal.traverser import *
from XP_Goal.histanalysis1 import *

import socket
size = 2000000000

class FireGoalGen:
    def __init__(self):
        self.counter = 0
        self.apprehended = False
        self.histanalysis = HistAnalysis001()

    def give_goal(self, blockset, s):
        self.counter += 1
        if self.counter <= 1:
            return

        print "In gengoal_fire.py"

        if s:
            time.sleep(.2)           # change this, do sockets properly, waiting for Meta-AQUA to send everything.            
            text = s.recv(size)

            f = open("tmp", "w")
            f.write(text)
            f.close()

            if text != "None\n" and text != "" and text != None:
#                print "HERE IS TEXT: " + text

                # parse text
                p = Parser()
                frames = p.makeframegraph(text)

                self.histanalysis.updatemetric(1)
                goalname = self.histanalysis.goalgen(frames)

                if goalname == 'apprehend':
                    self.apprehended = True
                    return Goal(Goal.GOAL_APPREHEND, ["Gui Montag"])
                elif goalname == 'extinguish':
                    for block in blockset:
                        if block.onfire:
                            return Goal(Goal.GOAL_NO_FIRE, [block])
                else:
                    print "Uncrecognized goal name(!): " + goalname
                    sys.exit(1)










#                # create mapping
#                noem = {}   # Node Operator Effect Mapping
#                            # Keys are node/frame names, values are lists of [operatorname, effect] pairs
#
#                noem['CRIMINAL-VOLITIONAL-AGENT'] = [['apprehend', OPERATOR_EFFECT_NEGATION]]
#
#                # Traverse
#                t = Traverser(frames, noem)
#                (frame, operator, effect) = t.traverse()
#
#                if operator == "apprehend" and self.apprehended:
#                    print "Already apprehened arsonist, now producing standard extinguish goal."
#                    for block in blockset:
#                        if block.onfire:
#                            return Goal(Goal.GOAL_NO_FIRE, [block])
#                elif operator == "apprehend" and not self.apprehended:
#                    self.apprehended = True
#                    return Goal(Goal.GOAL_APPREHEND, ["Gui Montag"])
#                else:
#                    print "Unrecognized operator(!): " + str(operator) + ", now producing standard extinguish goal."
#                    for block in blockset:
#                        if block.onfire:
#                            return Goal(Goal.GOAL_NO_FIRE, [block])
#            else:
#                print "Nothing sent by Meta-AQUA, attempting to generate extinguish goal..."
#                for block in blockset:
#                    if block.onfire:
#                        return Goal(Goal.GOAL_NO_FIRE, [block])
