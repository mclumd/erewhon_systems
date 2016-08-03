import sys, random, worldsim
sys.path.append("../")
import midca_inst

class FireScheme:
	
	def __init__(self, startval, maxes, changes):
		self.chance = startval
		self.max = maxes.pop(0)
		self.maxes = maxes
		self.changes = changes
		self.num = 0
	
	def fire(self):
		if random.random() < self.chance and self.num < self.max:
			ret = True
			self.num += 1
		else:
			ret = False
		if self.changes and self.changes[0][0] <= 0:
			self.chance = self.changes.pop(0)[1]
			self.max = self.maxes.pop(0)
			self.num = 0
		elif self.changes:
			self.changes[0][0] -= 1
		return ret

class Simulator:
	
	def __init__(self, firechance = 0, firestart = 0, maxfires = 3):
		self.fireScheme = FireScheme(0, [0, maxfires], [[firestart, firechance]])
	
	def init(self, world, mem):
		self.world = world
		self.mem = mem
		self.updates = 0
	
	def setup_arson_scheme(self):
		self.fireScheme = FireScheme(0.15, [8, 100], [[60, 0.5]])
	
	def get_unlit_blocks(self):
		res = []
		for objectname in self.world.objects:
			if not self.world.is_true("onfire", [objectname]) and objectname != "table":
				res.append(objectname)
		return res
	
	def run(self, verbose = 1):
		self.updates += 1
		action, plan = self.mem.get(midca_inst.MEM_ACTIONS)[-1]
		if not action:
			if verbose >= 1:
				print "No action specified. Nothing happens in world sim."
		else:
			self.world.apply_action(action[0], action[1:])
			if verbose >= 2:
				print "Simulating action: " + str(action)
			elif verbose >=1:
				print "World updating."
		if self.fireScheme.fire():
			try:
				block = random.choice(self.get_unlit_blocks())
				self.world.apply_action("lightonfire", [block])
				if verbose >= 2:
					print "Simulating action: lightonfire(" + str(block) + ")"
			except IndexError:
				#all blocks on fire
				self.fireScheme.num -= 1
	
class ArsonSimulator:
	
	def __init__(self, firechance = 0, arsoniststart = 10, arsonchance = 0.4):
		self.firechance = firechance
		self.arsoniststart = arsoniststart
		self.arsonchance = arsonchance
	
	def init(self, world, mem):
		self.world = world
		self.mem = mem
		self.updates = 0
	
	def get_unlit_blocks(self):
		res = []
		for objectname in self.world.objects:
			if not self.world.is_true("onfire", [objectname]) and self.world.objects[objectname].type.name == "BLOCK" and objectname != "table":
				res.append(objectname)
		return res
	
	def free_arsonist(self):
		for atom in self.world.atoms:
			if atom.predicate.name == "free":
				if atom.args[0].type.name == "ARSONIST":
					return atom.args[0].name
		return False
	
	def run(self, verbose = 1):
		self.updates += 1
		action, plan = self.mem.get(midca_inst.MEM_ACTIONS)[-1]
		if not action:
			if verbose >= 1:
				print "No action specified. Agent does nothing in world sim."
		else:
			self.world.apply_action(action[0], action[1:])
			if verbose >= 2:
				print "Simulating action: " + str(action)
			elif verbose >=1:
				print "World updating."
		if random.random() < self.firechance:
			try:
				block = random.choice(self.get_unlit_blocks())
				self.world.apply_action("catchfire", [block])
				if verbose >= 2:
					print "Simulating action: catchfire(" + str(block) + ")"
			except IndexError:
				#all blocks on fire
				pass
		if self.updates == self.arsoniststart:
			if verbose >= 1:
				print "Activating arsonist Gui Montag."
		arsonist = self.free_arsonist()
		if self.updates > self. arsoniststart and arsonist and random.random() < self.arsonchance:
			try:
				block = random.choice(self.get_unlit_blocks())
				self.world.apply_action("lightonfire", [arsonist, block])
				if verbose >= 2:
					print "Simulating action: lightonfire(" + str(arsonist) + ", " + str(block) + ")"
			except IndexError:
				print "All blocks on fire. The arsonist rests peacefully."
						