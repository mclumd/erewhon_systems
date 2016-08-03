import sys
sys.path.append("../")
import gngassess, valence, midca_inst

class Assessor:
	
	def __init__(self, windowsize, threshold):
		self.size = windowsize
		self.threshold = threshold
	
	def init(self, world, mem):
		self.valenceAssess = valence.PredicateChangeAssessor(self.size)
		self.gngAssess = gngassess.AnomalyAnalyzer()
		self.valenceAssess.init(world, mem)
		self.gngAssess.init(world, mem)
		self.mem = mem
		self.MAAnomCount = 1
	
	def lisp_anom_str(self):
		self.predi = self.mem.get(midca_inst.MEM_ANOM)[-1]
		s = "(anomaly." + str(self.MAAnomCount) + "\n"
		anompred = self.mem.get(midca_inst.MEM_ANOM_TYPE)[-1]
		s += "\t(predicate (value " + anompred + "))\n"
		anomvalence = self.mem.get(midca_inst.MEM_VALENCE)
		s += "\t(valence-class (value " + anomvalence + "))\n"
		anomintensity = max(self.mem.get(midca_inst.MEM_NODES)[-1][0].location)
		if anomintensity < self.threshold * 1.3:
			s += "\t(intensity (value low))\n"
		elif anomintensity < self.threshold * 1.5:
			s += "\t(intensity (value medium))\n"
		else:
			s += "\t(intensity (value high))\n"
		anomrange = len(self.mem.get(midca_inst.MEM_STATES)) - self.size, len(self.mem.get(midca_inst.MEM_STATES))
		s += "\t(window-range (start " + str(anomrange[0]) + ") (end " + str(anomrange[1]) + ")))"
		return s
	
	def run(self, verbose = 2):
		self.valenceAssess.run(verbose)
		self.gngAssess.run(verbose)
		if self.mem.get(midca_inst.MEM_ANOM) and self.mem.get(midca_inst.MEM_ANOM)[-1]:
			print "M-A frame:"
			print self.lisp_anom_str()
			self.MAAnomCount += 1
			
'''
(burns
	(actor	(value nature.0) (status* story-rep.0))
	(obj	(value block.12))
	(main-result	(value nature.0))
)
'''