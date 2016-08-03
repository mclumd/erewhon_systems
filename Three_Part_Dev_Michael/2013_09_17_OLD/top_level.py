import os
import sys
sys.path.append("./Goal_Gen/Goal_Gen_2013_03_30")
sys.path.append("./Goal_Gen")
sys.path.append("../SHOP_2_7/GDP/trunk")
from block import Block
import scene
from worldsim import domainread, worldsim, blockstate
import runlisp
from Goal_Gen_2013_03_30 import GoalGen20130330
from assess import anomaly

alispcmd = "/usr/local/allegrocommonlisp-8.2/alisp -#! ../../SHOP_2_7/GDP/trunk/shop2-load.lisp "
problemfile = "/fs/metacog/group/systems/Goal_Gen/Goal_Gen/Goal_Gen_2013_03_30/problemfile"
outputfile = "/fs/metacog/group/systems/Goal_Gen/Shop2Out"
domainfile = "./examples/htn/blocks/domains/blocks-htn.lisp"

def parse_plan(filename = outputfile):
	try:
		lines = open(filename).readlines()
	except Exception:
		print "No plan file...keeping old plan"
		return []
	
	for line in lines:
		if line[:8] == "--plan :":
			if line[8:12] == " NIL":
				return []
			planstart = line.index("(")
			planend = line.rindex(")")
			line = line[planstart + 1:planend]
			actions = []
			while "(" in line and ")" in line:
				action = line[line.index("(") + 1:line.index(")")].split()
				action[0] = action[0][1:]
				for i in range(len(action)):
					action[i] = action[i].lower()
				actions.append(action)
				line = line[line.index(")") + 1:]
			return actions
	return []

def createstartstate():
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

    return [table, t1, t2, t3, t4]

def main():
    blockset = createstartstate()
    gg = GoalGen20130330()
    world = domainread.load_domain("./worldsim/domain.sim")
    i = 1
    blockstate.initialize(world, blockset)
    plan = []
    
    step = 0
    print "Start state:\n"
    scene.Scene(blockset).draw()
    
    while True:
        
        execplanner = True
        # make problem file
        try:
        	gg.makeshop2pfile(blockset, problemfile)
        except AssertionError:
        	print "Error generating goal - no applicable goal for this state"
        	execplanner = False
        
        if i < len(plan):
        	print "Plan in progress - not generating new plan"
        	execplanner = False #because mid-stream goals can be incorrect
        
        #delete old plan file, if any
        if "Shop2Out" in os.listdir("."):
        	os.remove(outputfile)
        
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
        	i = 0
        	print "adopting new plan"
        	plan = newplan
        if i >= len(plan):
        	print "Reached end of plan without new one generated. Quitting."
        	break
        
        #Display plan, ask to continue
        print "Plan: ", plan, "\n"
        print "Next Action: ", plan[i][0], plan[i][1:]
        		
        if raw_input("Press enter to continue, q + enter to quit...") == "q":
       		break
        
        #Execute next action, update knowledge structures.
        world.apply_action(plan[i][0], plan[i][1:])
        blockstate.update(world)
        blockset = blockstate.blocks.values()
        step += 1
        
        #Display world state after action executed
        print "World state, time =", step
        scene.Scene(blockset).draw()
        print world
        
        i += 1

if __name__ == "__main__":
    main()
