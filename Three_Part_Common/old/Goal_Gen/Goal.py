
class Goal:
    GOAL_ON = 0

    def __init__(self, goaltype, goalargs=[]):
        self.goaltype = goaltype
        self.goalargs = goalargs

    # returns a string representation of the goal suitable as input to FOIL
    def foilme(self):
        if self.goaltype == Goal.GOAL_ON:
            return self.goalargs[0].getname() + "," + self.goalargs[1].getname()
        else:
            raise Exception("Unrecognized goal type")
