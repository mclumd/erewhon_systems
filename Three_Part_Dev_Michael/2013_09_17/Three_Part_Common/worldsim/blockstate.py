
blocks = {}

def b(name):
	return "b" + str(name)

def initialize(world, newblocks):	
	for block in newblocks:
		blocks[b(block.blockid)] = block		
		world.add_object(world.types["BLOCK"].instantiate(b(block.blockid)))
	armempty = True
	for block in newblocks:
		if not block.isonfire:
			world.add_atom(world.predicates["notonfire"].instantiate([world.objects[b(block.blockid)]]))
		if block.blockon:
			if block.blockon.blocktype != block.TABLE:
				world.add_atom(world.predicates["on"].instantiate([world.objects[b(block.blockid)], world.objects[b(block.blockon.blockid)]]))
			else:
				world.add_atom(world.predicates["on-table"].instantiate([world.objects[b(block.blockid)]]))
		elif block.blocktype != block.TABLE:
			if not armempty:
				raise Exception("Too many things being held")
			armempty = False
			world.add_atom(world.predicates["holding"].instantiate([world.objects[b(block.blockid)]]))
		if block.isclear:
			world.add_atom(world.predicates["clear"].instantiate([world.objects[b(block.blockid)]]))
	if armempty:
		world.add_atom(world.predicates["arm-empty"].instantiate([]))

def update(world):
	for block in blocks.values():
		block.isclear = False
		block.blockon = None
		block.isonfire = True
		if block.blocktype == block.TABLE:
			table = block
	for atom in world.atoms:
		if atom.predicate == world.predicates["on"]:
			blocks[atom.args[0].name].blockon = blocks[atom.args[1].name]
		elif atom.predicate == world.predicates["on-table"]:
			blocks[atom.args[0].name].blockon = table
		elif atom.predicate == world.predicates["clear"]:
			blocks[atom.args[0].name].isclear = True
		elif atom.predicate == world.predicates["notonfire"]:
			blocks[atom.args[0].name].isonfire = False