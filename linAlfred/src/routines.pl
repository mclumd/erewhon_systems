/* this file should contain the prolog code that alma can use */

:- ensure_loaded(library(caseconv)).
:- ensure_loaded(library(sets)).

/*:- consult('readdata.pl').
:- consult('domain.pl').
:- consult('introspectmatch.pl').
*/



unique_id(IDList) :-
   pos_int_u(curMaxUniqueID(Num)),
   df(curMaxUniqueID(Num)),
   createUniqueIDs(Num, IDList).

createUniqueIDs(Num,[]):-
    af(curMaxUniqueID(Num)).

createUniqueIDs(Num, [ID|IDList]) :-
    NewNum is Num + 1,
    number_chars(Num, NumList),
    append([105, 106], NumList, List),
    atom_chars(ID, List),
    createUniqueIDs(NewNum, IDList).
    
mult_gather_all([S|Schemae],Asserts) :-
    gather_all(S,Asserts1),
    mult_gather_all(Schemae,Asserts2),
    append(Asserts1,Asserts2,Asserts).

mult_gather_all([],[]).


idling_for_steps(Steps):-
    step_number(CurNow),
    idling_for_past(CurNow, Steps).

idling_for_past(Current,Steps) :-
    Prev is Current - 1,
    clause(idling_step(Prev), true),
    Count is Steps - 1,
    idling_for_past(Prev, Count).
idling_for_past(_,0).


delete_expect_lists([List|Lists]) :-
    df(expect_list(List)),
    delete_expect_lists(Lists).
delete_expect_lists([]).

satisfied_expects(Utt) :-
    gather_all(expect(Utt,_), EList),
    gather_all(satisfied(Utt, _), SList),
    length(EList,L),
    length(SList,L).

satisfied_needs(Utt) :-
    gather_all(need(Utt,_), NList),
    gather_all(satisfied(Utt, _), SList),
    length(NList,L),
    length(SList,L).

thought(Utt,Need, Asserts):-
    pos_int_u(done(ac_think(Utt, Need), Asserts,Utt)).

thinking(Utt,Need, Asserts):-
    pos_int_u(doing(ac_think(Utt, Need), Asserts,Utt)).

asked(Utt,Need, Asserts):-
    pos_int_u(done(ac_ask(Utt, Need), Asserts,Utt)).

asking(Utt,Need, Asserts):-
    pos_int_u(doing(ac_ask(Utt, Need), Asserts,Utt)).

sending_to_domain(MySocket, String) :-
    tcp_output_stream(MySocket, Stream),
    print(Stream, String), nl(Stream) , nl(Stream), 
    format(Stream, '~N',[]).

equal_numbers(Num1, Num2) :-
    Num1 =:= Num2.















