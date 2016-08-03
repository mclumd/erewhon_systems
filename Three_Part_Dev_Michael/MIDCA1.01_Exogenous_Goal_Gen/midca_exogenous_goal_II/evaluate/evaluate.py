import sys
sys.path.append("../")
import midca_inst

class Evaluator:
	
	def init(self, world, mem):
		self.mem = mem
	
	def run(self, verbose = 2):
		world = self.mem.get(midca_inst.MEM_STATES)[-1]
		try:
			currentgoals = self.mem.get(midca_inst.MEM_GOALS)[-1]
		except TypeError, IndexError:
			currentgoals = None
		accomplished = True
		if currentgoals:
			for currentgoal in currentgoals:
				accomplishedthis = False
				if currentgoal.goaltype == "on":
					accomplishedthis = world.is_true("on", [arg.id for arg in currentgoal.goalargs])
					print "on", accomplishedthis
				elif currentgoal.goaltype == "apprehend":
					accomplishedthis = not world.is_true("free", [arg for arg in currentgoal.goalargs])
				elif currentgoal.goaltype == "notonfire":
					accomplishedthis = not world.is_true("onfire", [arg.id for arg in currentgoal.goalargs])
				elif currentgoal.goaltype == "arm-empty":
					accomplishedthis = world.is_true("arm-empty", [arg.id for arg in currentgoal.goalargs])
					print "arm", accomplishedthis
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
		self.mem._update(midca_inst.MEM_GOAL_COMPLETED, accomplished)
			