from pyhop121 import pyhop, methods, operators
import sys, collections
sys.path.append("../")
import midca_inst
from plan.midcaplan import *
from utils import blockstate

def pyhop_state_from_world(world, name = "state"):
	s = pyhop.State(name)
	s.pos = {}
	s.clear = {}
	s.holding = False
	s.fire = {}
	s.free = {}
	blocks = []
	for objname in world.objects:
		if world.objects[objname].type.name == "BLOCK" and objname != "table":
			blocks.append(objname)
		elif world.objects[objname].type.name == "ARSONIST":
			s.free[objname] = False
	for atom in world.atoms:
		if atom.predicate.name == "clear":
			s.clear[atom.args[0].name] = True
		elif atom.predicate.name == "holding":
			s.holding = atom.args[0].name
		elif atom.predicate.name == "arm-empty":
			s.holding = False
		elif atom.predicate.name == "on":
			s.pos[atom.args[0].name] = atom.args[1].name
		elif atom.predicate.name == "on-table":
			s.pos[atom.args[0].name] = "table"
		elif atom.predicate.name == "onfire":
			s.fire[atom.args[0].name] = True
		elif atom.predicate.name == "free":
			s.free[atom.args[0].name] = True
	for block in blocks:
		if block not in s.clear:
			s.clear[block] = False
		if block not in s.fire:
			s.fire[block] = False
	return s

def pyhop_tasks_from_goals(goals):
	alltasks = []
	blkgoals = pyhop.Goal("goals")
	blkgoals.pos = {}
	for goal in goals:
		if goal.goaltype == "on":
			blkgoals.pos[goal.goalargs[0].id] = goal.goalargs[1].id
		elif goal.goaltype == "notonfire":
			alltasks.append(("put_out", goal.goalargs[0].id))
		elif goal.goaltype == "apprehend":
			alltasks.append(("catch_arsonist", goal.goalargs[0]))
	if blkgoals.pos:
		alltasks.append(("move_blocks", blkgoals))
	return alltasks

class PyHopPlanner:
	
	def init(self, world, mem):
		self.mem = mem
	
	#this will require a lot more error handling, but ignoring now for debugging.
	def run(self, verbose = 2):
		world = self.mem.get(midca_inst.MEM_STATES)[-1]
		blockset = blockstate.get_block_list(world)
		goals = self.mem.get(midca_inst.MEM_CUR_GOAL)
		if not goals:
			if verbose >= 2:
				print "No goal received by planner. Skipping planning."
			return
			
		if goals and not isinstance(goals, collections.Iterable):
			goals = [goals]
		
		allNone = True
		for goal in goals:
			if goal:
				allNone = False
				break
		if allNone:
			if verbose >= 2:
				print "No goal received by planner. Skipping planning."
			return
				
		#pyhop
		if verbose >= 2:
			print "Planning..."
		plan = pyhop.pyhop(pyhop_state_from_world(world), pyhop_tasks_from_goals(goals), verbose = 0)
		plan = Plan([Action(action[0], list(action[1:])) for action in plan])
		
		if verbose >= 1:
			print "Planning complete."
		if verbose >= 2:
			print "Plan: ",
			for step in plan:
				print str(step),
			print
		#save plan
		self.mem._add(midca_inst.MEM_PLANS, plan)
	