import sys
sys.path.append("../")
import midca_inst

class Evaluator:
	
	def init(self, world, mem):
		self.mem = mem
		self.towersFinished = 0
		self.fireturns = 0
	
	def num_fires(self, world):
		n = 0
		for atom in world.atoms:
			if atom.predicate.name == "onfire":
				n += 1
		return n
	
	def run(self, verbose = 2):
		world = self.mem.get(midca_inst.MEM_STATES)[-1]
		self.fireturns += self.num_fires(world)
		try:
			currentgoals = self.mem.get(midca_inst.MEM_GOALS)[-1]
		except TypeError, IndexError:
			currentgoals = None
		accomplished = True
		if currentgoals:
			if not hasattr(currentgoals, "__iter__"):
				currentgoals = [currentgoals]
			for currentgoal in currentgoals:
				accomplishedthis = False
				if currentgoal.goaltype == "on":
					accomplishedthis = world.is_true("on", [arg.id for arg in currentgoal.goalargs])
					if currentgoal.goalargs[0].id == "D_" and currentgoal.goalargs[1].id == "C_" and accomplishedthis:
						if verbose >= 2:
							print "Tower completed"
						self.towersFinished += 1
				elif currentgoal.goaltype == "apprehend":
					accomplishedthis = not world.is_true("free", [arg for arg in currentgoal.goalargs])
				elif currentgoal.goaltype == "notonfire":
					accomplishedthis = not world.is_true("onfire", [arg.id for arg in currentgoal.goalargs])
				elif currentgoal.goaltype == "arm-empty":
					accomplishedthis = world.is_true("arm-empty", [arg.id for arg in currentgoal.goalargs])
				accomplished = accomplished and accomplishedthis
			if verbose >= 1:
				s = "current goals: " + "".join([str(currentgoal) + " " for currentgoal in currentgoals]) + " have "
				if not accomplished:
					s += "not "
				s += "been accomplished."
				print s
		else:
			if verbose >= 2:
				print "No current goal. Skipping Eval."
		if verbose >= 2:
			print "Total towers built:", self.towersFinished
			print "Total fire turns:", self.fireturns
		self.mem._update(midca_inst.MEM_GOAL_COMPLETED, accomplished)
			