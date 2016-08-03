/*Subsumption: checks to see if first DAG is
  subsumed by second DAG. If it is, it returns true.*/

inst_vars(F) :-
        inst_vars0(F,v(0),_).
 
inst_vars0(F,I,v(I)) :-
        var(F),!,
        F = I.
inst_vars0([],I,I) :- !.
inst_vars0([H|T],I,IOut) :- !,
        inst_vars0(H,I,I0),
        inst_vars0(T,I0,IOut).
inst_vars0(_F:V,I,IOut) :- !,
        inst_vars0(V,I,IOut).
inst_vars0(_,I,I).

subsumes(F1, F2) :-
        \+ (inst_vars(F2),
            \+ (unify0(F1,F2))).



