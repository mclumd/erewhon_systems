
class Action:
	
	def __init__(self, op, args):
		self.op = op
		self.args = args
	
	def __eq__(self, other):
		return type(self) == type(other) and self.op == other.op and self.args == other.args
	
	def __getitem__(self, index):
		all = [self.op] + self.args
		return all[index]
	
	def __str__(self):
		s = self.op + "("
		for arg in self.args:
			s += arg + ", "
		s = s[:-2] + ")"
		return s

class Plan:
	
	def __init__(self, actions, step = 1):
		self.actions = actions
		self.step = 1
	
	def same_plan(self, other):
		return type(self) == type(other) and self.actions == other.actions
	
	def get_next_step(self):
		if len(self.actions) < self.step:
			return None
		self.step += 1
		return self.actions[self.step - 2]
	
	def poll_next_step(self):
		if len(self.actions) < self.step:
			return None
		return self.actions[self.step - 1]
	
	def finished(self):
		return self.step > len(self)
	
	def __len__(self):
		return len(self.actions)
	
	def __getitem__(self, index):
		return self.actions[index]
	
	def last_step_str(self):
		s = ""
		for action in range(len(self.actions)):
			if self.step - 2 == action:
				s += '\033[94m' + str(self.actions[action]) + '\033[0m'
			else:
				s += str(self.actions[action])
			s += " "
		return s[:-1]
	
	def __str__(self):
		s = ""
		for action in range(len(self.actions)):
			if self.step - 1 == action:
				s += '\033[94m' + str(self.actions[action]) + '\033[0m'
			else:
				s += str(self.actions[action])
			s += " "
		return s[:-1]