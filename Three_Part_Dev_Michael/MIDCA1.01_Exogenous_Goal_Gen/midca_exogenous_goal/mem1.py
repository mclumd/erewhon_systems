import datetime


class Val:
	
	def __init__(self, val):
		self.val = val
	
	def __hash__(self):
		return hash(self.val)
	
	def is_instance(self, typeval):
		if hasattr(typeval, "val"):
			return self.val.implements(typeval.val)
		elif hasattr(typeval, "set"):
			for item in typeval.set:
				if is_instance(self, item):
					return True
			return False
		elif hasattr(typeval, "range"): 
			return False
	
	def __eq__(self, other):
		if hasattr(other, "val"):
			return self.val == other.val
		elif hasattr(other, "set"):
			return len(other) == 1 and self in other
		elif hasattr(other, "range"): 
			return len(other) == 1 and self in other
	
	def __contains__(self, other):
		return self == other
	
	def overlaps(self, other):
		return self in other

#ranges are inclusive
class ValRange:
	
	def __init__(self, start, end):
		if end < start:
			raise ValueError("A range's end must come at or after its start.")
		self.range = (start, end)
	
	def __hash__(self):
		return hash(self.range)
	
	def __len__(self):
		return self.range[1] - self.range[0] + 1
	
	def __eq__(self, other):
		return hasattr(other, "range") and other.range == self.range
	
	def __contains__(self, other):
		if hasattr(other, "val"):
			return self.range[0] <= other.val <= self.range[1]
		elif hasattr(other, "range"):
			return self.range[0] <= other.range[0] and self.range[1] >= other.range[1]
		elif hasattr(other, "set"):
			for val in other.set:
				if not val in self:
					return False
			return True
		else:
			return False
	
	def overlaps(self, other):
		if hasattr(other, "val"):
			return other in self
		elif hasattr(other, "range"):
			return other.range[0] in self or other.range[1] in self
		elif hasattr(other, "set"):
			for val in other.set:
				if val in self:
					return True
			return False
		else:
			return False

class ValSet:
	
	def __init__(self, vals):
		self.set = set(vals)
	
	def __len__(self):
		return len(self.set)
	
	def __eq__(self, other):
		if hasattr(other, "val"):
			return self.contains(other) and len(self) == 1
		elif hasattr(other, "range"):
			return len(self) == 1 == len(other) and self in other
		elif hasattr(other, "set"):
			return self.set == other.set
	
	def __contains__(self, other):
		if hasattr(other, "val"):
			return other in self.set
		elif hasattr(other, "range"):
			return len(other) == 1 and other.range[0] in self
		elif hasattr(other, "set"):
			for val in other.set:
				if val not in self:
					return False
			return True
	
	def overlaps(self, other):
		if hasattr(other, "val"):
			return other in self
		elif hasattr(other, "range"):
			for val in self.set:
				if val in other:
					return True
			return False
		elif hasattr(other, "set"):
			for val in other.set:
				if val in self:
					return True
			return False

STARTTIME = 0.0

class Result:
	
	TRUE = "true"
	FALSE = "false"
	DISPUTED = "disputed"
	UNKNOWN = "unknown"
	
	def __init__(self):
		self.val = self.UNKNOWN
	
	def update(self, fact, truefalse):
		if truefalse:
			if self.val == "unknown":
				self.val = [(True, fact)]
			else:
				self.val.append([True, fact])
		else:
			if self.val == "unknown":
				self.val = [(False, fact)]
			else:
				self.val.append([False, fact])
	
	def get_result(self):
		if self.val == self.UNKNOWN:
			return self.UNKNOWN
		else:
			reported = [res[0] for res in self.val]
			if True in reported and False in reported:
				return self.DISPUTED
			elif True in reported:
				return self.TRUE
			elif False in reported:
				return self.FALSE
			return self.UNKNOWN #though this should never happen.

