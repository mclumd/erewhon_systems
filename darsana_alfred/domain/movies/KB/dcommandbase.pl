isa(dcommand, 'play').

structure('play', 
	[[v0,v1,'O']], 
	[[v0,verb], [v1,movie]],
	[v0,v1]).

structure('play', 
	[[v0,v1,'O'],[v0,v3,'O']], 
	[[v0,verb], [v1,movie], [v2, conjunct], [v3, movie]],
	[v0,v1,v3]).

isa(dcommand, 'fullscreen').

structure('fullscreen', 
	[], 
	[[v0,verb]],
	[v0]).


isa(dcommand, 'stop').

structure('stop', 
	[], 
	[[v0,verb]],
	[v0]).

isa(dcommand, 'set').

structure('set', 
	[[v0,v1,'O'], [v0,v2,'MV'], [v2,v3,'J']], 
	[[v0,verb], [v1, parameter], [v2, end], [v3, number]],
	[v0,v1,v3]).


isa(dcommand, 'list').

structure('list', 
	  [], 
	  [[v0,verb]],
	  [v0]).

structure('list', 
	  [[v0,v1,'O']], 
	  [[v0,verb]],
	  [v0]).

isa(dcommand, 'mute').

structure('mute', 
	[], 
	[[v0,verb]],
	[v0]).






