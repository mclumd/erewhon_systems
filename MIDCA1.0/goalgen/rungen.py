import sys, random
sys.path.append("../")
from gengoal import *
import gengoal_fire
from utils import blockstate
import midca_inst

# Take block set, give goal.
class TFGuide:
    
    def init(self, world, mem):
        self.mem = mem
        self.gen = GoalGen()

    def run(self, verbose = 2):
        plans = self.mem.get(midca_inst.MEM_PLANS)
        if plans and plans[-1] and plans[-1].poll_next_step():
        	if verbose >= 2:
        		print "Plan in process. Skipping TF-Tree goal gen."
        	return
        world = self.mem.get(midca_inst.MEM_STATES)[-1]
        blocks = blockstate.get_block_list(world)
        goal = self.gen.give_goal(blocks)
        if goal:
        	goals = [goal, Goal("arm-empty", [])]
        else:
        	goals = []
        self.mem._add(midca_inst.MEM_GOALS, goals)
        if goals and verbose >= 1:
        	print "Goal generated: " + str(goal)
        elif not goals and verbose >= 2:
        	print "No goal generated."

class TFFireGuide:
	
	def init(self, world, mem):
		self.mem = mem
		self.gen = gengoal_fire.FireGoalGen()
	
	def run(self, verbose = 2):
		if verbose >= 2:
			print "Firefighter guidance activated.   "
		world = self.mem.get(midca_inst.MEM_STATES)[-1]
		blocks = blockstate.get_block_list(world)
		goal = self.gen.give_goal(blocks)
		if goal:
			goals = [goal]
		else:
			if verbose >= 1:
				print "No firefighting goal generated."
				return False
		self.mem._add(midca_inst.MEM_GOALS, goals)
		if verbose >= 1:
			print "Goal generated: " + str(goal)
		return True
	

class FireGuide:

	def init(self, world, mem):
		self.mem = mem
	
	def random_fired_block(self, world):
		res = []
		for objectname in world.objects:
			if world.is_true("onfire", [objectname]) and objectname != "table":
				res.append(world.objects[objectname])
		if not res:
			return None
		return random.choice(res)
	
	def run(self, verbose = 2):
		if verbose >= 2:
			print "Firefighter guidance activated.	"
		world = self.mem.get(midca_inst.MEM_STATES)[-1]
		block = self.random_fired_block(world)
		if not block:
			if verbose >= 1:
				print "No blocks on fire. Firefighting module not adding a goal."
			return False
		blocks = blockstate.get_block_list(world)
		for realblock in blocks:
			if realblock.id == block.name:
				block = realblock
				break
			self.mem._add(midca_inst.MEM_GOALS, [])
		goal = Goal(GOAL_NO_FIRE, [block])
		self.mem._add(midca_inst.MEM_GOALS, [goal])
		if goal and verbose >= 1:
			print "Goal generated: " + str(goal)
		return True

class OverGuide:
	
	def init(self, world, mem):
		self.tfGuide = TFGuide()
		self.fireGuide = TFFireGuide()
		self.tfGuide.init(world, mem)
		self.fireGuide.init(world, mem)
		self.mem = mem
	
	def run(self, verbose = 2):
		if self.mem.get(midca_inst.MEM_ANOM) and self.mem.get(midca_inst.MEM_ANOM)[-1]:
			if self.mem.get(midca_inst.MEM_ANOM_TYPE)[-1] == "onfire":
				if self.fireGuide.run(verbose):
					return
		partialplan = self.mem.get(midca_inst.MEM_PARTIAL_PLAN)
		if not partialplan or partialplan.finished():
			if verbose >= 2:
				print "TF-tree goal gen activated."
			self.tfGuide.run(verbose)

class OverGuideArson(OverGuide):
	
	def run(self, verbose):
		if self.fireGuide.run(verbose):
			return
		partialplan = self.mem.get(midca_inst.MEM_PARTIAL_PLAN)
		if not partialplan or partialplan.finished():
			if verbose >= 2:
				print "TF-tree goal gen activated."
			self.tfGuide.run(verbose)
