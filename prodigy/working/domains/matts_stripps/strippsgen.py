import random, gui, pygame, sys, os, platform
from pygame.locals import *

#if platform.system() == 'Linux':
 #   os.environ['SDL_VIDEODRIVER'] = 'acpi'

ASQII_A = 65

#possible goals
G_BOX_ROOM = 0
G_KEY_ROOM = 1
G_ROBOT_ROOM = 2
G_HAS_KEY = 3
G_DOOR_OPEN = 4
G_DOOR_CLOSED = 5
G_DOOR_LOCKED = 6
G_DOOR_UNLOCKED = 7

GOAL_TO_NAME = {G_BOX_ROOM: "Box in room", G_KEY_ROOM: "Key in room", G_ROBOT_ROOM: "Robot in room", G_HAS_KEY: "Robot has key", G_DOOR_OPEN: "Door is open", G_DOOR_CLOSED: "Door is closed", G_DOOR_LOCKED: "Door is locked", G_DOOR_UNLOCKED: "Door is unlocked"}

NAME_TO_GOAL = {}
for goal in GOAL_TO_NAME:
	NAME_TO_GOAL[GOAL_TO_NAME[goal]] = goal

#DEFAULTS_FILE = "./defaults.txt"

class Room:
	
	def __init__(self, name):
		self.name = name

class Robot:
	
	def __init__(self, room):
		self.name = "robot"
		self.room = room

class Key:
	
	def __init__(self, name, door, room):
		self.name = name
		self.door = door
		self.room = room

class Door:
	
	def __init__(self, name, room1, room2):
		self.name = name
		self.room1 = room1
		self.room2 = room2
		self.locked = False
		self.closed = False
	
class Item:
	
	def __init__(self, name, room):
		self.name = name
		self.room = room


class Goal:
	
	def __init__(self, pred, obj1 = None, obj2 = None, obj3 = None):
		self.predicate = pred
		self.obj1 = obj1
		self.obj2 = obj2
		self.obj3 = obj3

