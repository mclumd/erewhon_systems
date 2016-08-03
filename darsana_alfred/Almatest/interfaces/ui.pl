/*
File: interfaces/ui.pl
By: kpurang
What: various miscelaneous user level xommands

Todo: ?

*/


:- ensure_loaded(library(basics)).
:- compile([loop, addndel]).


% to modularize: af/2, af/1, df/1, s/1, s/0, q/1, std/0


% s(+number)
% runs number of steps
%:- ensure_loaded(library(date)).

% s
% runs one step


% q(+formula)
% is formula present in the current database?

% std
% show all theorems derived till now

% assert_new_nodes(+list of formulas, +priority for all of them)
% for each formula, make a node and assert it.
% load_forms(+Fname)
% Fname contains prolog formulas that are input as new nodes.
lf(Fname):-
    open(Fname, read, S),
    repeat,
    read(S, Term),
    (\+ Term = end_of_file ->
	 (af(Term)); true),
    Term = end_of_file, !,
    close(S).

increment_step:- 
    retract(step_number(X)), !,
    A is X + 1,
    assert(step_number(A)).

delete_bad_trees:- !,
    retract(tree_to_delete(T)),
    delete_each_tree(T),
    assert(tree_to_delete([])).
delete_each_tree([]):- !.
delete_each_tree([X|Y]):-
    find_node(X, NX),
    delete_bc_tree(NX),
    delete_each_tree(Y).
delete_each_tree([_|X]):- 
    delete_each_tree(X).

get_cpu_time(T) :- statistics(runtime,[T,_]).


handle_input(quit):- halt.
handle_input(X):- 
    on_exception(_, call(X), handle_call), !.

handle_call:- !,
    format('Error.~n', []).
    
   

print_history:-
    print_each_history(1), !.
print_each_history(I):-
    history(I, X), !,
    print('Step '), print(I), nl,
    print_history_formulas(X),
    J is I + 1,
    print_each_history(J).
print_each_history(_):- !.

print_history_formulas([]):- nl, !.
print_history_formulas([X|Y]):- !,
    print(X), nl,
    print_history_formulas(Y).

load_action_file(F):-
    slave_tag(false), !,
    load_files(F).

load_action_file(F):-
    slave_tag(Tag), !,
    tcp_send(Tag, load_actions(F)).
/*
connect_slave(SF):-
    (verbose(true) -> print('Connecting to slave'), nl; true),
    tcp_address_from_file(SF, Add),
    on_exception(Err, tcp_connect(Add, Tag), 
		 handle_no_connect(Err, SF)),!,
    retract(slave_tag(_)),
    assert(slave_tag(Tag)),
    print('Asserted slave '), print(Tag), nl.
connect_slave(_).
*/
%connect_slave(_):-
%    print('Cannot connect.'), nl, halt.

connect_slave(SF):-
    (verbose(true) -> print('Connecting to slave'), nl; true),
    really_connect(SF, Tag),
    retract(slave_tag(_)),
    assert(slave_tag(Tag)).
connect_slave(_).

connect_parser(SF):-
    (verbose(true) -> print('Connecting to slave'), nl; true),
    really_connect(SF, Tag),
    retract(parser_tag(_)),
    assert(parser_tag(Tag)).
connect_parser(_).

connect_domain(SF) :-
    (verbose(true) -> print('Connecting to domain'), nl; true),
    really_connect(SF, Tag),
    retract(domain_tag(_)),   
    assert(domain_tag(Tag)).
connect_domain(_).


connect_history(SF):-
    (verbose(true) -> print('Connecting to history'), nl; true),
    really_connect(SF, Tag),
    (verbose(true) -> (print('File: '), print(SF), print(' Socket: '), 
     print(Tag), nl); true),
    tcp_output_stream(Tag, Stream),
    (verbose(true) -> (print('Gotten Stream '), nl); true), 
    retract(history_dump(_)),
    assert(history_dump(true)),
    retract(history_stream(_)),
    assert(history_stream(Stream)),
    write_term(Stream, step(foo), [max_depth(0)]), nl(Stream),
    flush_output(Stream).
