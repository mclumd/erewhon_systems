import sys
sys.path.append("../")
from utils.block import Block
from Tree_3_Scen.Tree import Tree as TreeScen
import goal

# Scenario_001 -> Scenario_002 -> Scenario_003 -> Scenario_001
# 
# Scenario_001: 3 stacked squares, topped by triangle
# Scenario_002: 2 stacked squares, topped by triangle, square on ground
# Scenario_003: 3 stacked squares, triangle on ground
# 
# Scenario_001 goal: triangle on second square
# Scenario_002 goal: ground square on second square
# Scenario_003 goal: triangle on top square

class GoalGenTree:

    def give_goal(self, blockset):
        tree = TreeScen()
        return tree.givegoal(blockset)