class TruthCheck:
	
	def __init__(self, fact, time = None):
		self.fact = fact
		self.time = time
		self.result = Result()
		self.relevantmems = []
		self.memschecked = []
		self.memsgathereduntil = STARTTIME
		#factsgathereduntil refers to the most recent time at which all relevant memories have been gathered (the time of memory formation, that is). Therefore, get_relevant_facts() need only check memories formed after this time.
	
	def get_relevant_mems(self, maxtime):
		#get relevant facts from mem. mem will need to be in constructor or a constant in this module. Do not spend more than maxtime accessing facts.
		starttime = datetime.datetime.today()
		facts = []
		while (datetime.datetime.today() - starttime).total_seconds() < maxtime:
			pass
			#one step of fact acquisition. Should be large enough to avoid spending too much time checking the time, but small enough to break off within a fraction of a second.
	
	def evaluate_relevant_facts(self, maxtime):
		starttime = datetime.datetime.today()
		while (datetime.datetime.today() - starttime).total_seconds() < maxtime and len(self.relevantmems) > len(self.memschecked):
			#one step of fact evaluation. Update result as discovered, but cease evaluation only if time is reached or all relevant facts have been examined.
			self.memschecked = []
			if self.time:
				while len(self.relevantmems) > len(self.memschecked):
					nextmem = self.relevantmems[len(self.memschecked)]
					self.memschecked.append(nextmem)
					#first, check if times match up
					if nextmem.true_at(self.time):
						if self.fact.same_knowledge(nextmem.fact):
							self.result.update(nextmem, not self.fact.opposite(nextmem.fact))
			else:
				pass #figure out times when fact is proven/disproven. This should be returned as a set of times, possibly including 1 or more ranges. Actually, it might be unecessary to do anything more than return the memories, since they contain time information. Think about this.
			

def check_true(fact, time = None):
	if time:
		#check memory structures to see if fact is known to be true at time t
		pass
	else:
		#return all times at which fact is known to be true
		pass

def for_all_times(fact, times):
	if hasattr(times, "range"):
		rangesleft = [times]
		#access memory structures; updates rangesleft until all memory has been checked or rangesleft is empty.
	elif hasattr(times, "set"):
		pass
	#access memory structures to determine if true

#Attr is the type of which Attributes are instances.
class Attr:
	
	def __init__(self, name):
		self.name = name
	

class Attribute:
	
	def __init__(self, attr, id, valrange):
		self.attr = attr
		self.id = id
		self.valrange = valrange
	
	def implements(self, other):
		self.attr == other.attr and self.valrange in other.valrange
		
	def consistent(self, other):
		return self.implements(other) or other.implements(self)

		
class TypeKeyMem:
	
	def __init__(self):
		self.mem = {}
	
	def add_memory(self, type, mem):
		try:
			self.mem[type].append(mem)
		except KeyError:
			self.mem[type] = [mem]
	
	def get(self, type):
		try:
			return self.mem[type]
		except KeyError:
			return []
	

class Memory:
	
	def __init__(self, timeformed, timetrue, fact, etiology):
		self.timeformed = timeformed
		self.timetrue = timetrue
		self.fact = fact
		self.etiology = etiology
	
	def true_at(self, time):
		if hasattr(time, "val") or hasattr(time, "range") or hasattr(time, "set"):
			return time in self.timetrue
		else:
			time = Val(time)
			return time in self.timetrue
		return False


CONTAINS = " contains "
CONTAINED_BY = " is in "
INTERSECTS = " shares a value with "
EQUALS = " is "
INSTANCE = " is an instance of "

HAS_N_VALUES = " has n values. n = " 
#for above, usually n = 1, e.g. "car.speed has n values. n = 1" However, could be "deck.cards has n values. n = 52."

