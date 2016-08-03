
states = []

def update(world):
	states.append(world)

def get_state(time):
	return states[time]

def get_states(start, end):
	return states[start:end + 1]