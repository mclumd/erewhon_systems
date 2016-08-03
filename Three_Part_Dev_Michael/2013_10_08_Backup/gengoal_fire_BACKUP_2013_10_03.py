import sys
sys.path.append("../")
from utils.block import Block
from Tree_Fire.Tree import Tree as TreeFire
import goal

class FireGoalGen:

    def give_goal(self, blockset):
        tree = TreeFire()
        return tree.givegoal(blockset)