class KnowledgePiece:
	
	def __init__(self):
		raise NotImplementedError("KnowledgePiece is an abstract class.")
	
	def same_knowledge(self, other):
		try:
			if type(self) != type(other):
				return False
			for attrname in self.identityattrs:
				if not hasattr(other, attrname) or getattr(self, attrname) != getattr(other, attrname):
					return False
			return True
		except AttributeError:
			raise NotImplementedError("Subclasses of KnowledgePiece must define self.identityattrs for identity comparisons")
	
	def opposite(self, other):
		try:
			return self.truefalse != other.truefalse
		except AttributeError:
			raise NotImplementedError("Subclasses of KnowledgePiece must define self.truefalse for identity comparisons")
	
	def __eq__(self, other):
		return self.same_knowledge(other) and not self.opposite(other)

#An instantiation of this class is a fact about one attribute of a specific object. This should automatically generate an InstanceAttr piece of knowledge that the referenced object has the referenced attr.
class InstanceFact(KnowledgePiece):
	
	identityattrs = ["object", "attr", "val", "relation"]
	
	def __init__(self, object, attr, val, relation, truefalse, etiology):
		self.object = object
		self.attr = attr
		self.val = val
		self.relation = relation
		self.truefalse = truefalse
		self.etiology = etiology
	

#An instantiation of this class is a declaration that a specific object has or does not have a specific attribute. e.g. "car1 does not have attr emotionalmaturity", "car1 has attr set[frontrighttire, frontlefttire,....]"
class InstanceAttr(KnowledgePiece):
	
	identityattrs = ["object", "attr"]
	
	def __init__(self, object, attr, truefalse, etiology):
		self.object = object
		self.attr = attr
		self.truefalse = truefalse
		self.etiology = etiology

#same as instancefact, but for a type. Additional information: how consistent is this fact?
class TypeFact(KnowledgePiece):
	
	identityattrs = ["type", "attr", "val", "relation", "consistency"]
	
	def __init__(self, type, attr, val, relation, consistency, truefalse, etiology):
		self.type = type
		self.attr = attr
		self.val = val
		self.relation = relation
		self.consistency = consistency
		self.truefalse = truefalse
		self.etiology = etiology

#same as InstanceAttr, but for a type. Additional information: how consistently does an instance have (or not have) this attr?
class TypeAttr(KnowledgePiece):
	
	identityattrs = ["type", "attr", "consistency"]
	
	def __init__(self, type, attr, truefalse, consistency, etiology):
		self.type = type
		self.attr = attr
		self.truefalse = truefalse
		self.consistency = consistency
		self.etiology = etiology

#An instance is or is not a member of a type. Caveats refers to unchecked attributes, e.g. "It seems like obj3 is a cat because it has four legs and is furry, but I have not yet checked whether it purrs or can use a litterbox, so I am not sure." [Presumably, the same obj3 could also be classified as a dog, with caveats about barking, etc.]
class InstClassification(KnowledgePiece):
	
	identityattrs = ["object", "type", "caveats"]
	
	def __init__(self, object, type, truefalse, caveats, etiology):
		self.object = object
		self.type = type
		self.truefalse = truefalse
		self.caveats = caveats
		self.etiology = etiology

#same as InstClassification, but for a type. e.g. "A cat is probably a mammal because it has fur and breathes air. However, I have not yet checked whether cats who are mothers suckle their children during the time when their children are young, so I cannot be sure."
class TypeClassification(KnowledgePiece):
	
	identityattrs = ["type", "parenttype", "caveats"]
	
	def __init__(self, type, parenttype, truefalse, caveats, etiology):
		self.object = object
		self.type = type
		self.truefalse = truefalse
		self.caveats = caveats
		self.etiology = etiology

#e.g. the type items in personx's "vehicles" attr is "Car." 
class InstanceAttrType(KnowledgePiece):
	
	identityattrs = ["object", "attr", "type"]
	
	def __init__(self, object, attr, type, truefalse, etiology):
		self.object = object
		self.attr = attr
		self.type = type
		self.truefalse = truefalse
		self.etiology = etiology

