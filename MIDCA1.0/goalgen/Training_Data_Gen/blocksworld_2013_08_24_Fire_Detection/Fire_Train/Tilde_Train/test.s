load(models).
prune_rules(false).
use_packs(ilp).
%use_package(huge_chunks).
%huge(on).

classes([scen_001, scen_002]).

rmode(clear(+-Obj)).
rmode(table(+-Obj)).
rmode(triangle(+-Obj)).
rmode(square(+-Obj)).
rmode(on(+-Obj,+-Obj2)).
rmode(onfire(+-Obj)).

lookahead(on(X,Y),clear(X)).
lookahead(on(X,Y),clear(Y)).
lookahead(on(X,Y),table(X)).
lookahead(on(X,Y),table(Y)).
lookahead(on(X,Y),triangle(X)).
lookahead(on(X,Y),triangle(Y)).
lookahead(on(X,Y),square(X)).
lookahead(on(X,Y),square(Y)).
lookahead(on(X,Y),onfire(X)).
lookahead(on(X,Y),onfire(Y)).

lookahead(clear(X), on(X,Y)).
lookahead(triangle(X), on(X,Y)).
lookahead(square(X), on(X,Y)).
lookahead(table(X), on(X,Y)).
lookahead(onfire(X), on(X,Y)).

lookahead(clear(Y), on(X,Y)).
lookahead(triangle(Y), on(X,Y)).
lookahead(square(Y), on(X,Y)).
lookahead(table(Y), on(X,Y)).
lookahead(onfire(Y), on(X,Y)).

lookahead(on(X,Y), on(Y,Z)).

max_lookahead(4).



