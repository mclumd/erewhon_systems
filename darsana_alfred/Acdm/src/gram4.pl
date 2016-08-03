% -*-mode: prolog -*-

:- module(gram4, [tokenizer/2, parser/2, plizer/3]).

:- ensure_loaded(library(ctypes)).
:- ensure_loaded( library(lineio)).
:- ensure_loaded( library(lists)).
:- ensure_loaded(library(caseconv)).


test:-
        get_a_line(user_input,[],X,0),!,
%get_line(X, _),
        tokenizer(X, Y),
	write(Y),nl,
	parser(Y,Z),!,
	write(Z),nl,
	pparser(Z,A),
	myprint(A),nl.



test1:-
        get_a_line(user_input,[],X,0),        
        myprint(X),nl.

write_line(_, []):- nl,flush_output(user_output),!.
write_line(S, [X|R]):-
	put(S, X),
	write_line(S, R).

myprint([]).
myprint([],_).
myprint([A|B]) :-
myprint([A|B],0).
myprint([A|B],N) :-
N < 70,
put(A),
N1 is N+1,
myprint(B,N1).
myprint([A|B],70) :-
put(A),nl,
myprint(B,0).

test2:-
        repeat,
        get_a_line(user_input,[],X,0),
        tokenizer(X, Y),
	plizer(Y, _, Z),
        print(Z),nl,
        fail.

%taken from bpostow's tweedledee
get_a_line(Stream, Less, More) :- get_a_line(Stream,Less,More, 0).

get_a_line(Stream,Less,More, NUM) :- 
	    (get0(Stream, Char),
	    
	    (Char = 40 -> (append(Less, [Char] , Lesser), 
	                  NN is NUM + 1,  
			  get_a_line(Stream, Lesser, More, NN));
	    (Char = 41  -> (NN is NUM - 1,
	                    (NN =< 0 -> append(Less, [Char] , More);
			    append(Less, [Char] , Lesser), 
			    get_a_line(Stream, Lesser, More, NN))));
	    (Char = 42 -> get_a_line(Stream,Less,More, NUM));
	    ((Char = 10, NUM = 0) -> fail;
	    (Char = 10 -> get_a_line(Stream,Less,More, NUM);
		(append(Less, [Char], Lesser),
		get_a_line(Stream, Lesser, More, NUM)))))).


parser(In,Out) :- list(In,Out,[]).

list(In,Out,Rest) :- 
lb(In,_,Rest1), term(Rest1,Out,Rest2), rb(Rest2,_,Rest), !.

lb(['_['|Rest],'_[',Rest).
rb(['_]'|Rest],'_]',Rest).

term([Out1|Rest1],Out,Rest) :- 
Out1 \== '_[',
Out1 \== '_]',
term(Rest1,Out2,Rest), 
Out = [Out1|Out2].

%term always returns a list of terms encountered, some of which could be lists
term([Out|Rest],[Out],Rest) :- 
Out \== '_[',
Out \== '_]'.

term(In,Out,Rest) :- 
list(In,Out1,Rest1),
term(Rest1,Out2,Rest), 
Out = [Out1|Out2].

term(In,[Out],Rest) :- 
list(In,Out,Rest).

%reverse parse a prolog term into KQML-compliant strings
pparser(In,Out) :- 
%if string
pstring(In,Out,Rest);
%if list
plist(In,Out,[]);
%if atom
atom(In) -> patom(In,Out,Rest);
%if number
number(In) -> pnumber(In,Out,Rest).

%we assume that a list will begin with a digit or "?"
%IFF the list is a string
pstring([X|Xs],[X|Xs],Rest) :-
number(X).

plist([X|Xs],Out,Rest) :- 
plist1([X|Xs],Out1,Rest),
append(["(",Out1,")"],Out).

plist1([X|Xs],Out,Rest) :- 
pparser(X,Out1),
plist1(Xs,Out2,Rest),
(Out2 == [] -> Out = Out1;
 append(_,[41],Out1) -> append([Out1,Out2],Out);
append([Out1," ",Out2],Out)).
plist1([],[],Rest).

patom(In,Out,[]) :-
atom_chars(In,Out).

pnumber(In,Out,[]) :-
number_chars(In,Out).

% new tokenizer
tokenizer([], []) :- !.
tokenizer([40|R], ['_['|Rt]):- !,		  % (
    tokenizer(R, Rt).
tokenizer([41|R], ['_]'|Rt]):- !,		  % )
    tokenizer(R, Rt).
tokenizer([32|R], Rt):-	!,			  % space
    tokenizer(R, Rt).
tokenizer([58|R], [X|Rt]):- !,		  % key
    get_word(R, [], X, Rr),
    tokenizer(Rr, Rt).
