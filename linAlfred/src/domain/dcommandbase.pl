isa(dcommand, 'light').
structure('light', 
	[[v1,v2,'MV'], [v2,v4,'J'], [v3,v4,'AN']], 
	[[v1,verb], [v2, status], [v3, room], [v4, direction]],
	[[domain,[v1,v2, v3, v4]]]).

