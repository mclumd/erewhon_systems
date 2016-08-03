import os, sys, random
#sys.path.append("./Goal_Gen/Goal_Gen_2013_03_30")
#sys.path.append("./Goal_Gen")
sys.path.append("../SHOP_2_7/GDP/trunk")
from Goal_Gen.block import Block
from Goal_Gen import scene
from worldsim import domainread, worldsim, blockstate
import runlisp
from Goal_Gen.Goal_Gen_2013_09_10.Tree.Tree import Tree
import assess
from memory import mem

alispcmd = "/usr/local/allegrocommonlisp-8.2/alisp -#! ../../SHOP_2_7/GDP/trunk/shop2-load.lisp "
problemfile = "problemfile"
outputfile = "Shop2Out"
domainfile = "./examples/htn/blocks/domains/blocks-htn-fire.lisp"

def parse_plan(filename = outputfile):
	try:
		text = open(filename).read()
	except Exception:
		print "No plan file...keeping old plan"
		return []
	if "--plan :" in text:
		if "(" not in text:
			print text
			return []
		planstart = text.index("(", text.index("--plan :"))
		planend = text.rindex(")")
		text = text[planstart + 1:planend]
		actions = []
		while "(" in text and ")" in text:
			action = text[text.index("(") + 1:text.index(")")].split()
			action[0] = action[0][1:]
			for i in range(len(action)):
				action[i] = action[i].lower()
			actions.append(action)
			text = text[text.index(")") + 1:]
		return actions
	return []

def createstartstate(onfire = False):
    table = Block(Block.TABLE, "Table")
    
    # make height 2 tower topped by triangle
    t1 = Block(Block.SQUARE, 1)
    t2 = Block(Block.SQUARE, 2)
    t3 = Block(Block.TRIANGLE, 3)

    # place single square on table
    t4 = Block(Block.SQUARE, 4)

    t1.place(table)
    t2.place(t1)
    t3.place(t2)
    t4.place(table)
    if onfire:
    	t1.isonfire = True
    	t2.isonfire = True

    return [table, t1, t2, t3, t4]

def remove_old_files():
	if os.path.exists(outputfile):
		os.remove(outputfile)
	if os.path.exists(problemfile):
		os.remove(problemfile)
	if os.path.exists(problemfile + ".fasl"):
		os.remove(problemfile + ".fasl")

def main(firechance = False, firestart = 0):
    blockset = createstartstate(onfire = False)
    gg = Tree()
    world = domainread.load_domain("./worldsim/domain.sim")
    planstep = 1
    blockstate.initialize(world, blockset)
    mem._init("worldStates", [])
    anomalyDetector = assess.anomaly.AnomalyDetector(world, mem, size = 10, threshold = 0.4)
    anomalyAnalyzer = assess.anomaly.AnomalyAnalyzer(anomalyDetector)
    plan = []
    
    step = 0
    print "Start state:\n"
    scene.Scene(blockset).draw()
    
    try:
    	while True:        
       		remove_old_files()
        	execplanner = True
        	
        	if planstep < len(plan):
        		print "Plan in progress - not generating new plan"
        		execplanner = False #because mid-stream goals can be incorrect
        	# make problem file    
        	else:
        		try:
        			gg.makeshop2pfile(blockset, problemfile)
       			except AssertionError:
        			print "Error generating goal - no applicable goal for this state"
        			execplanner = False
         
        	#run SHOP2
        	if execplanner:
        		runlisp.run_shop2(domainfile, problemfile, outputfile)
        		print "\nGenerating plan"
        
        	'''#For Debugging:
        	for block in blockset:
        		if block.blocktype != block.TABLE:
        			print block.blocktype, block.blockid, block.blockon.blockid, block.isclear
        	'''
        
        	#if plan is generated, replace old plan
        	newplan = parse_plan()
        	if newplan:
        		planstep = 0
        		print "adopting new plan"
        		plan = newplan
        	if planstep >= len(plan):
        		print "Reached end of plan without new one generated."
        		break
        
        	#Display plan, ask to continue
        	print "Plan: ", plan, "\n"
        	print "Next Action: ", plan[planstep][0], plan[planstep][1:]
        		
        	if raw_input("Press enter to continue, q + enter to quit...") == "q":
       			break
        
        	#Execute next action, update knowledge structures.
        	world.apply_action(plan[planstep][0], plan[planstep][1:])
        	
        	#add random fires, if enabled
        	if firechance and step >= firestart:
        		toremove = []
        		for atom in world.atoms:
        			if atom.predicate == world.predicates["notonfire"] and atom.args[0].name != "bTable": #table cannot catch fire.
        				rand = random.random()
        				if rand < firechance:
        					toremove.append(atom)
        		for atom in toremove:
        			world.remove_atom(atom)
        			
        	blockstate.update(world)
        	blockset = sorted(blockstate.blocks.values(), key = lambda x: x.blockid)
        	anomalyDetector.update(world)
        	anomalyAnalyzer.update()
        	mem.update({"worldStates": world})
        
        	#Display world state after action executed
        	print "World state, time =", step
        	scene.Scene(blockset).draw()
        	#print world
        
        	planstep += 1
        	step += 1
    finally:
        remove_old_files()

    	if raw_input("Press enter to see A-Distance and GNG results, q + enter to quit...") == "q":
    		sys.exit()
    	for node in anomalyAnalyzer.nodes():
    		print node
    	#for edge in anomalyAnalyzer.gng.edges:
    		#print edge
    	print str(anomalyDetector), "res"
    #assess.adraw.display_seqs(mem.get("aDist")[0].trace.sequences())
    #raw_input("Press Enter to quit/exit Adist window.")

if __name__ == "__main__":
    if len(sys.argv) == 2:
    	main(firechance = float(sys.argv[1]))
    elif len(sys.argv) == 3:
    	main(firechance = float(sys.argv[1]), firestart = float(sys.argv[2]))
    else:
    	main()
    
