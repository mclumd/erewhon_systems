% test file

forall(X, bif(p(X), q(X))).
p(a).
p(b).
bs(q(X)).
forall(X, if(q(X), call(format('q(~a)~n', X)))).



