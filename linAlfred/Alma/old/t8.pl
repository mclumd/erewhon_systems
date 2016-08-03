
forall(X, forall(Y, if(and(p(X, Y), q(Y)), r(Y)))).
p(a, a).
p(a, b).
p(a, c).
forall(X, q(X)).
forall(X, if(r(X), call(format('~nr(~a)~n', X)))).

