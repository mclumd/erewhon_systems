import sys, collections
sys.path.append("../")
import midca_inst

class SimplePrePlan:
	
	def init(self, world, mem):
		self.mem = mem
		self.lastgoal = None
	
	#if new goal was generated since last run, set current goal to it. Otherwise, set current goal to None to stop redundant planning.
	def run(self, verbose = 2):
		lastgoal = self.mem.get(midca_inst.MEM_GOALS)[-1]
		if lastgoal == self.lastgoal:
			self.mem._update(midca_inst.MEM_CUR_GOAL, None)
			if verbose >= 2:
				print "No new goal generated. No goal will be sent to planner."
		else:
			self.mem._update(midca_inst.MEM_CUR_GOAL, lastgoal)
			if verbose >= 1:
				print "New goal generated and sent to planner."
			elif verbose >= 2:
				if isinstance(lastgoal, collections.Iterable):
					print "New goals generated and sent to planner:", 
					for goal in lastgoal:
						print str(lastgoal),
					print
				else:
					print "New goal generated and sent to planner: " + str(lastgoal)
		self.lastgoal = lastgoal