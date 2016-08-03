import sys
import random
from settings import *

        # TODO:
        #   -Do some analysis to determine XP similarity. Have different delta metric sets for different XPs / types of XP
        #   -Do analysis over XP to determine which goals seem viable. Exclude non-viable goals, or give them smaller weight
        #   -Blame attribution extending beyond the previous action

# Maintains records of performance of past actions, and uses that to inform the selection of goals.
class HistAnalysis001:
    def __init__(self):
        self.goalset = {'apprehend': [], 'extinguish': []} # contains delta metric values for each goal
        self.previousmetricvalue = 0
        self.previousgoal = None
	self.verbose = -1

    def updatemetric(self, value):
        delta = self.previousmetricvalue - value
        self.previousmetricvalue = value
        if self.previousgoal:
            self.goalset[self.previousgoal].append(delta)

    # Determine which goals are entailed by the XP represented in frames
    def _getentailedgoals(self, frames):
        noem = {}   # Node Operator Effect Mapping
                    # Keys are node/frame names, values are lists of [operatorname, effect] pairs

        noem['CRIMINAL-VOLITIONAL-AGENT'] = [['apprehend', OPERATOR_EFFECT_NEGATION]]
        noem['BURNS'] = [['extinguish', OPERATOR_EFFECT_NEGATION]]
        noem['BURNING'] = [['extinguish', OPERATOR_EFFECT_NEGATION]]

        entailedgoals = []

        # Determine which goals are entailed by the XP represented in frames
        for frame in frames.values():
            name = frame.name
            for l in ['.','1','2','3','4','5','6','7','8','9']:
                name = name.replace(l,'')
            if name in noem.keys():
                action = noem[name][0][0]
                if not action in entailedgoals:
                    entailedgoals.append(action)

        return entailedgoals

    # Selects possible goal based on past history
    def goalgen(self, frames):
        entailedgoals = self._getentailedgoals(frames)
        if self.verbose >= 2:
	    print "Here are entailed goals:"
            for e in entailedgoals:
                print "    " + e

        # Select goal probabilistically in proportion to past successes.
        metrics = [0 for tv in range(len(entailedgoals))]
        for i in range(len(entailedgoals)):
            pastdeltas = self.goalset[entailedgoals[i]]
            if len(pastdeltas) == 0:
                metrics[i] = 1
            else:
                metrics[i] = (1.0 * sum(pastdeltas)) / len(pastdeltas)

        # translate above 0
        if min(metrics) < 1:
            val = abs(min(metrics))
            for i in range(len(metrics)):
                metrics[i] += val + 1

        # select probabilistically
        rand = random.random()
        index = 0
        s = 0.0
        while index < len(metrics):
            s += metrics[index]
            if rand < s / sum(metrics):
                break
            index += 1

        return entailedgoals[i]


