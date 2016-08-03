isa(dcommand, 'move').

structure('move', 
	[[v0,v1,'O'], [v0,v2,'MV'], [v2,v3,'J']], 
	[[v0,verb], [v1, position], [v2, end], [v3, position]],
	[[domain,[v0, v1,v3]]]).

