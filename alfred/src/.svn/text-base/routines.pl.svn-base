/* this file should contain the prolog code that alma can use */

:- ensure_loaded(library(caseconv)).
:- ensure_loaded(library(sets)).
:- ensure_loaded(library(random)).

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
    atom_chars(ID, NumList),
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

discard_duplicates(Nums, Parse_state) :-
af(test1(Nums, Parse_state)),
    sort(Nums, [First | _]),
af(test2(Nums, First)),
    name_to_formula(First, Formula),
af(test3(Nums, First, Formula)),
    discard_duplicates2(Formula, Parse_state).

discard_duplicates2([Formula], Parse_state) :-
    arg(2, Formula, Parse_state).

get_lf_ids([Formula | Rest], Phrase_list,  LF_List) :-
    arg(3, Formula, Phrase_id),
    get_lf_ids(Rest, [Phrase_id | Phrase_list], LF_List).

get_lf_ids([], Phrase_list, LF_list) :-
    sort(Phrase_list, LF_list).

gather_lexids_from_set([Formula | Rest], List) :-
    arg(4, Formula, LexID),
    gather_lexids_from_set(Rest, [LexID | List]).

gather_lexids_from_set([], List) :-
    List.
    
argument(Num, Formula, Answer) :-
    arg(Num, Formula, Answer).

equal_string(String1, String2) :-
    String1 == String2.

not_equal_string(String1, String2) :-
    String1 \== String2.

two_lists_to_set(List1, List2, Set) :-
    append(List1, List2, List3),
    remove_dups(List3, Set1),
    sort(Set1, Set).

cappend_num_to_string(A, Num, Result) :-
    concat_atom([A, Num],Result).
    
cappend_string(A, B, Result) :-
    string_append(A, B, Result).

cchars_to_atoms(Chars_list, Atom_string) :-
    atom_chars(Atom_string, Chars_list).

cappend_list(A_list, B_list, Result) :-
    append(A_list, B_list, Result).

is_not_empty(A) :-

af(test_is_not_empty(A)),
    length(A, Len),
af(test_is_not_empty(A, Len)),
    Len > 0.

is_empty(A) :-
    length(A, Len),
    Len =:= 0.

add(X,Y,Z) :-
    Z is X + Y.
    
randomID(X) :-
    random(1, 10000, Y),
    number_chars(Y, NumList),
    atom_chars(X, NumList).

delete_first([X|_]) :-
    df(X).
