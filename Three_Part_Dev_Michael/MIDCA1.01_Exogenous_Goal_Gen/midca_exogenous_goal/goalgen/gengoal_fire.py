import sys
sys.path.append("../")
from utils.block import Block

GOAL_ON = "on"
GOAL_NO_FIRE = "notonfire"

class Goal:
    
    def __init__(self, goaltype, goalargs=[]):
        self.goaltype = goaltype
        self.goalargs = goalargs

    # returns a string representation of the goal suitable as input to FOIL
    def foil_str(self):
        s = "(" + self.goaltype
        for arg in self.goalargs:
        	s += " " + arg.id
        return s + ")"
    
    def __str__(self):
    	s = self.goaltype + "("
    	for arg in self.goalargs:
    		s += arg.id + " "
    	if self.goalargs:
    		return s[:-1] + ")"
    	else:
    		return s + ")"

# Scenario_001 - no fire
# Scenario_002 - fire

class FireGoalGen:

    def give_goal(self, blockset):
        prediction = self._classify(blockset)
        #print "scenario:", prediction
        if prediction == 1:
            return self._evaluate_scen_001(blockset)
        else:
            return self._evaluate_scen_002(blockset)

    # Returns True if the given blockset satisfies the rule associated with scenario 1
    # goal(A) :- onfire(A).
    def _evaluate_scen_001(self, blockset):
        # iterate me, over all groundings of variables, if one is found, break, if not, rule not satisfied
        for a in range(len(blockset)):
            onfireA = blockset[a].onfire
            if onfireA:
                return Goal(GOAL_NO_FIRE, [blockset[a]])

        return None

    # Returns True if the given blockset satisfies the rule associated with scenario 2
    # <No rule>
    def _evaluate_scen_002(self, blockset):
        return None

    # classifies the given blockset into one of three scenario types
    def _classify(self, blockset):
        prediction = 0

        # class([scen_001]) :- onfire(A), !.
        # % 2.0/2.0=1.0
        # class([scen_002]).
        # % 2.0/2.0=1.0


        # 1 ----
        # class([scen_001]) :- onfire(A), !.
        # Order of precedence:
        #   -onfire(A)              # A

        for a in range(len(blockset)):
            A = blockset[a]
            if not A.onfire:
                continue
            else:
                prediction = 1
                return prediction

        # 2 ----
        # class([scen_002]).
        if prediction == 0:
            prediction = 1

        return prediction

