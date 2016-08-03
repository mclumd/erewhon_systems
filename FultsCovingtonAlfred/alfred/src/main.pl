/* The alma-carne interface routines
Darsana Purushothaman Josyula*/ 

:- consult('token_utt.pl').
:- consult('token_utt_comma.pl').
:- consult('lexeme_speller.pl').
:- consult('linking_rule_builder.pl').
:- consult('combinatorial_rule_builder.pl').
:- consult('node_builder.pl').
:- consult('unification.pl').
:- consult('dag_asserter.pl').
:- consult('subsume.pl').

:- ensure_loaded(library(basics)).
:- ensure_loaded(library(strings)).
:- ensure_loaded(library(ctypes)).
:- ensure_loaded(library(lists)).
:- ensure_loaded(library(caseconv)).
:- ensure_loaded(library(listparts)).
:- ensure_loaded(library(printchars)).

ac_dag_asserter(Lex) :-
    dag_asserter(Lex).

ac_unification_dags(Utt, State1, State2, Dag1, Dag2) :-
    unification_dags(Utt, State1, State2, Dag1, Dag2).

ac_subsumes(DAG1, DAG2) :-
    subsumes(DAG1, DAG2).

ac_token_utt(Utt, Sp) :-
   token_utt(Utt, Sp).

ac_token_utt_comma(Utt, Sp, Queue, Dialog) :-
   token_utt_comma(Utt, Sp, Queue, Dialog).

ac_lexeme_speller(LexID, Word) :-
   lexeme_speller(LexID, Word).

ac_create_predicate(Utt, MeaningID, PhraseID) :-
    create_predicate(Utt, MeaningID, PhraseID).

ac_create_relation(Utt, MeaningID, PhraseID) :-
    create_relation(Utt, MeaningID, PhraseID).

ac_create_constant(Utt, MeaningID, PhraseID) :-
    create_constant(Utt, MeaningID, PhraseID).

ac_rule3(Utt, PhraseID, Daughter1_ID, Daughter2_ID, EventID, LocationID, ConstantID) :-
    rule3(Utt, PhraseID, Daughter1_ID, Daughter2_ID, EventID, LocationID, ConstantID).

ac_rule2(Utt, PhraseID, Daughter1_ID, Daughter2_ID, EventID, PredVarID) :-
    rule2(Utt, PhraseID, Daughter1_ID, Daughter2_ID, EventID, PredVarID).

ac_create_S_node(Utt, State) :-
    create_S_node(Utt, State).

ac_create_first_node(Utt, State, LW_State, Mother_State) :-
    create_first_node(Utt, State, LW_State, Mother_State).

ac_create_node(Utt, State, Predecessor_State, Mother_State, Value) :-
    create_node(Utt, State, Predecessor_State, Mother_State, Value).

ac_create_terminal_node(Utt, State, LW_State, Mother_State, Value) :-
    create_terminal_node(Utt, State, LW_State, Mother_State, Value).