tokenizer([34|R], [string(X)|Rt]):- !,		  % string
    get_string(R, [], X, Rr),
    tokenizer(Rr, Rt).
tokenizer(R, [X|Rt]):- !,
    get_word(R, [], X, Rr),
%(X1 = '.' -> X = []);
%X = X1,
    tokenizer(Rr, Rt).


/*
% old tokenizer
tokenizer([], []) :- !.
tokenizer([40|R], ['_lp_'|Rt]):- !,		  % (
    tokenizer(R, Rt).
tokenizer([41|R], ['_rp_'|Rt]):- !,		  % )
    tokenizer(R, Rt).
tokenizer([32|R], Rt):-	!,			  % space
    tokenizer(R, Rt).
tokenizer([58|R], [X|Rt]):- !,		  % key
    get_word(R, [], X, Rr),
    tokenizer(Rr, Rt).
tokenizer([34|R], [string(X)|Rt]):- !,		  % string
    get_string(R, [], X, Rr),
    tokenizer(Rr, Rt).
tokenizer(R, [X|Rt]):- !,
    get_word(R, [], X, Rr),
    tokenizer(Rr, Rt).
*/

plizer(['_lp_', word(X) | R], Rest, Term):- !,
    pl_term([word(X) |R], Rest, [], Term).
plizer(['_lp_' | R], Rest, Term):- !,
    pl_list(R, Rest, [], Term).
plizer([key(X), key(Y)|R], [key(Y)|R], key(X)):- !.
plizer([key(X), '_rp_'|R], ['_rp_'|R], key(X)):- !.
plizer([key(X)|R], Rest, key(X, Y)):- !,
    plizer(R, Rest, Y).
plizer([word(X)|R], R, X):- !.
plizer([X|R], R, X):- !.

pl_term([], [], I, T):- !,
    T=..I.
pl_term([word(X)|R], Rest, L, Term):- !,
    append(L, [X], LX),
    pl_term(R, Rest, LX, Term).
pl_term(['_rp_'|R], R, L, Term):- !,
    Term=..L.
pl_term([XX|R], Rest, L, Term):- !,
    plizer([XX|R], Re, Term2),
    append(L, [Term2], Lt),
    pl_term(Re, Rest, Lt, Term).

pl_list(['_rp_'|R], R, L, L):- !.
pl_list(X, R, L, Term):-
    plizer(X, R2, T),
    append(L, [T], Lt),
    pl_list(R2, R, Lt, Term).


get_word([40|R], I, W, [40|R]):- !,
    name(W, I).
get_word([41|R], I, W, [41|R]):- !,
    name(W, I).
get_word([32|R], I, W, [32|R]):- !,
    name(W, I).
get_word([58|R], I, W, [58|R]):- !,
    name(W, I).
get_word([I|R], Init, W, Rr):- !,
    (upper([I]) ->
    (to_lower(I, Is),
    append(Init, [Is], II));
    append(Init, [I], II)),
    get_word(R, II, W, Rr).
get_word(A, S, D, F):- print('Failure:'), nl, 
    print(A), nl, print(S), nl, print(D), nl, print(F), nl.

get_string([34|R], I, W, R):- !,
    name(W, I).
get_string([I|R], Init, W, Rr):- !,
    append(Init, [I], II),
    get_string(R, II, W, Rr).







%============================================================
/*
examples.

(TELL :CONTENT
 (SA-REQUEST :FOCUS :V11621 :OBJECTS
  ((:DESCRIPTION (:STATUS :NAME) (:VAR :V11573) (:CLASS :CITY)
    (:LEX :COLUMBUS) (:SORT :INDIVIDUAL))
   (:DESCRIPTION (:STATUS :DEFINITE) (:VAR :V11584) (:CLASS :TRAIN)
    (:SORT :INDIVIDUAL) (:CONSTRAINT (:ASSOC-WITH :V11584 :V11573)))
   (:DESCRIPTION (:STATUS :NAME) (:VAR :V11621) (:CLASS :CITY)
    (:LEX :RICHMOND) (:SORT :INDIVIDUAL)))
  :PATHS ((:PATH (:VAR :V11613) (:CONSTRAINT (:TO :V11613 :V11621))))
  :DEFS NIL :SEMANTICS
  (:PROP (:VAR :V11560) (:CLASS :MOVE)
   (:CONSTRAINT
    (:AND (:LSUBJ :V11560 :*YOU*) (:LOBJ :V11560 :V11584)
     (:LCOMP :V11560 :V11613))))
  :NOISE NIL :SOCIAL-CONTEXT NIL :RELIABILITY 100 :MODE KEYBOARD
  :SYNTAX ((:SUBJECT . :*YOU*) (:OBJECT . :V11584)) :SETTING NIL :INPUT
  (SEND THE COLUMBUS TRAIN TO RICHMOND))
 :RE 1)




*/


