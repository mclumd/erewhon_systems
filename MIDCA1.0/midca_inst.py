from plan.midcaplan import *
from worldsim import domainread, stateread
import midca
import observe, note, assess, goalgen, preplan, plan, execute, worldsim.simulator as worldsim

PHASES = ["Observation Phase", "Note Phase", "Assess Phase", "Goal Selection", "Goal Insertion", "Planning", "Action Selection (exec)"]

MEM_STATES = "states"
MEM_PARTIAL_PLAN = "partial plan"
MEM_PLANS = "plans"
MEM_ACTIONS = "actions"
MEM_ADIST = "aDist"
MEM_ANOM = "anomalous"
MEM_NODES = "gngNodes"
MEM_ANOM_TYPE = "anomType"
MEM_GOALS = "goals"
MEM_CUR_GOAL = "current goal"
MEM_VALENCE = "valence"

DOMAIN_F = "./worldsim/domain.sim"
STATE_F = "./worldsim/defstate.sim"

def default_blocksworld():
	world = domainread.load_domain(DOMAIN_F)
	stateread.apply_state_file(world, STATE_F)
	return world

def populate_modules(arson = False):
	if arson:
		modules = [observe.SimpleObserver(), note.anomaly.ADNoter(30, 0.3), assess.assess.Assessor(30, 0.3), goalgen.rungen.OverGuideArson(), preplan.SimplePrePlan(), plan.shop2plan.Shop2Planner(), execute.SimpleExec()]
	else:
		modules = [observe.SimpleObserver(), note.anomaly.ADNoter(10, 0.5), assess.assess.Assessor(10, 0.5), goalgen.rungen.OverGuide(), preplan.SimplePrePlan(), plan.shop2plan.Shop2Planner(), execute.SimpleExec()]
	return modules
	

def run_regular():
	midca1 = midca.MIDCA(default_blocksworld(), worldsim.Simulator(firechance = 0.8, firestart = 10))
	modules = populate_modules()
	for i in range(len(PHASES)):
		midca1.add_module(PHASES[i], modules[i])
	midca1.init()
	while 1:
		val = raw_input()
		if val == "q":
			break
		elif val == "\t":
			midca1.one_cycle()
		elif val == "skip":
			midca1.one_cycle(verbose = 0, pause = 0)
			print "cycle finished"
		elif val == "show":
			print midca1.get_module("Observation Phase").world_repr(midca1.world)
			print str(midca1.world)
		elif val.startswith("skip"):
			try:
				num = int(val[4:].strip())
				for i in range(num):
					midca1.one_cycle(verbose = 2, pause = 0)
				print str(num) + " cycles finished."
			except ValueError:
				print "Usage: 'skip n', where n is an integer"
		else:
			midca1.next_phase()

def run_arson():
	midca1 = midca.MIDCA(default_blocksworld(), worldsim.Simulator())
	midca1.get_module("Simulation").setup_arson_scheme()
	modules = populate_modules(arson = True)
	for i in range(len(PHASES)):
		midca1.add_module(PHASES[i], modules[i])
	midca1.init()
	while 1:
		val = raw_input()
		if val == "q":
			break
		elif val == "\t":
			midca1.one_cycle()
		elif val == "skip":
			midca1.one_cycle(verbose = 0, pause = 0)
			print "cycle finished"
		elif val == "show":
			print midca1.get_module("Observation Phase").world_repr(midca1.world)
			print str(midca1.world)
		elif val.startswith("skip"):
			try:
				num = int(val[4:].strip())
				for i in range(num):
					midca1.one_cycle(verbose = 0, pause = 0)
				print str(num) + " cycles finished."
			except ValueError:
				print "Usage: 'skip n', where n is an integer"
		elif val == "adist":
			for i in range(100):
				midca1.one_cycle(verbose = 0, pause = 0)
				if i % 10 == 0:
					print i, ": ", midca1.mem.get(MEM_ANOM)
			print midca1.mem.get(MEM_ANOM)
		else:
			midca1.next_phase()

if __name__ == "__main__":
	if raw_input("Press 1 for default fire scenario; any other value for arsonist scenario.") == "1":
		run_regular()
	else:
		run_arson()
	
	