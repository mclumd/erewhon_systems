isa(dcommand, 'switch').
structure('switch', 
	[[v0,v1,'MV'], [v1,v2,'J']],  
	[[v0,verb], [v1, status], [v2, equipment]],
	[v0,v1,v2]).

isa(dcommand, 'read').
structure('read', 
	[[v0,v1,'O']],  
	[[v0,verb], [v1, reading]],
	[v0,v1]).