class EXStrippsProblem:
	
	def __init__(self, data):
		self.numrooms = data["numrooms"]
		if self.numrooms < 2:
			self.numrooms = 2
		self.numdoors = random.choice(range(data["mindoors"], data["maxdoors"] + 1))
		self.numitems = data["numitems"]
		self.numgoals = data["numgoals"]
		self.goaltypes = data["goaltypes"]
		self.num = data["num"]
	
	def gen_state(self):
		state = []
		for item in self.items:
			if item.pushable:
				state.append(Goal("pushable", item))
			else: #if not pushable, carriable
				state.append(Goal("carriable", item))
			state.append(Goal("inroom", item, item.room))
		for door in self.doors:
			state.append(Goal("dr-to-rm", door, door.room1))
			state.append(Goal("dr-to-rm", door, door.room2))
			state.append(Goal("connects", door, door.room1, door.room2))
			state.append(Goal("connects", door, door.room2, door.room1))
			if door.locked:
				state.append(Goal("locked", door))
			else:
				state.append(Goal("unlocked", door))
			if door.closed:
				state.append(Goal("dr-closed", door))
			else:
				state.append(Goal("dr-open", door))
		for key in self.keys:
			state.append(Goal("is-key", key, key.door))
			state.append(Goal("carriable", key))
			state.append(Goal("inroom", key, key.room))
		state.append(Goal("inroom", self.robot, self.robotroom))
		state.append(Goal("arm-empty"))
		return state
	
	def key_in(self, door, keys):
		for key in keys:
			if key.door == door:
				return True
		return False
	
	def get_reachable_rooms(self):
		rooms = [self.robotroom]
		keys = []
		for key in self.keys:
			if key.room == self.robotroom:
				keys.append(key)
		added = True
		while added:
			added = False
			for door in self.doors:
				if door.room1 in rooms:
					if (not door.locked) or self.key_in(door, keys):
						if door.room2 not in rooms:
							rooms.append(door.room2)
							added = True
							for key in self.keys:
								if key.room == door.room2:
									keys.append(key)
				elif door.room2 in rooms:
					if (not door.locked) or self.key_in(door, keys):
						rooms.append(door.room1)
						added = True
						for key in self.keys:
							if key.room == door.room1:
								keys.append(key)
		for room in rooms:
			print room.name
		return rooms
	
	def gen_goals(self):
		reachablerooms = self.get_reachable_rooms()
		allgoals = []
		
		if G_BOX_ROOM in self.goaltypes:
			for item in self.items:
				if item.room in reachablerooms:
					for room in reachablerooms:
						allgoals.append(Goal("inroom", item, room))
		if G_KEY_ROOM in self.goaltypes:
			for key in self.keys:
				if key.room in reachablerooms:
					for room in reachablerooms:
						allgoals.append(Goal("inroom", key, room))
		if G_ROBOT_ROOM in self.goaltypes:
			for room in reachablerooms:
				allgoals.append(Goal("inroom", self.robot, self.robotroom))
		if G_HAS_KEY in self.goaltypes:
			for key in self.keys:
				if key.room in reachablerooms:
					allgoals.append(Goal("holding", key))
		if G_DOOR_OPEN in self.goaltypes:
			for door in self.doors:
				if door.room1 in reachablerooms and door.room2 in reachablerooms:
					allgoals.append(Goal("dr-open", door))
		if G_DOOR_CLOSED in self.goaltypes:
			for door in self.doors:
				if door.room1 in reachablerooms or door.room2 in reachablerooms:
					allgoals.append(Goal("dr-closed", door))
		if G_DOOR_LOCKED in self.goaltypes:
			for door in self.doors:
				if door.room1 in reachablerooms and door.room2 in reachablerooms:
					allgoals.append(Goal("locked", door))
		if G_DOOR_UNLOCKED in self.goaltypes:
			for door in self.doors:
				if door.room1 in reachablerooms and door.room2 in reachablerooms:
					allgoals.append(Goal("unlocked", door))
		goals = []
		doorsused = []
		objsused = [] #assume items, keys, robot cannot be in two goals
		for i in range(self.numgoals):
			if not allgoals:
				break
				print "No legal goals left"
			goal = random.choice(allgoals)
			allgoals.remove(goal)
			goalgood = True
			while (goal.predicate in [G_DOOR_OPEN, G_DOOR_CLOSED, G_DOOR_LOCKED, G_DOOR_UNLOCKED] and goal.obj1 in doorsused) or (goal.predicate not in [G_DOOR_OPEN, G_DOOR_CLOSED, G_DOOR_LOCKED, G_DOOR_UNLOCKED] and goal.obj1 in objsused):
				goalgood = False
				if not allgoals:
					break
				goalgood = True
				goal = random.choice(allgoals)
				allgoals.remove(goal)
			if goalgood:
				if goal.predicate in [G_DOOR_OPEN, G_DOOR_CLOSED, G_DOOR_LOCKED, G_DOOR_UNLOCKED]:
					doorsused.append(goal.obj1)
				else:
					objsused.append(goal.obj1)
				goals.append(goal)
			else:
				break
				print "No legal goals left"
		return goals
	
		
	lockedchance = 0.5
	closedchance = 0.5 #if unlocked
	
	def generate(self):
		self.rooms = []
		self.doors = []
		self.keys = []
		self.items = []
		for i in range(self.numrooms):
			self.rooms.append(Room("rm" + chr(ASQII_A + i)))
		for i in range(self.numdoors):
			room1 = random.choice(self.rooms)
			room2 = random.choice(self.rooms)
			while room1 == room2:
				room2 = random.choice(self.rooms)
			door = Door("dr" + chr(ASQII_A + i), room1, room2)
			if random.random() < self.lockedchance:
				door.locked = True
				door.closed = True
			elif random.random() < self.closedchance:
				door.closed = True
			#note closed and locked default to false; e.g. doors are open
			self.doors.append(door)
			self.keys.append(Key("key" + chr(ASQII_A + i), door, random.choice(self.rooms)))
		for i in range(self.numitems):
			self.items.append(Item("box" + chr(ASQII_A + i), random.choice(self.rooms)))
			self.items[-1].pushable = random.choice([True, False])
		self.robotroom = random.choice(self.rooms)
		self.robot = Robot(self.robotroom)
		
		self.state = self.gen_state()
		self.goals = self.gen_goals()
	
	def to_s(self):
		s = "(setf (current-problem) \n\t(create-problem\n\t\t"
		s += "(name p" + str(self.num) + ")\n\t\t (objects\n\t\t\t("
		for room in self.rooms:
			s += room.name + " "
		s += "ROOM)\n\t\t\t("
		for item in self.items:
			s += item.name + " "
		s += "BOX)\n\t\t\t("
		for door in self.doors:
			s += door.name + " "
		s += "DOOR)\n\t\t\t("
		for key in self.keys:
			s += key.name + " "
		s += "KEY)\n)\n"
		s += "\t\t(state\n\t\t\t(and\n"
		for part in self.state:
			s += "\t\t\t\t(" + part.predicate
			if part.obj1:
				s += " " + part.obj1.name
			if part.obj2:
				s += " " + part.obj2.name
			if part.obj3:
				s += " " + part.obj3.name
			s += ")\n"
		s += "))\n\t\t(goal\n\t\t\t(and\n"
		for goal in self.goals:
			s += "\t\t\t\t(" + goal.predicate
			if goal.obj1:
				s += " " + goal.obj1.name
			if goal.obj2:
				s += " " + goal.obj2.name
			s += ")\n"
		s += "))))"
		return s
		
