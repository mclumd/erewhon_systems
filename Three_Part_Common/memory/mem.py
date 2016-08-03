
knowledge = {}

#Handles structs with custom update methods, dict update by dict or tuple, list append, and simple assignment.
def _update(structname, val):
	if not structname in knowledge:
		knowledge[structname] = val
	elif knowledge[structname].__class__.__name__ == "dict":
		if val.__class__.__name__ == "dict":
			knowledge[structname].update(val) #update dict with dict
		elif len(val) == 2:
			knowledge[structname][val[0]] = val[1] #update dict with tuple
	elif hasattr(knowledge[structname], "update"):
		knowledge[structname].update(val) #generic update
	elif hasattr(knowledge[structname], "append"):
		knowledge[structname].append(val) #so lists can be structs
	else:
		knowledge[structname] = val #assignment

def update(args):
	for structname, val in args.items():
		_update(structname, val)

def update_all(structname, val):
	if structname in knowledge and (not isinstance(knowledge[structname], basestring)):
		struct = knowledge[structname]
		if hasattr(struct, "__getitem__") or hasattr(struct, "__iter__"):
			for item in struct:
				if hasattr(item, "update"):
					item.update(val)
		elif hasattr(struct, "update"):
			struct.update(val)

def _clear(structname):
	if structname in knowledge:
		del knowledge[structname]

def clear():
	knowledge.clear()

def _init(structname, val):
	_clear(structname)
	_update(structname, val)

def init(args):
	clear()
	update(args)

def get(structname):
	if structname in knowledge:
		return knowledge[structname]
	return None
