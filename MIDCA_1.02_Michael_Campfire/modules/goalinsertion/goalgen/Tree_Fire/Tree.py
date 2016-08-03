from Leaf_001 import Leaf1
from Leaf_002 import Leaf2
from Leaf_003 import Leaf3
from Internal_Node_001 import InternalNode1
from Internal_Node_002 import InternalNode2

#   Compact notation of tree:
#   
#   onfire(-A) ? 
#   +--yes: notcampfire(A) ? 
#   |       +--yes: [scen_001] 200.0 [[scen_001:200.0,scen_002:0.0,scen_003:0.0]]
#   |       +--no:  [scen_002] 200.0 [[scen_001:0.0,scen_002:200.0,scen_003:0.0]]
#   +--no:  [scen_003] 200.0 [[scen_001:0.0,scen_002:0.0,scen_003:200.0]]

class Tree():
    def __init__(self):
        self.leaf1 = Leaf1()
        self.leaf2 = Leaf2()
        self.leaf3 = Leaf3()

        self.internal2 = InternalNode2(None, self.leaf1, self.leaf2)
        self.internal1 = InternalNode1(None, self.internal2, self.leaf3)
        self.internal2.parent = self.internal1

    def givegoal(self, blockset):
        print "BBBLLLAAAAAAAAAAAAAAARRRRRRRRGGGGGGGGGGGGGHHHHHHHHHHH!!!!!!!: tree"
        return self.internal1.evaluate(blockset)
