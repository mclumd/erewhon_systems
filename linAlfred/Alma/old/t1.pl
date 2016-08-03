% test file

forall(X, if(p(X), q(X))).
forall(X, if(and(q(X), r(X)), s(X))).
p(a).
p(b).
forall(X, r(X)).
if(s(a), call(format('Got s(a)~n', []))).


