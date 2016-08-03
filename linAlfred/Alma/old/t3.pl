% 

forall(X, bif(p(X), q(X))).			  % used for bs only

forall(X, if(bs(q(X)), s(X))).
p(a).
p(b).


forall(X, if(s(X), call(format('s(~a)~n', X)))).




