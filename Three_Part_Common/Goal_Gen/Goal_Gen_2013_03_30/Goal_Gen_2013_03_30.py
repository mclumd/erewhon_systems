import sys
sys.path.append("..")
from Goal_Gen.block import Block
from Goal_Gen.Goal import Goal
from Goal_Gen.Goal_Gen import GoalGen

# Scenario_001 -> Scenario_002 -> Scenario_003 -> Scenario_001
# 
# Scenario_001: 3 stacked squares, topped by triangle
# Scenario_002: 2 stacked squares, topped by triangle, square on ground
# Scenario_003: 3 stacked squares, triangle on ground
# 
# Scenario_001 goal: triangle on second square
# Scenario_002 goal: ground square on second square
# Scenario_003 goal: triangle on top square

class GoalGen20130330(GoalGen):

    def givegoal(self, blockset):
        prediction = self._classify(blockset)

        if prediction == 1:
            return self._evaluate_scen_001(blockset)
        elif prediction == 2:
            return self._evaluate_scen_002(blockset)
        else:
            return self._evaluate_scen_003(blockset)

    # Returns True if the given blockset satisfies the rule associated with scenario 1
    # goal(A,B) :- on(A,C), on(B,D), on(C,B), not(goal(_1,C)).
    def _evaluate_scen_001(self, blockset):
        # iterate me, over all groundings of variables, if one is found, break, if not, rule not satisfied
        for a in range(len(blockset)):
            for b in range(len(blockset)):
                for c in range(len(blockset)):
                    for d in range(len(blockset)):
                        onAC = blockset[a].blockon == blockset[c]
                        onBD = blockset[b].blockon == blockset[d]
                        onCB = blockset[c].blockon == blockset[b]

                        if onAC and onBD and onCB:
                            return Goal(Goal.GOAL_ON, [blockset[a],blockset[b]])

        return None

    # Returns True if the given blockset satisfies the rule associated with scenario 2
    # goal(A,B) :- on(A,C), on(B,D), on(D,C), A<>D.
    def _evaluate_scen_002(self, blockset):
        # iterate me, over all groundings of variables, if one is found, break, if not, rule not satisfied
        for a in range(len(blockset)):
            for b in range(len(blockset)):
                for c in range(len(blockset)):
                    for d in range(len(blockset)):
                        onAC = blockset[a].blockon == blockset[c]
                        onBD = blockset[b].blockon == blockset[d]
                        onDC = blockset[d].blockon == blockset[c]
                        AnotD = blockset[a] != blockset[d]

                        if onAC and onBD and onDC and AnotD:
                            return Goal(Goal.GOAL_ON, [blockset[a], blockset[b]])

        return None

    # Returns True if the given blockset satisfies the rule associated with scenario 3
    # goal(A,B) :- clear(B), square(B), triangle(A).
    def _evaluate_scen_003(self, blockset):
        # iterate me, over all groundings of variables, if one is found, break, if not, rule not satisfied
        for a in range(len(blockset)):
            for b in range(len(blockset)):
                clearB = blockset[b].isclear
                squareB = blockset[b].blocktype == Block.SQUARE
                triangleA = blockset[a].blocktype == Block.TRIANGLE

                if clearB and squareB and triangleA:
                    return Goal(Goal.GOAL_ON, [blockset[a], blockset[b]])

        return None

    # classifies the given blockset into one of three scenario types
    def _classify(self, blockset):
        prediction = 0

        # 1 ----
        # class([scen_003]) :- clear(A),on(A,B),table(B),triangle(A), !.
        # Order of precedence:
        #   -triangle(A)            # A
        #   -clear(A)               # A
        #   -on(A,B)                # B
        #   -table(B)               # B

        for a in range(len(blockset)):
            A = blockset[a]
            if not (A.blocktype == Block.TRIANGLE and A.isclear):                         # triangle(A) and clear(A)
                continue

            for b in range(len(blockset)):
                B = blockset[b]
                if not (A.blockon == B and B.blocktype == Block.TABLE):                      # on(A,B) and table(B)
                    continue
                else:
                    prediction = 3
                    return prediction

        # 2 ----
        # class([scen_002]) :- clear(A),on(A,B),table(B), !.
        # Order of precedence:
        #   -clear(A)               # A
        #   -on(A,B)                # B
        #   -table(B)               # B


        for a in range(len(blockset)):
            A = blockset[a]
            if not (A.isclear):                                                           # clear(A)
                continue

            for b in range(len(blockset)):
                B = blockset[b]
                if not (A.blockon == B and B.blocktype == Block.TABLE):                      # on(A,B) and table(B)
                    continue
                else:
                    prediction = 2
                    return prediction

        # 3 ----
        # class([scen_001]).
        if prediction == 0:
            prediction = 1

        return prediction

