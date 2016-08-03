import sys
sys.path.append("../")
import midca_inst

class SimpleExec:
	
	def init(self, world, mem):
		self.mem = mem
		self.currentPlan = None

	def get_most_recent_plan(self):
		return self.mem.get(midca_inst.MEM_PLANS)[-1]
	
	def get_action(self, verbose):
		lastplan = self.get_most_recent_plan()
		if lastplan and not lastplan.finished() and (not lastplan.same_plan(self.currentPlan) or (self.currentPlan.step != lastplan.step)):
			if verbose >= 2:
				print "Adopting new plan."
			if self.currentPlan and not self.currentPlan.finished():
				if verbose >= 2:
					print "Saving partially complete plan."
				self.mem._update(midca_inst.MEM_PARTIAL_PLAN, self.currentPlan)
			self.currentPlan = lastplan #replace if new plan generated
		if self.currentPlan:
			nextaction = self.currentPlan.get_next_step()
		else:
			nextaction = None
		if not nextaction:
			partialplan = self.mem.get(midca_inst.MEM_PARTIAL_PLAN)
			if partialplan and not partialplan.finished():
				self.currentPlan = partialplan
				nextaction = self.currentPlan.get_next_step()
				if verbose >= 2:
					print "No action from current plan: Reloading old plan."
		self.mem._add(midca_inst.MEM_ACTIONS, [nextaction, self.currentPlan])
		return nextaction
	
	def run(self, verbose = 2):
		action = self.get_action(verbose)
		if verbose == 1:
			if action:
				print "Executing action " + str(action)
			else:
				print "No action selected."
		elif verbose >= 2:
			if action:
				print "Executing action " + str(action) + " from plan:\n" + self.currentPlan.last_step_str()
			else:
				print "No action selected."