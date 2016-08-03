
class Goal:
    GOAL_ON = 0
    GOAL_EXTINGUISH = 1

    def __init__(self, goaltype, goalargs=[]):
        self.goaltype = goaltype
        self.goalargs = goalargs

    # returns a string representation of the goal suitable as input to FOIL
    def foilme(self):
        if self.goaltype == Goal.GOAL_ON:
            return self.goalargs[0].blockid + "," + self.goalargs[1].blockid
        elif self.goaltype == Goal.GOAL_EXTINGUISH:
            return self.goalargs[0].blockid
        else:
            raise Exception("Unrecognized goal type")
