%-*- mode: prolog -*-

% modified jan 1998
% for use solely to graph al

% first, run almag to start up trains connected to the grapher.
% then in quintus (NOT qui!!) strat.
% hit return and wait for a prompr before typing in commands
% cleanup. clenas up everything. and more.

% file tweedledee.pl
% kpurang march 1997
%
% assumes that there is a HOST env variable that tells what the host 
% machine is and that trains is running on same machine.
%
% this is for listening to the keyboard output of trains.
% 
% directions:
%  1. start trains.
%  2. load this file in quintus on same machine trains is running.
%  3. conect_init.
%  4. strat.
%
% Hit return, then exit. to exit nicely.
% trains need not be restarted on each run of this.
%
% this will put keyboard output from trains into active logic. On exit, 
% the active logic history is dumped into a file called AL in the trains
% log directory.
% Also writes junk into a file called slog in the current directory
%
%------------------------------------------------------------

:- use_module(library(tcp)).
:- use_module(library(environ)).
:- use_module(library(ctypes)).
:- [library(date)].

connect_init:-
    retractall(im_default_port(_)),
    retractall(trains_socket(_)),
    retractall(my_log_file(_)),
    assert(im_default_port(6200)).

strat:- 
    connect_init,
    prolog_flag(fileerrors, _, on),
    tcp_watch_user(_, on),
    environ('HOST', Host),
    im_default_port(Port),
    connect(Host, Port, Socket),
    assert(trains_socket(Socket)),
    print(Socket),nl,
    hi_trains(Socket),
						  % note log location.
    open('/dev/null', write, Log),
    assert(my_log_file(Log)),
    repeat,
    tcp_select_from(1, From),
%    print('from '), print(From), nl,
    doit(From, Log, Return),
    Return = done.

hi_trains(Trains):-
    tcp_output_stream(Trains, Str),
    format(Str, '~a', '(register :receiver IM :name alma)'),
    flush_output(Str),
    format(Str, '~a', '(tell :receiver IM :content (ready))'),
    flush_output(Str).

%%
%% Interface to the grapher
%%
%(tell :sender alma :receiver grapher :content (addnode :name 5 :form "foo(X)"  :type fc :step 0))

% g_add_node(+Step, +Nodename, +List_of_parents, +Form, +Type)
g_add_node(Step, Nodename, Plist, Form, Type):-
    trains_socket(Trains),
    tcp_output_stream(Trains, Str),
%    Str=user_output,
    parstring(Plist, [], PP),
    format(Str, '(tell :sender alma :receiver grapher :content(addnode :name ~d :form "~p" :type ~a ~s :step ~d))', [Nodename, Form, Type, PP, Step]),
    flush_output(Str).

/*
    format(user_output, '(tell :sender alma :receiver grapher :content(addnode :name ~d :form "~p" :type ~a ~s :step ~d))', [Nodename, Form, Type, PP, Step]),
    flush_output(user_output),
    print('done add node'), nl.
*/

g2_add_node(Step, Nodename, Plist, Form, Type):-
    parstring(Plist, [], PP),
    format(user_output, '(tell :sender alma :receiver grapher :content(addnode :name ~d :form "~p" :type ~a ~s :step ~d))', [Nodename, Form, Type, PP, Step]),
    flush_output(user_output),
    nl.


print_parents([], Str) :- 
	format(Str, '))', []),
	flush_output(Str).
print_parents([A|X], S):-
    format(S, ' :parent ~d', A),
    print_parents(X, S).


parstring([], Z, Z).
parstring([Z|X], S, R):-
    name(Z, Zname),
    append(" :parent ", Zname, ZZ),
    append(S, ZZ, ZZZ),
    parstring(X, ZZZ, R).

gan_string(Step, Nodename, Plist, Form, Type, S6):-
    name(Nodename, Sname),
    append("(tell :sender alma :receiver grapher :content (addnode :name", Sname, S1),
    append(S1, " :form ", S2),
    name(Form, Sf),
    append(S2, Sf, S3),
    append(S3, ":type ", S4),
    name(Type, St),
    append(S4, St, S5),
    name(Step, SStep),
    append(S5, SStep, S6).


%(tell :sender alma :receiver grapher :content(delnode :name 5 :form "foo(X)"))
% g_del_node(+Nodename)
g_del_node(Nodename):-
    trains_socket(Trains),
    tcp_output_stream(Trains, Str),
    format(Str, '(tell :sender alma :receiver grapher :content(delnode :name ~d))', [Nodename]),
    flush_output(Str).

% (tell :sender alma :receiver grapher :content(reset))
% g_reset()
g_reset:-
    trains_socket(Trains),
    tcp_output_stream(Trains, Str),
    format(Str, '(tell :sender alma :receiver grapher :content(reset))', []),
    flush_output(Str).

% (tell :sender alma :receiver grapher :content(gexit))
% g_exit()

g_exit:-
    trains_socket(Trains),
    tcp_output_stream(Trains, Str),
    format(Str, '(tell :sender alma :receiver grapher :content(gexit))', []),
    flush_output(Str).

/*
g_add_node(0, 0, [], foo1(X), fc).
g_add_node(1, 1, [0], foo2(X), fc).
g_add_node(1, 2, [0, 1], foo3(X), fc).
g_add_node(2, 3, [2, 1], foo4(X), bc).
g_add_node(3, 4, [0, 3], foo5(X), bc).

g_del_node(2).
g_reset.
g_exit.

*/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cleanup :-
trains_socket(Sock), tcp_shutdown(Sock).

