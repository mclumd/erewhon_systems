import sys
sys.path.append("../")
import midca_inst
from utils import blockstate, scene

class SimpleObserver:

	def init(self, world, mem):
		self.world = world
		self.mem = mem
	
	#perfect observation
	def observe(self):
		return self.world.copy()
	
	def world_repr(self, world):
		blocks = blockstate.get_block_list(world)
		return str(scene.Scene(blocks))
		
	def run(self, verbose = 2):
		world = self.observe()
		if not world:
			raise Exception("World obervation failed.")
		self.mem._add(midca_inst.MEM_STATES, world)
		repr = str(self.world_repr(world))
		if verbose == 2:
			print "World observed: \n" + str(repr)
		elif verbose == 1:
			print "World observed."