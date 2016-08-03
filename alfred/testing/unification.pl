/*
Unify DAGs
*/

/*op(500,xfy,:).*/

unification_dags(Dag1,Dag2) :- af(trying2(Dag1, Dag2)),
    unify_1([cat:np, num:sg | _], [cat:np | _]),
    unify0(Dag1, Dag2),
    af(unify_result(Dag1, Dag2)).

unify_1(Dag1, Dag2) :- unify0(Dag1, Dag2),
    af(done_unify_1(Dag1, Dag2)),
    unify_2(Dag1, [cat:np, abc:de | _]).


unify_2(Dag1, Dag2) :- af(doing_unify_2(Dag1, Dag2)),
    unify0(Dag1, Dag2),
    af(done_unify_2(Dag1, Dag2)).


/*    unify0(Dag1, Dag2),*/

/*unify0([cat:np, num:sg], [cat:np]),*/

unify0(Dag, Dag) :- !.

/*unify0(Dag1, Dag2) :- af(trying3(Dag1, Dag2)),
    !.
*/

unify0([Feature:Value|Rest],Dag) :-   
    af(trying_to(Dag)),
    val(Feature,Value,Dag,StripDag),    
    unify0(Rest,StripDag).
 
val(Feature,Value1,[Feature:Value2|Rest],Rest) :-
    !,
    unify0(Value1,Value2).
val(Feature,Value,[Dag|Rest],[Dag|NewRest]) :-
    !,
    val(Feature,Value,Rest,NewRest).