doit(user_input, Log, Return):- !,
    read(X),
%    print('Read user '), print(X), nl, 
    process_user_doit(X, Log, Return).

process_user_doit(exit, Log, done):- !,
    close(Log), trains_socket(Sock), tcp_shutdown(Sock).

process_user_doit(X, _, foo):- 
    on_exception(QQ, call(X), complain(QQ)), !.

%, print('Done call'), nl.

complain(X):-
    print('Error: '), print(QQ), nl.

% should not need:

doit(from(Sock), Log, no):-
    print('Input from sock'), nl,
    tcp_input_stream(Sock, Stream),
    get_a_line(Stream, [], Line),		  % better way?
    name(XX, Line),
    print(XX), nl, format(Log, '~a', XX), flush_output(Log),
    print('going to process line'), nl,
    process_line(Log, Line).
do_it(From, _, no):-
    print('  '), print(From), nl.


get_a_line(Stream, Less, More):-
    (at_end_of_file(Stream) -> (get0(Stream, Char), Less=More) ;
    (get0(Stream, Char), 
    (is_endline(Char) -> More = Less;
    (append(Less, [Char], Lesser),
     get_a_line(Stream, Lesser, More))))).

connect(Host, Port, Sock):-
    print('connecting to '), print(Host), print(Port), print(Sock), nl,
    Nport is Port + 1,
    on_exception(X, tcp_connect(address(Port, Host), Sock), 
		 connect(Host, Nport, Sock)).


% stolen from Dumpty.pl

process_line(_, _):- !,
    print('ERROR: NO IMPUT FROM SOCLET EXPECTED').
/*
process_line(S, Foo):- 
        tokenizer(Foo, XX),
        plizer(XX, _, X),
	write(S, X), nl(S), flush_output(S), print(X), nl,
	functor(X, Fu, _),
	(Fu = request -> process_request(X, S);
	    (Fu = tell -> process_tell(X, S);
		(write_line(S, "unknown input: "), 
		write(S, Foo), nl(S), flush_output(S)))).

process_request(X, S):-
	((arg(1, X, Xarg), Xarg = key(content, chdir(string(Y))))->
	      (print(Y), nl, write_line(S, "Change dir to: "), 
	       name(Y, Ys),
	       write_line(S, Ys), nl(S), flush_output(S), %% init1,
	       append(Ys, "/AL", Df), print(Df), 
	       write_line(S, Df), flush_output(S),
	       assert(history_dump_file_tmp(Df)));
	       (write_line(S, "Unknown request: "), write(S, X), nl(S),
	       flush_output(S))).

process_tell(X, S):-
	arg(1, X, Y),
	(arg(1, Y, content)->
	(((arg(2, Y, Yarg1), (functor(Yarg1, word, _); Yarg1 = end))) ->
	      (write_line(S, "Assert in AL: "), write(S, Y), nl(S),
	       flush_output(S),
	       add_to_next_step(Y, [c]), step);

	((arg(2, Y, Y1), functor(Y1, 'end-conversation', _)) ->
	      (write_line(S, "Dump ALL"), nl(S), flush_output(S), 
	       history_dump_file(Hdf), name(NHdf, Hdf),dump_history(NHdf));

	((arg(2, Y, Y1), functor(Y1, 'start-conversation', _)) ->
	      (write_line(S, "Start"), nl(S), flush_output(S), init1,
	       retract(history_dump_file_tmp(H)), 
	       assert(history_dump_file(H)));
	
	(write_line(S, "unknown tell: "), 
	 write(S, X), nl(S), flush_output(S)))));

	(write_line(S, "Unknown tell"), write(Y), nl(S),
	 flush_output(S))).
*/



write_line(_, []):- !.
write_line(S, [X|R]):-
	put(S, X),
	write_line(S, R).






%____________________________________________________________

% old bad code:
% above is new bad code!

connect2(Host, Port, Socket):-			 
    print('trying to connect: '), print(Host), print(Port), nl,
    tcp_now(Now),
    tcp_time_plus(Now, 1, Timeval),
    tcp_schedule_wakeup(Timeval, address(Port, Host)),
    tcp_connect(address(Port, Host), Socket).

/*

(TELL :CONTENT (SPEECH-ACT :FOCUS :V11915 :OBJECTS ((:DESCRIPTION (:STATUS :NAME) (:VAR :V11915) (:CLASS :CITY) (:LEX :CHICAGO) (:SORT :INDIVIDUAL))) :PATHS NIL :DEFS NIL :SEMANTICS :V11915 :NOISE NIL :SOCIAL-CONTEXT NIL :RELIABILITY 38 :MODE KEYBOARD :SYNTAX ((:SUBJECT) (:OBJECT)) :SETTING NIL :INPUT (CHICAGO)) :RE 10)

(TELL :CONTENT (SPEECH-ACT :FOCUS :V11915 :OBJECTS (:DESCRIPTION (:STATUS :NAME) (:VAR :V11915) (:CLASS :CITY) (:LEX :CHICAGO) (:SORT :INDIVIDUAL)) :PATHS NIL :DEFS NIL :SEMANTICS :V11915 :NOISE NIL :SOCIAL-CONTEXT NIL :RELIABILITY 38 :MODE KEYBOARD :SYNTAX ((:SUBJECT) (:OBJECT)) :SETTING NIL :INPUT (CHICAGO)) :RE 10)

*/











