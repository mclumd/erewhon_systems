/*
Unify DAGs
*/

unification_dags(Utt, State1, State2, Dag1,Dag2) :- 
    af(trying(Dag1, Dag2)),
    unify0(Dag1, Dag2),
    af(unified_dags(Utt, State1, State2, Dag1)).

unify0(Dag, Dag) :- !.

unify0([Feature:Value|Rest],Dag) :-   
    af(trying_to2(Dag)),
    val(Feature,Value,Dag,StripDag),    
    unify0(Rest,StripDag).
 
val(Feature,Value1,[Feature:Value2|Rest],Rest) :-
    !,
    unify0(Value1,Value2).
val(Feature,Value,[Dag|Rest],[Dag|NewRest]) :-
    !,
    val(Feature,Value,Rest,NewRest).

