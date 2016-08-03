/* The alma-carne interface routines
Darsana Purushothaman Josyula*/ 

:- consult('unique_id.pl').
:- consult('token_utt.pl').

:- ensure_loaded(library(basics)).
:- ensure_loaded(library(strings)).
:- ensure_loaded(library(ctypes)).
:- ensure_loaded( library(lists)).
:- ensure_loaded(library(caseconv)).
:- ensure_loaded( library(listparts)).
:- ensure_loaded(library(printchars)).

ac_token_utt(Utt, Sp) :-
   token_utt(Utt, Sp).

