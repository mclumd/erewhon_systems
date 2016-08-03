def get_pred_names(world):
	return sorted(world.predicates.keys())

def get_pred_counts(world):
	counts = {}
	for name in get_pred_names(world):
		counts[name] = 0
	for atom in world.atoms:
		counts[atom.predicate.name] += 1
	return counts

def get_count_vector(world):
	counts = get_pred_counts(world)
	vector = []
	for name in get_pred_names(world):
		vector.append(counts[name])
	return vector