connect_history(_).


really_connect(SF, Tag):-
    unix(system('sleep 1')), print('Trying...'), nl,
    on_exception(_, tcp_address_from_file(SF, Add), no_taff(SF)),
    on_exception(_, tcp_connect(Add, Tag), really_connect(SF, Tag)).

really_disconnect:-
    disconnect_slave,
    disconnect_parser,
    disconnect_domain.

disconnect_slave:-
    retract(slave_tag(Tag)),
    ((Tag \== false,
      tcp_send(Tag, quit));
     true),
    assert(slave_tag(false)).

disconnect_parser:-
    retract(parser_tag(Tag)),
    ((Tag \== false,
      tcp_send(Tag, quit));
     true),
    assert(parser_tag(false)).

disconnect_domain:-
    retract(domain_tag(Tag)),
    ((Tag \== false,
      tcp_send(Tag, quit));
     true),
    assert(domain_tag(false)).


handle_no_connect(Err, SF):- !,
    print(Err), nl, print('Failed to connect. Retrying...'), nl,
    unix(system('sleep 1')),
    connect_slave(SF).
%    on_exception(Err2, connect_slave(SF), handle_no_connect(Err2, SF)).

no_taff(SF):-
    print('Cannot get tcp from file for '), print(SF), nl.


checklimits:- 
    timelimit(X), X < 0, !.
checklimits:- 
    memlimit(X), X < 0, !.
checklimits:- 
    timelimit(X), 
    statistics(runtime, [Y, _]),
    YY is Y / 1000,
    X > Y, !.
checklimits:- 
    timelimit(X), 
    statistics(runtime, [Y, _]),
    YY is Y / 1000,
    X < Y, print('Runtime limit.'), nl, 
    print(X), print(' '), print(YY), nl, halt.
checklimits:- 
    timelimit(X), 
    statistics(memory, [Y, _]),
    X > Y, !.
checklimits:- !,
    timelimit(X), 
    statistics(memory, [Y, _]),
    X < Y , print('Memory limit.'), nl, halt.
checklimits:- !.

do_almagenda([]):- !, true.
do_almagenda([T|X]):- !,
    on_exception(_, call(T), do_almagenda(X)),
    do_almagenda(X).

%
% cdebug(+X), where X is a term corresponding to a pathname (with trailing
%  slash), will close the current debug and history files if any, then 
%  continue the  history debug trace in  files called Alma and ADebug in
%  the directory indicated by X
%


cdebug(X):- !,
    dohis(X),
    dodbg(X).

dohis(X):- 
    history_dump(false), !.
dohis(X):- 
    retract(history_stream(OY)),!,
    close(OY),
    name(X, NX),
    append(NX, "Alma", NY),
    name(NNY, NY),
    open(NNY, write, S),
    assert(history_stream(S)).

dodbg(X):- 
    debug_level(0), !.
dodbg(X):- 
    retract(debug_stream(OY)),!,
    close(OY),
    name(X, NX),
    append(NX, "ADebug", NY),
    name(NNY, NY),
    open(NNY, write, S),
    assert(debug_stream(S)).



print_time(SS):- !,
    tcp:tcp_now(timeval(Seconds, MicroSeconds)),
    tcp_date_timeval(Date,timeval(Seconds, MicroSeconds)),
%    print(Date), nl, 
%    time_stamp(Date,'%02c:%02i:', Stamp),
%    print(Stamp), nl,
    get_stamp(Date, Stamp),
    Date = date(_, _, _, _, _, S),
    name(S, NSec),
    name(MicroSeconds, Nmicro),
    name(Stamp, NS),
    append(NS, NSec, NN),
    append(NN, [58|Nmicro], XCX),
    name(Stamps, XCX),
    print(SS, Stamps), nl(SS).

