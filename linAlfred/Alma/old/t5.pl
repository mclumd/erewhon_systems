% contras.

forall(X, if(p(X), q(X))).
p(a).
forall(X, not(q(X))).

forall(X, if(q(X), call(format('q(~a)~n', X)))).
forall(X, forall(Y, if(contra(X, Y), 
		       call(format('contra(~k, ~k)~n', [X, Y]))))).





