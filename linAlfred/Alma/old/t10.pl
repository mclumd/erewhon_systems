% t10.pl
% tests for iif
%
% intention is to run a step, then add not(p(a)) which will retract p(a)
% and then we should not get anything printed.

p(a).
if(p(X), q(X)).
if(q(X), r(X)).
if(r(X), s(X)).
iif(and(s(X), p(X)), call(format('Got s(~a) and p(~a)~n', [X, X]))).