get_stamp(date(_, _, _, X, Y, _), Z):- !,
    name(X, XN),
    name(Y, YN),
    append(XN, [58], F),
    append(F, YN, ZN),
    append(ZN, [58], XC),
    name(Z, XC).


% this is to clear up the alma database in the middle of a session.
% we preserve all the settings used initially and reload the files

reset_alma:-
    retractall(node(_,_,_,_,_,_,_,_,_,_)),
    retractall(new_node(_,_,_,_,_,_,_,_,_,_)),
    retractall(func_node(_,_, _)),
    retractall(func_new_node(_,_, _)),
    retractall(conn_node(_, _)),
    retractall(agenda(_)),
    retractall(node_index(_, _, _)),
    retractall(new_node_index(_, _, _)),
    retractall(pred2hash(_, _)),
    retractall(newpred2hash(_, _)),
    retractall(abort_it(_)),
    retractall(pending_contra(_, _, _, _)),

    assert(agenda([])),
    load_alma_files.


% query(+Form) finds Form in the current database, or says it is not 
% there or says iti s distrusted. hmm, th elast is not straightforward. 
% we could have somethign distrusted reappear. have to do some tinking
% to get it right. Frget about the distrusted part dfor now.
%
% actually will not work for distrusted ones with the commented code.
% need to actually search for all distrusted things then figure if they
% are one of the things we want. too complicated for now.
%
% works for literals only coz of gather_all
%
% right now gets all things that mentiion the formula arg. need to gt theose
% that do not mention anyone else.
%
% this took way too long to write.


% 03/01
% problem si that the distrusted things have the NAMES of formulas as
%  arg, not the formula. :( difficult to find these.

query(Form):- !,
    get_matches(Form, List),
    list_to_ord_set(List, Olist),
%    get_distrusted_ones(Olist, Dlist),
%    get_matches(distrusted(Form), Dlist),
%    list_to_ord_set(Dlist, Odl),
    negate(Form, Negf),
    get_matches(Negf, Nlist),
    list_to_ord_set(Nlist, ONL),
%    get_matches(distrusted(Negf), ONDL),
%    ord_union(Olist, ONL, OALL),
%    ord_union(Odl, ONDL, ODALL),
%    ord_subtract(OALL, ODALL, Gudones),
    ord_union(Olist, ONL, OOOO),
%    print_distrusted(ODALL),
    print_gudones(OOOO).

get_matches(F, CLIST):-
    gp([F], [], [[Pred, plus]]), !,
    match_form(F, plus, List),
    clean_list(F, List, CLIST).
get_matches(F, List):-
    gp([F], [], [[Pred, minus]]), !,
    F = not(FF),
    match_form(FF, minus, Listi),
    clean_list(F, Listi, List).

clean_list(_, [], []):- !.
clean_list(F, [X|Y], [X|OO]):- 
    find_node(X, XN),
    copy_term(F, FC),
    get_formula(XN, [FC]), !,
    clean_list(F, Y, OO).
clean_list(F, [X|Y], OO):- !,
    clean_list(F, Y, OO).

print_gudones([]):- !,
    print('No matches found'), nl.
print_gudones(X):- !,
    print_gudoness(X).

print_gudoness([]):- !.
print_gudoness([X|Y]):-
    find_node(X, Node),
    get_formula(Node, Form),
    print(X), print(':  '), print(Form), nl,
    print_gudoness(Y).


% weird stuff
%

get_distrusted_ones([], []):- !.
get_distrusted_ones([X|Y], R):- !,
    get_matches(distrusted(X), N),
    get_distrusted_ones(Y, MM),
    append(N, MM, R).

print_distrusted([]):- !.
print_distrusted([X|Y]):-
    find_node(X, Node),
    get_formula(Node, Form),
    print('Distrusted: '), print(X), print('  '), print(Form), nl,
    print_distrusted(Y).
