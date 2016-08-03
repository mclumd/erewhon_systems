
class Goal:
    GOAL_ON = "on"
    GOAL_NO_FIRE = "notonfire"
    GOAL_APPREHEND = "apprehend"
    
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
    		s += str(arg) + " "
    	if self.goalargs:
    		return s[:-1] + ")"
    	else:
    		return s + ")"
