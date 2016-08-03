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

class MAReport:
	
	namecounts = {"report": 0}
	
	def __init__(self):
		self.actions = []
		self.finalstate = None
	
	def str_dict(self, item, numtabs = 1, skipfirsttab = True):
		if isinstance(item, dict):
			s = ""
			first = True
			for key in sorted(item.keys()):
				if not first or not skipfirsttab:
					s += "\t" * numtabs
				else:
					s += " "
				s += "(" + str(key) + " " + self.str_dict(item[key], numtabs + 1) + ")\n"
				first = False
			s = s[:-1]
		else:
			s = str(item)
		return s
	
	def action_str(self, action):
		if action[0] in self.namecounts:
			self.namecounts[action[0]] += 1
		else:
			self.namecounts[action[0]] = 1
		s = "(" + str(action[0]) + "." + str(self.namecounts[action[0]]) + "\n"
		valuepairs = {}
		if action[0] in ("stack", "unstack", "pickup", "putdown", "apprehend", "putoutfire"):
			valuepairs["actor"] = {"value": "person.0"}
		elif action[0] == "burns":
			valuepairs["actor"] = {"value": "nature"}
		valuepairs["object"] = {"value": str(action[1]).replace(" ", "_")}
		if action[0] in ("stack", "unstack"):
			valuepairs["recipient"] = {"value": str(action[2]).replace(" ", "_")}
		return s + self.str_dict(valuepairs, skipfirsttab = False) + ")"
	
	def atom_pairs(self, atom):
		valuepairs = {}
		for i in range(len(atom.args)):
			if i == 0:
				valuepairs["domain"] = {"value": atom.args[i].name.replace(" ", "_")}
			elif i == 1:
				valuepairs["co-domain"] = {"value": atom.args[i].name.replace(" ", "_")}
		return valuepairs
	
	def state_str(self, world):
		s = "(state\n"
		valuepairs = {}
		for atom in world.atoms:
			if atom.predicate.name in self.namecounts:
				self.namecounts[atom.predicate.name] += 1
			else:
				self.namecounts[atom.predicate.name] = 1
			valuepairs[atom.predicate.name + "." + str(self.namecounts[atom.predicate.name])] = self.atom_pairs(atom)
		return s + self.str_dict(valuepairs, skipfirsttab = False) + ")"
		
	
	def __str__(self):
		if not self.finalstate:
			return "incomplete"
		else:
			self.namecounts["report"] += 1
			s = "(" + "report." + str(self.namecounts["report"]) + "\n("
			for action in self.actions:
				s += "\t(\n"
				s += self.action_str(action)
				s += "\n\"\")\n("
				s += self.state_str(self.finalstate)
				s += "\n\"\")\n"
			return s + "))"
			
'''
ma = MAReport()
import domainread, stateread
world = domainread.load_domain("./domain.sim")
stateread.apply_state_file(world, "./defstate.sim")
ma.finalstate = world
ma.actions.append(["unstack", "block1", "block2"])
ma.actions.append(["catchfire", "block1"])
print ma
'''

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
			if not self.world.is_true("onfire", [objectname]) and objectname != "table" and self.world.obj_type(objectname) == "BLOCK": 
				res.append(objectname)
		return res
	
	def run(self, verbose = 1):
		maReport = MAReport()
		self.updates += 1
		action, plan = self.mem.get(midca_inst.MEM_ACTIONS)[-1]
		if not action:
			if verbose >= 1:
				print "No action specified. Nothing happens in world sim."
		else:
			#report arson as blocks catching on fire; report all other actions normally
			if action[0] == "lightonfire":
				maReport.actions.append(["burns",  action[1]])
			else:
				maReport.actions.append(action)
			self.world.apply_action(action[0], action[1:])
			if verbose >= 2:
				print "Simulating action: " + str(action)
			elif verbose >=1:
				print "World updating."
		if self.fireScheme.fire():
			try:
				block = random.choice(self.get_unlit_blocks())
				self.world.apply_action("catchfire", [block])
				maReport.actions.append(["burns"] + [block])
				if verbose >= 2:
					print "Simulating action: catchfire(" + str(block) + ")"
			except IndexError:
				#all blocks on fire
				self.fireScheme.num -= 1
		maReport.finalstate = self.world
		writeSocket = self.mem.get(midca_inst.SOCKET_W)
		if writeSocket:
			print "sending data to MA", str(maReport)
			writeSocket.send(str(maReport))
		else:
			print maReport
	
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
		maReport = MAReport()
		self.updates += 1
		action, plan = self.mem.get(midca_inst.MEM_ACTIONS)[-1]
		if not action:
			if verbose >= 1:
				print "No action specified. Agent does nothing in world sim."
		else:
			#report arson as blocks catching on fire; report all other actions normally
			if action[0] == "lightonfire":
				maReport.actions.append(["burns", action[1]])
			else:
				maReport.actions.append(action)
			self.world.apply_action(action[0], action[1:])
			if verbose >= 2:
				print "Simulating action: " + str(action)
			elif verbose >=1:
				print "World updating."
		if random.random() < self.firechance:
			try:
				block = random.choice(self.get_unlit_blocks())
				maReport.actions.append(["burns"] + [block])
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
		if self.updates > self.arsoniststart and arsonist and random.random() < self.arsonchance:
			try:
				block = random.choice(self.get_unlit_blocks())
				maReport.actions.append(["burns"] + [block])
				self.world.apply_action("lightonfire", [arsonist, block])
				if verbose >= 2:
					print "Simulating action: lightonfire(" + str(arsonist) + ", " + str(block) + ")"
			except IndexError:
				print "All blocks on fire. The arsonist rests peacefully."
		maReport.finalstate = self.world
		writeSocket = self.mem.get(midca_inst.SOCKET_W)
		if writeSocket:
			print "sending data to MA", str(maReport)
			writeSocket.send(str(maReport))
		else:
			print maReport
						