def print_n_stripps(input):
	numprobs = input["num"]
	for i in range(numprobs):
		input["num"] = i + 1
		prob = EXStrippsProblem(input)
		prob.generate()
		f = open("p" + str(i + 1) + ".lisp", 'w')
		f.write(prob.to_s())
		f.close()

defaults = {"numrooms": 4, "mindoors": 4, "maxdoors": 6, "numitems": 3, "numgoals": 3, "goaltypes": [0, 1, 2, 3, 4], "num": 1}

print pygame.init()
print pygame.display.get_driver()
pygame.font.init()
screen = pygame.display.set_mode((1024, 768), DOUBLEBUF)
guiscreen = gui.GUI(screen.get_size())
guiscreen.bkgcolor = (200, 100, 100)

inputboxes = {}
for item in ["numrooms", "mindoors", "maxdoors", "numitems", "numgoals"]:
	inputboxes[item] = gui.TextBox(str(defaults[item]), numericOnly=True)
inputboxes["numproblems"] = gui.TextBox(str(defaults["num"]), numericOnly=True)

y = 100
labelx = 150
boxx = 350
	
for ib in inputboxes:
	guiscreen.add(gui.Label(ib), (labelx, y))
	guiscreen.add(inputboxes[ib], (boxx, y))
	y += 100

checkx = 600
y = 100

for goal in GOAL_TO_NAME:
	guiscreen.add(gui.CheckBox(GOAL_TO_NAME[goal], goal in defaults["goaltypes"]), (checkx, y))
	y += 75

def get_input():
	input = {}
	input["numrooms"] = int(inputboxes["numrooms"].text)
	input["mindoors"] = int(inputboxes["mindoors"].text)
	input["maxdoors"] = int(inputboxes["maxdoors"].text)
	input["numitems"] = int(inputboxes["numitems"].text)
	input["numgoals"] = int(inputboxes["numgoals"].text)
	input["num"] = int(inputboxes["numproblems"].text)
	input["goaltypes"] = []
	for obj in guiscreen.objects:
		if hasattr(obj, "label"):
			if obj.label in NAME_TO_GOAL and obj.checked:
				input["goaltypes"].append(NAME_TO_GOAL[obj.label])
	return input

changed = True
while 1:
	for event in pygame.event.get():
		if event.type == pygame.KEYDOWN:
			if event.key == K_ESCAPE:
				sys.exit(0)
			elif event.key == K_RETURN:
				print_n_stripps(get_input())
			else:
				guiscreen.key_down(event.key)
				changed = True
		elif event.type == pygame.MOUSEBUTTONDOWN:
			if event.button == 1 or event.button == 3:
				guiscreen.click(event.button, event.pos)
				changed = True
	if changed:
		screen.blit(guiscreen.draw(), (0, 0))
		pygame.display.flip()
		changed = False