import random

from utils.block import Block
from Internal_Node import InternalNode

#    Compact notation of tree:
#    
#    onfire(-A) ? 
#    +--yes: notcampfire(A) ? 
#    |       +--yes: [scen_001] 200.0 [[scen_001:200.0,scen_002:0.0,scen_003:0.0]]
#    |       +--no:  [scen_002] 200.0 [[scen_001:0.0,scen_002:200.0,scen_003:0.0]]
#    +--no:  [scen_003] 200.0 [[scen_001:0.0,scen_002:0.0,scen_003:200.0]]
#    
#    Equivalent prolog program:
#    
#    class([scen_001]) :- onfire(A),notcampfire(A), !.
#    % 200.0/200.0=1.0
#    class([scen_002]) :- onfire(A), !.
#    % 200.0/200.0=1.0
#    class([scen_003]).
#    % 200.0/200.0=1.0


class InternalNode1(InternalNode):

    # returns a goal, if one can be found
    def evaluate(self, blockset):
        groundings = self.ground(blockset)

        if groundings == {}:
            return self.childno.evaluate(blockset)
        else:
            return self.childyes.evaluate(blockset)

    # Returns groundings for A, B, if they exist, that satisfy 
    # clear(-A),on(A,-B),table(B), where blocks can optionally
    # be given groundings in the groundings parameter.
    def ground(self, blockset, groundings={}):

        for a in range(1 if 'A' in groundings else len(blockset)):
            A = groundings['A'] if 'A' in groundings else blockset[a]

            if not A.onfire:
                continue
            else:
                return {'A':A}

        return {}

