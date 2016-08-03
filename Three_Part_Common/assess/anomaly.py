import adistadapt, gng

class AnomalyDetector:
	
	def __init__(self, world, mem, threshold = 0.5, size = None):
		self.mem = mem
		if size:
			aDist = adistadapt.ADistWrapper(threshold, windowsize = size)
		else:
			aDist = adistadapt.ADistWrapper(threshold)
		aDist.init(world)
		self.mem.update({"aDist": [aDist]})
		self.dimension = len(adistadapt.get_pred_names(world))
	
	def update(self, world):
		self.mem.update_all("aDist", world)
	
	def clear(self):
		self.mem._clear("aDist")
	
	def add_WP(self, windowStart, threshold = 0.5, size = None):
		if not self.mem.get("worldStates"):
			raise Exception("World states not in memory; cannot create new WP")
		states = self.mem.get("worldStates")
		if len(states) < windowStart + 1:
			raise Exception("Starting WP in future not allowed")
		if size:
			aDist = adistadapt.ADistWrapper(threshold, size, start = windowStart)
		else:
			aDist = adistadapt.ADistWrapper(threshold, start = windowStart)
		aDist.init(states[windowStart])
		windowStart += 1
		if windowStart + aDist.windowsize >= len(states):
			for i in range(windowStart, len(states)):
				aDist.update(states[i])
		else:
			#fill first window, then add last windows' width of data
			for i in range(windowStart, windowStart + aDist.windowsize):
				aDist.update(states[i])
			for i in range(max(i, len(states) - windowSize), len(states)):
				aDist.update(states[i])	
		self.mem.update({"aDist": aDist})
	
	def __str__(self):
		s = ""
		n = 1
		for aDist in self.mem.get("aDist"):
			s += "Window Pair " + str(n) + ". Window start time = " + str(aDist.start) + "\n" + str(aDist) + "\n"
			n += 1
		return s

class AnomalyAnalyzer:

	def __init__(self, anomalydetector, wp = 0):
		self.numUpdates = 0
		mem = anomalydetector.mem
		self.trace = mem.get("aDist")[wp].trace
		self.gng = gng.GNG(anomalydetector.dimension)
	
	#update catches the analyzer up to the state of the input ADist object.
	def update(self):
		while len(self.trace.values) > self.numUpdates:
			vector = [pair[0] for pair in self.trace.values[self.numUpdates]]
			self.gng.update(vector)
			self.numUpdates += 1
	
	def nodes(self):
		return self.gng.nodes
	
			