#e.g. an eye's color is type "color" 
class TypeAttrType(KnowledgePiece):
	
	identityattrs = ["type", "attr", "attrtype"]
	
	def __init__(self, type, attr, attrtype, truefalse, etiology):
		self.type = type
		self.attr = attr
		self.attrtype = attrtype
		self.truefalse = truefalse
		self.etiology = etiology

#Not to be confused with the above. This refers to the attribute's type, not the type of the attribute's value. e.g., mike.car is of type "ownership" (which presumably implies that mike can use his car without legal or social repurcushions stemming from theft, etc.)
class AttrTypeOfObj(KnowledgePiece):
	
	identityattrs = ["obj", "attr", "type"]
	
	def __init__(self, obj, attr, type, truefalse, etiology):
		self.obj = obj
		self.attr = attr
		self.type = type
		self.truefalse = truefalse
		self.etiology = etiology

#Like AttrTypeOfObj, but for an attribute of a type
class AttrTypeOfType(KnowledgePiece):
	
	identityattrs = ["type", "attr", "attrtype"]
	
	def __init__(self, type, attr, attrtype, truefalse, etiology):
		self.type = type
		self.attr = attr
		self.attrtype = attrtype
		self.truefalse = truefalse
		self.etiology = etiology

class Conditional(KnowledgePiece):
	
	identityattrs = ["cond", "res", "samevars"]
	
	def __init__(self, vars, cond, res, truefalse, etiology):
		self.vars = vars
		self.cond = cond
		self.res = res
		self.truefalse = truefalse
		self.etiology = etiology

class MPChecker:
	
	def __init__(self, conditional):
		
	
class Object:
	pass

class Type:
	pass


facts = []
IN = Attr("in")
dog = Object()
street = Object()
facts.append(Memory(Val(0.0), ValRange(3.0, 6.0), InstanceFact(dog, IN, street, EQUALS, True, None), None))

check = TruthCheck(InstanceFact(dog, IN, street, EQUALS, False, None), Val(2))
check.relevantmems = facts
check.evaluate_relevant_facts(0.5)
print check.result.val


class Memory:
	
	def __init__(self, args = {}):
		self.knowledge = {}
		self.clear()
		self.update(args)

	#Handles structs with custom update methods, dict update by dict or tuple, list append, and simple assignment.
	def _update(self, structname, val):
		if not structname in self.knowledge:
			self.knowledge[structname] = val
		elif self.knowledge[structname].__class__.__name__ == "dict":
			if val.__class__.__name__ == "dict":
				self.knowledge[structname].update(val) #update dict with dict
			elif len(val) == 2:
				self.knowledge[structname][val[0]] = val[1] #update dict with tuple
		elif hasattr(self.knowledge[structname], "update"):
			self.knowledge[structname].update(val) #generic update
		else:
			self.knowledge[structname] = val #assignment
	
	def _add(self, structname, val):
		if not structname in self.knowledge:
			self.knowledge[structname] = [val]
		elif hasattr(self.knowledge[structname], "append"):
			self.knowledge[structname].append(val)
		else:
			self.knowledge[structname] = [self.knowledge[structname], val]
	
	def update(self, args):
		for structname, val in args.items():
			self._update(structname, val)
	
	def update_all(self, structname, val):
		if structname in self.knowledge and (not isinstance(self.knowledge[structname], basestring)):
			struct = self.knowledge[structname]
			if hasattr(struct, "__getitem__") or hasattr(struct, "__iter__"):
				for item in struct:
					if hasattr(item, "update"):
						item.update(val)
			elif hasattr(struct, "update"):
				struct.update(val)
	
	def _clear(self, structname):
		if structname in self.knowledge:
			del self.knowledge[structname]
	
	def clear(self):
		self.knowledge.clear()
	
	def _init(self, structname, val):
		_clear(structname)
		_update(structname, val)
	
	def get(self, structname):
		if structname in self.knowledge:
			return self.knowledge[structname]
		return None
