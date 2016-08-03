% Note: we do not get q(b)

forall(X, bif(p(X), q(X))).
p(a).
if(q(a), p(b)).
bs(q(X)).

forall(X, if(q(X), call(format('q(~a)~n', X)))).