%dialog manager action handling scripts Version 3
%Last updated - Oct 3 2000 - D.Purushothaman
%Commands 
/*Send X
  Send X.No.Send Y 
  Where are the trains
  Where is TrainX
  Which TrainX is at CityY
  Is TrainX at CityY
  Is there a train at CityX*/	

/* Contradiction handling for move and not move */
/* If the system cannot resolve reference problems independently, it will send a message to the output manager informing that a reference resolution problem has occured..*/

% Credits: Version 1: Carl Andersen and David Traum 1997-2000

:- use_module('gram4.pl').
:- ensure_loaded(library(ctypes)).
:- ensure_loaded(library(basics)).
:- ensure_loaded(library(strings)).
:- ensure_loaded(library(maplist)).
:- dynamic contexts/2.
:- dynamic lobj/2.
:- dynamic from/2.
:- dynamic to/2.
:- dynamic 'at-loc'/2.

/******************************
actions to be called by ALMA
*************************/

ah_test :- 
    gram4:write_line(user_output,"testing DM..."),nl,
    call(dm_init),!,
    getmsg(ID),
    convert_keyvals1(ID), !,
    convert_keyvals2(ID), !,
    oassert(newmsg(ID)),
    oassert(curr_utt(ID)),
    oassert(contexts(ID,[plan1])).

ah_init :- !,
    call(dm_init),
    sendmsg1(['REGISTER :RECEIVER IM :NAME DM']),
    sendmsg1(['TELL :RECEIVER IM :CONTENT (READY)']),
    sendmsg1(['REQUEST :SENDER DM :RECEIVER IM :CONTENT (LISTEN PARSER)']).

ah_makecall(Type,Args) :-
    Call =.. [Type|Args],
    af(call(Act1,Call)).

ah_preprocess_msg(ID) :-
    convert_keyvals1(ID), !,
    convert_keyvals2(ID), !,
    (kqml_kv(ID,[sender,Sender]),
     oassert(sender(ID,Sender)); true),
    (kqml_kv(ID,[re,Re]),
     oassert(ireq(re(ID,Re),ID)); true),
    (kqml_kv(ID,['in-reply-to',RW]),
     oassert('in-reply-to'(ID,RW)); true),
    kqml_to_msg(ID,Msg),
    oassert(msgname(ID,Msg)),
    gathered_asserts(Asserts1),
/*send different assertion to alma so as to avoid passing all the asserts */
    assert(new_message_kv(ID,Asserts1)),
    af(new_message_kv(ID)).


ah_translate_score(ID) :-
    kqml_kv(ID,[content,ContentID]),
    kqml_kv(ContentID,['ps-state',PSState]),
    oassert(initial_ps_state(PSState)).

ah_translate_parse(ID) :-
    oassert(curr_utt(ID)), /*DELETE THIS LINE??? --Darsana*/
    translate_parser_input(ID).

ah_resolve_ref(ID, Var, Bindings) :-
    dreq(class(Var,Class),ID),
    resolve_reference(ID, Var, Bindings, Class).

ah_kbr_question(ID,Type, Constraint, ID1) :-
    make_kbr_question(ID,Type, Constraint, ID1),
    sendmsg(ID1).

ah_translate_kbr(ID,ID2) :-
    translate_kbr(ID,ID2).

ah_ir_question(ID,Type,ID1) :-
    make_ir_question(ID,Type,ID1),
    sendmsg(ID1),
    gathered_asserts(Asserts1).

ah_translate_ir(ID,ID1,ResultID) :-
    translate_ir(ID,ID1,ResultID).

ah_ur_question(ID,Type,ID2,ID1) :-
    make_ur_question(ID,Type,ID2,ID1),
    sendmsg(ID1).

ah_undo_state(ID,ID1) :-
    dreq(psbstate(ID1,PSState), ID1),
    oretractall(dreq(focus(ID,nil),ID)),
    oassert(dreq(focus(ID,PSState),ID)),
    undo_ps_state(ID,ID1).

ah_confirmsuccess(ID,ID2) :-
    kqml_kv(ID2,['content',ID3]),
    kqml_expr(ID3,[_,_,ID4|_]),
    kqml_expr(ID4,[_,success]).

ah_outmgrconfirm(ID,Type,ID1) :-
    makeoutput(ID,Type,ID1),
    sendmsg(ID1).

/*****************************
generic code to send and wait for messages
****************************/

%Msg is the prolog list structure made from the incoming message
getmsg(ID) :-
    repeat,
    gram4:get_a_line(user_input,[],Out),
    parse_kqml_perf(Out,ID),
    convert_keyvals1(ID), !,
    convert_keyvals2(ID), !.

%get a message from Sender
%ignore any messages that arrive in the meantime
getmsg(Sender,ID) :-
    repeat,
    getmsg(ID1),
    kqml_head(ID1,_),
    (kqml_head(ID1,quit) -> raise_exception(quit);true),
    (kqml_head(ID1,restart) -> raise_exception(restart);true),
    \+ kqml_head(ID1,cd),
    kqml_kv(ID1,[sender,Sender1]),
    kqml_kv(ID1,[receiver,Receiver1]),
    ((Sender1 == Sender,Receiver1 == dm) -> ID = ID1).

%send a Msg to standard output
sendmsg(ID) :-
    is_kqml_var(ID),
    unparse_kqml_perf(ID,Msg),
    kqml_to_msg(ID,Name),
    oassert(msgname(ID,Name)),
    gram4:write_line(user_output,Msg),nl.

%send a nested list Msg to standard output
sendmsg1(Msg) :-
    gram4:pparser(Msg,Msg1),
    parse_kqml_perf(Msg1,ID),
    kqml_retract(ID),
    gram4:write_line(user_output,Msg1),nl.

%send an error Msg to standard output
%ID2 is that message
senderrmsg(ID,[],ID1) :-
    assert_head(ID9,express),
    oassert(kqml_kv(ID9,[':speech-act',inform])),
    assert_expr(ID2,[error,alma,ID1]),
    oassert(kqml_kv(ID9,[':content',ID2])),
    assert_msg(ID9,dm,outmgr,ID),
    sendmsg(ID9).

/******************************************************
code to translate parser and ps messages coming into dm
*******************************************************/

translate_parser_input(ID) :-
    kqml_kv(ID,[content,ContentID]),
    kqml_kv(ContentID,[noise,NoiseID]),
    kqml_expr(NoiseID,[alma,reset]),
    oassert(reset_alma(ID)),!.

translate_parser_input(ID) :-
    kqml_kv(ID,[content,ContentID]),
    kqml_head(ContentID,Type),
    oassert(ireq(type(ID,Type),ID)),!,
    translate_parser_type(ID,ContentID,Type).

translate_parser_type(ID, ContentID,'sa-reject') :-
    kqml_kv(ContentID,[focus,Focus]),!,
    oassert(ireq(focus(ID,Focus),ID)).

translate_parser_type(ID,ContentID,Type) :-
    kqml_kv(ContentID,[focus,Focus]),
    oassert(ireq(focus(ID,Focus),ID)),!,
    kqml_kv(ContentID,[objects,ObjectListID]),
    kqml_expr(ObjectListID,ObjectIDList),
    makeobjects(ID,ObjectIDList),
    kqml_kv(ContentID,[paths,PathListID]),
    (is_kqml_var(PathListID) ->
	 kqml_expr(PathListID,PathsID);
    PathsID = PathListID),
    makepaths(ID,PathsID),
    kqml_kv(ContentID,[semantics,SemID]),
    makesem(ID,SemID),
    makebindings(ID),
    makePSConstraints(ID).

/*assert constraints found in objects */
/******************************************************/
/******************************************************/
/******************************************************/
/*:OBJECTS
  ((:DESCRIPTION (:STATUS :NAME) (:VAR :V11771) (:CLASS :CITY)
    (:LEX :LEXINGTON) (:SORT :INDIVIDUAL))
   (:DESCRIPTION (:STATUS :DEFINITE) (:VAR :V11750) (:CLASS :TRAIN)
    (:SORT :INDIVIDUAL) (:CONSTRAINT (:AT-LOC :V11750 :V11771)))
*/
makeobjects(ID,[ObjID|ObjectIDList]) :-
    makeobject(ID,ObjID),!,
    makeobjects(ID,ObjectIDList).
makeobjects(ID,[]).

makeobject(ID,ObjID) :-
    kqml_head(ObjID,description),
    kqml_kv(ObjID,[var,Var]),
    oassert(ireq(obj(ID,Var),ID)),
    kqml_kv(ObjID,[status,Status]),
    oassert(ireq(status(Var,Status),ID)),
    oassert(ireq(constraint(ID,['status',Var,Status]),ID)),!,
    findall([Att,Val],makeobject1(ID,ObjID, Var, [Att,Val]),AttVals).

makeobject1(ID,ObjID, Var,[Att,Val]) :-
    kqml_kv(ObjID,[Att,Val]),
    makeobjatts(ID,Var,[Att,Val]).

makeobject1(_,_,[]).

/* (:CLASS (:PRED (:ARG :ELEM11605) (:CLASS :TRAIN))) */

makeobjatts1(ID,Var,[KqmlID|KqmlIDs]) :-
    kqml_kv(KqmlID,[Att,Val]),!,
    makeobjatts1(ID,Var,[Att,Val]),
    makeobjatts1(ID,Var,KqmlIDs).

makeobjatts1(ID,Var,[KqmlID|KqmlIDs]) :-
    kqml_expr(KqmlID,[Att|Vals]),!,
    makeobjatts1(ID,Var,Vals),
    makeobjatts1(ID,Var,KqmlIDs).

makeobjatts1(ID,Var,[Att,Val]) :-
    makeobjatts(ID,Var,[Att,Val]).

makeobjatts1(ID,Var,KqmlIDs).

makeobjatts(ID,Var,[class, Val]) :- 
    is_kqml_var(Val),!,
    makeobjatts1(ID,Var,[Val]).

/*(:CLASS :CITY)*/
makeobjatts(ID,Var,[class, Val]) :- 
    oassert(ireq(class(Var,Val),ID)),
    oassert(ireq(constraint(ID,[class,Var,Val]),ID)).

/*(:LEX :METROLINER)*/
makeobjatts(ID,Var,[lex,Val]) :- 
    (ireq(status(Var,wh),ID) -> 
	 oassert(ireq(lex(Var,'null'),ID));
    oassert(ireq(lex(Var,Val),ID))),    
    oassert(ireq(constraint(ID,[lex,Var,Val]),ID)).

/*(:SORT :INDIVIDUAL))
  this conflicts with a defined prolog pred hence sort-of */
makeobjatts(ID,Var,[sort,Val]) :- 
    oassert(ireq('sort-of'(Var,Val),ID)),
    oassert(ireq(constraint(ID,['sort-of',Var,Val]),ID)).

/* (:CONSTRAINT (:AT-LOC :V11597 :V11620))*/
makeobjatts(ID,Var,[constraint,ConsID]) :- 
    kqml_expr(ConsID,[Att,Var,Val]),!,
    ((Att == 'assoc-with'; Att == 'at-loc') -> 
	  (oassert(ireq('at-loc'(Var,Val),ID)),
	   oassert(ireq(constraint(ID,['at-loc',Var,Val]),ID)));
    (Att == 'eq' ->
	 (Val = [Head|Items],
	 oassert(ireq(eq(Var,Items),ID)));
    true)),

makeobjatts(ID,Var,[Att,Val]).

/*make paths;*/
/******************************************************/
/******************************************************/
/******************************************************/
/*  :PATHS ((:PATH (:VAR :V11801) (:CONSTRAINT (:TO :V11801 :V11809))))*/

/*make paths */
makepaths(ID,nil).

makepaths(ID,[PathID|PathIDList]) :-
    kqml_head(PathID,path),
    kqml_kv(PathID,[var,Path]),
    oassert(ireq(path(ID,Path),ID)),!,
    kqml_kv(PathID,[constraint,ConstraintID]),
    makepathconstraintfrom(ID,Path,ConstraintID),
    makepathconstraintto(ID,Path,ConstraintID),
    makepaths(ID,PathIDList).
makepaths(ID,[]).

makepathconstraintfrom(ID,Path,ConstraintID) :-
    kqml_expr(ConstraintID,[from,_,From]),
    oassert(ireq(from(Path,From),ID)),!,
    oassert(ireq(constraint(ID,[from,Path,From]),ID)).

makepathconstraintfrom(_,_,_).

makepathconstraintto(ID,Path,ConstraintID) :-
    kqml_expr(ConstraintID,[to,_,To]),
    oassert(ireq(to(Path,To),ID)),!,
    oassert(ireq(constraint(ID,[to,Path,To]),ID)).

makepathconstraintto(_,_,_).

/*make semantics */
/******************************************************/
/******************************************************/
/******************************************************/
/* :SEMANTICS
  (:PROP (:VAR :V12315) (:CLASS :MOVE)
   (:CONSTRAINT
    (:AND (:LSUBJ :V12315 :*YOU*) (:LOBJ :V12315 :V12322)
     (:LCOMP :V12315 :V12334))))
*/
makesem(ID,SemID) :-
    kqml_head(SemID,prop),
    kqml_kv(SemID,[var,Sem]),
    oassert(ireq(sem(ID,Sem),ID)),!,
    kqml_kv(SemID,[constraint,ConstraintID]),
    (kqml_expr(ConstraintID,[and|ConstraintIDList]);
    ConstraintIDList = [ConstraintID]),
    makesemconst(ID,Sem,ConstraintIDList),!,
    makesemclass(ID,SemID,Sem),
    makesemlf(ID,Sem).

makesemconst(ID,Sem,[ConstraintID|ConstraintIDList]) :-
    kqml_expr(ConstraintID,[Att,Sem,Val]),
    ((Att = lsubj -> 
	  oassert(ireq(lsubj(Sem,Val),ID)));
    (Att = lobj -> 
	 oassert(ireq(lobj(Sem,Val),ID)));
    (Att = lcomp -> 
	 oassert(ireq(lcomp(Sem,Val),ID)));
    true),
    makesemconst(ID,Sem,ConstraintIDList).

makesemconst(ID,Sem,[]).

makesemclass(ID,SemID,Sem) :-
    kqml_kv(SemID,[class,SemClassExpr]),
    is_kqml_var(SemClassExpr),
    kqml_expr(SemClassExpr,[be,Type]),!,
    makebesemclass(ID,Type,Sem).

makebesemclass(ID,'at-loc',Sem) :-
    ireq(lsubj(Sem,Lsubj),ID),
    ireq(lobj(Sem,Lobj),ID),
    oassert(ireq('at-loc'(Lsubj,Lobj),ID)),
    oassert(ireq(constraint(ID,['at-loc',Lsubj,Lobj]),ID)),
    oassert(ireq(class(Sem,beatloc),ID)).

makebesemclass(ID,Type,Sem) :-
    oassert(ireq(class(Sem,Type),ID)).

makesemclass(ID,SemID,Sem) :-
    kqml_kv(SemID,[class,SemClass]),
    oassert(ireq(class(Sem,SemClass),ID)).

makesemlf(ID,Sem) :-
    ireq(class(Sem,beatloc),ID),!,
    ireq(lsubj(Sem,Lsubj),ID),
    ireq(lobj(Sem,Lobj),ID),
    oassert(ireq(lf(Sem,['at-loc',Lsubj,Lobj]),ID)).

makesemlf(ID,Sem) :-
    ireq(class(Sem,exists),ID),!,
    ireq(lsubj(Sem,Lsubj),ID),
    ireq(constraint(ID,Constraint),ID),
    Constraint = ['at-loc',Lsubj,_],
    oassert(ireq(lf(Sem,Constraint),ID)).

makesemlf(ID,Sem) :-
    ireq(class(Sem,move),ID),!,
    ireq(path(ID,Path),ID),
    ireq(to(Path,To),ID),
    ireq(lobj(Sem,Lobj),ID),
    oassert(ireq(lf(Sem,[move,Lobj,To]),ID)).

makesemlf(ID,_).
    

%convert parser constraints to PS constraints
%later we will reprocess some constraints 
%from parser representation to PS representation
/******************************************************/
/******************************************************/
/******************************************************/
makePSConstraints(ID) :-
    findall(Constraint,ireq(constraint(ID,Constraint),ID),Constraints),
    makePSConstraints(ID,Constraints).

makePSConstraints(ID,[Constraint|Constraints]) :-
    Constraint = [Pred|Args],
    (Pred == class;
    Pred == 'at-loc'),
    recsubst(ID,ireq,false,Args,Args1),
    ( ((Pred == class,Args1 = [X,Y],Y == engine) -> 
	   oassert(ireq(psConstraint(ID,Constraint,[type|Args1]),ID)));
    ((Pred == class,Args1 = [X,Y],Y == train) -> 
	  oassert(ireq(psConstraint(ID,Constraint,[type,X,engine]),ID)));
    ((Pred == class,Args1 = [X,Y],Y == location) -> 
	  oassert(ireq(psConstraint(ID,Constraint,[type,X,city]),ID)));
    ((Pred == class,Args1 = [X,Y],Y == city) -> 
	  oassert(ireq(psConstraint(ID,Constraint,[type,X,city]),ID)));
    (Pred == 'at-loc' -> 
	 oassert(ireq(psConstraint(ID,Constraint,['at-loc'|Args1]),ID)));
    true),!,
    makePSConstraints(ID,Constraints).

makePSConstraints(ID,[_|Constraints]) :-
    makePSConstraints(ID,Constraints).

makePSConstraints(ID,[]).

/****************************************************************************
Undo
****************************************************************************/

undo_ps_state(ID,ID1) :-
    dreq(type(ID1, 'sa-request'),ID1),
    dreq(lf(_,[move,Eng,Cit]),ID1),
    dreq(lex(Eng,Engine),ID1),
    dreq(lex(Cit,City),ID1),
    af(not(move(Engine,City))).

undo_ps_state(ID,ID1).




/************************************************
************************************************
************************************************
REFERENCE RESOLUTION
************************************************
***************************************************
*********************************************
*************************************************/
find_train(ID,Var,[], []).

find_train(ID,Var,[Binding|Bindings], Result) :-
    dreq(lf(_,[move,Eng,Cit]),ID),
    dreq(lex(Cit,City),ID),
    (clause(not(move([Binding],City)), true) -> 
	 find_train(ID,Var,Bindings, Result);	
    Result = [Binding]).
 
resolve_reference(ID, Var, [Binding|[]], Type) :-
    dreq(lex(Var,null),ID),
    oretractall(dreq(lex(Var,_),ID)),
    oassert(dreq(lex(Var,[Binding]),ID)).

resolve_reference(ID, Var, Bindings, train) :-
    dreq(class(Var,train),ID),
    find_train(ID,Var,Bindings,Result),
    (Result \== [] ->
	 (oretractall(dreq(lex(Var,_),ID)),
	  oassert(dreq(lex(Var,Result),ID))); 
    true). 

resolve_reference(ID, Var, Bindings, Type) :-
    dreq(lex(Var,Value),ID),
    Value \== null.

resolve_reference(ID, Var, Bindings, Type) :-
    dreq(lex(Var,null),ID),
    dreq(candidates(Var,[Binding|Bindings]),ID),
    oretractall(dreq(lex(Var,_),ID)),
    oassert(dreq(lex(Var,[Binding]),ID)).

/*########################################################################
##########################################################################
Generic message handler
##########################################################################
##########################################################################*/

assert_msg(ID,Sender,Receiver,Re) :-
    oassert(kqml_kv(ID,[':sender',Sender])),
    oassert(kqml_kv(ID,[':receiver',Receiver])),
    kqml_to_msg(Re,Re1),
    oassert(kqml_kv(ID,[':re',Re1])),
    kqml_to_msg(ID,Repwith1),
    oassert(kqml_kv(ID,[':reply-with',Repwith1])).


/*************************************************************************
##########################################################################
##########################################################################
PROBLEM SOLVER MESSAGE HANDLERS: code to make specific external msgs to PS
##########################################################################
##########################################################################
**************************************************************************/
/*to construct final message to PS*/
assert_ps_msg(Verb,Sender,Re,Aspect,Content,Contexts,ID1) :-
    assert_head(ID1,Verb),
    (Aspect = [] -> true; oassert(kqml_kv(ID1,[':aspect',Aspect]))),
    (Content = [] -> true; oassert(kqml_kv(ID1,[':content',Content]))),
    (Contexts = [] -> true; oassert(kqml_kv(ID1,[':context',Contexts]))),
    (PlanContent = [] -> true; oassert(kqml_kv(ID1,[':plan-content',PlanContent]))),
    assert_msg(ID1,Sender,ps,Re).

/************************************************************
************************************************************
                      KNOWLEDGE BASE REQUESTS
*************************************************************
*************************************************************/
make_kbr_question(ID,'if', PSConstraint, ID1) :-
    convert_vars(PSConstraint,PSConstraint1),
    assert_expr(ID2,PSConstraint1),
    assert_ps_msg('ask-if',dm,ID,[],ID2,[],ID1).

make_kbr_question(ID,all, Const, ID1) :-
    makePSAspects(ID,PSAspects),
    (PSAspects == [] ->	 
	 ID2 = [];
    (convert_vars(PSAspects,PSAspects1),
     assert_expr(ID2,PSAspects1))),
    findall(PSCID,(dreq(psConstraint(ID,Constraint,PSConstraint),ID),
		   convert_vars(PSConstraint,PSConstraint1),
		   assert_expr(PSCID,PSConstraint1)),PSCIDs),
    remove_dups(PSCIDs,PSCIDs1),
    assert_expr(ID3,[':and'|PSCIDs1]),
    assert_ps_msg('ask-all',dm,ID,ID2,ID3,[],ID1).

makePSAspects(ID,PSAspects) :-
    makePSAspects1(ID,PSAspects),
    oassert(dreq(psAspects(ID,PSAspects),ID)).

makePSAspects1(ID,PSAspects) :-
    getbindings(ID,dreq,Bindings),
    makePSAspects1(ID,Bindings,PSAspects).

makePSAspects1(ID,[Binding|Bindings],PSAspects) :-
    ((Binding = [Obj,null], 
      dreq(obj(ID,Obj),ID)) ->
	       PSAspect = [Obj];
    PSAspect = []),
    makePSAspects1(ID,Bindings,PSAspects1),
    append(PSAspect,PSAspects1,PSAspects).

makePSAspects1(ID,[],[]).

/****************
code to deal with bindings of utterance variables
*****************/

translate_kbr(ID,ID1) :-
    kqml_kv(ID1, [content, ContentID]),
    kqml_kv(ContentID, [vars, VarID]),!,
    kqml_expr(VarID,VarList),
    unconvert_vars(VarList,VarList1),
    kqml_kv(ContentID, [result, ResultID]),
    oassert(dreq(result(ID1,ResultID),ID)),
    translate_kbr_result(ResultID,Bindings),!,
    translate_kbr_binds(ID,Bindings,VarList1).

translate_kbr(ID,ID1) :-
    kqml_kv(ID1, [content, ContentID]),
    kqml_kv(ContentID, [result, ResultID]),
    oassert(dreq(result(ID1,ResultID),ID)).

translate_kbr_result(nil,[]).

translate_kbr_result(ResultID,Bindings) :- 
    is_kqml_var(ResultID),
    kqml_expr(ResultID,ResultIDList),
    getresultlistlist(ResultIDList, ResultListList),
    transpose(ResultListList,Bindings).

translate_kbr_binds(ID,[Binding|Bindings],[Var|VarList]) :-
 /*   (dreq(lex(Var,_),ID) ->
	 oretractall(dreq(lex(Var,_),ID));
    true), */
    oassert(dreq(candidates(Var,Binding),ID)),
    translate_kbr_binds(ID,Bindings,VarList).

translate_kbr_binds(ID,[],[]).


%the results are either a list of different possible binding lists
%or just one binding list
getresultlistlist([R|ResultIDList],ResultListList) :-
    ((is_kqml_var(R),
      kqml_expr(R,ResultList),
      getresultlistlist(ResultIDList,ResultListList1),
      append([ResultList],ResultListList1,ResultListList));
    ResultListList = [[R|ResultIDList]]).
getresultlistlist([],[]).

/************************************************************
************************************************************
                      INTERPRETATION REQUESTS
*************************************************************
*************************************************************/

/*
MUST CONSTRUCT
(REQUEST :RE 2 :REPLY-WITH RQ178 :SENDER dm :RECEIVER PS :CONTENT (:NEW-SUBPLAN :PLAN-ID R341 :CONTENT (:GO GO177 (:AND (:AGENT ENGINE_3) (:TO CHARLESTON)))))
*/

make_ir_question(ID,Type,ID1) :-
    makePSPlanContent(ID,dreq,ID4),
    assert_head(ID5,Type),
    oassert(kqml_kv(ID5,[':plan-id',r341])),
    oassert(kqml_kv(ID5,[':content',ID4])),
    assert_ps_msg('request',dm,ID,[],ID5,[],ID1).

makePSPlanContent(ID,Phase,ID1) :- 
    dreq(sem(ID,Sem),ID),
    dreq(class(Sem,Class),ID),
    (Class = move -> 
	 (PSClass = ':go', gensym('go',PSVar))),
/*agent*/
    dreq(lobj(Sem,Lobj),ID),
    subst(ID,Phase,false,Lobj,Lobj1),
    assert_expr(ID3,[':agent',Lobj1]),
    dreq(path(ID,Path),ID),
    (dreq(to(Path,To),ID) ->
	 (subst(ID,Phase,false,To,To1),
	  assert_expr(ID4,[':to',To1]));true),
    ((dreq(from(Path,From),ID);dreq('at-loc'(Lobj1,From),ID)) ->
	  (subst(ID,Phase,false,From,From1),
	   assert_expr(ID5,[':from',From1]),
	   assert_expr(ID6,[':and',ID3,ID4,ID5]));
    assert_expr(ID6,[':and',ID3,ID4])),
    assert_expr(ID1,[PSClass,PSVar,ID6]).


/*code to translate ps messages about plans */
translate_ir(ID,ID1,ResultID) :-
    kqml_kv(ID1,['content', ID2]),
    kqml_kv(ID2,['result', ResultID]),
    kqml_kv(ID2,['ps-state', PSState]),
    translate_ir_result(ID, ResultID),
    (ResultID == nil -> true;
    oassert(pact(psstate(ID,PSState),ID))).
    

/* for failed requests, result is nil */
translate_ir_result(ID, nil).

translate_ir_result(ID, ResultID) :-
    kqml_head(ResultID,'new-subplan'),
    kqml_kv(ResultID,['plan', ID1]),
    kqml_expr(ID1,[PlanID,'goal',ID2,'agent',Agent,'actions',ID3]),
    oassert(pact(plan(PlanID),ID)),
    oassert(pact(agent(PlanID,Agent),ID)),
    kqml_kv(ResultID,['objects',ID4]),
    oassert(pact(objects(ID4),ID)),
    kqml_expr(ID2,[Type,GoalID|_]),
    oassert(pact(goal(PlanID,GoalID),ID)),
    oassert(pact(type(GoalID,Type),ID)),
    kqml_kv(ID2,[agent,Agent]),
    oassert(pact(agent(GoalID,Agent),ID)),
    kqml_kv(ID2,[from,From]),
    kqml_kv(ID2,[to,To]),
    oassert(pact(from(GoalID,From),ID)),
    oassert(pact(to(GoalID,To),ID)),
    kqml_expr(ID3,ActionIDs),
    translate_plan_actions(ID,PlanID,ActionIDs).


translate_plan_actions(ID,ID2,[ActionID|ActionIDs]) :-
    kqml_head(ActionID,Type),
    kqml_head2(ActionID,Act),
    kqml_kv(ActionID,[from,From]),
    kqml_kv(ActionID,[to,To]),
    kqml_kv(ActionID,[track,Track]),
    oassert(pact(action(ID,ID2,Act),ID)),
    oassert(pact(type(Act,Type),ID)),
    oassert(pact(from(Act,From),ID)),
    oassert(pact(to(Act,To),ID)),
    oassert(pact(track(Act,Track),ID)),
    translate_plan_actions(ID,ID2,ActionIDs).

translate_plan_actions(ID,ID2,[]).

/************************************************************
************************************************************
                      UPDATE REQUESTS
*************************************************************
*************************************************************/
make_ur_question(ID,Type,PSState,ID1) :-
    assert_expr(ID2,[Type,':ps-state',PSState]),
    assert_ps_msg('request',dm,ID,[],ID2,[],ID1).


/*************************************************************************
##########################################################################
##########################################################################
OUTPUT MANAGER MESSAGE HANDLERS: 
code to make specific external msgs to Output Manager
##########################################################################
##########################################################################
**************************************************************************/
/*to construct final message to Output Manager*/
assert_om_msg(Verb,Sender,Re,SpeechAct,Focus,Media,Content,Constraints,ID1) :-
    assert_head(ID1,Verb),
    (SpeechAct = [] -> true; oassert(kqml_kv(ID1,[':speech-act',SpeechAct]))),
    (Focus = [] -> true; oassert(kqml_kv(ID1,[':focus',Focus]))),
    (Media = [] -> true; oassert(kqml_kv(ID1,[':media',Media]))),
    (Content = [] -> true; oassert(kqml_kv(ID1,[':content',Content]))),
    (Constraints = [] -> true; oassert(kqml_kv(ID1,[':constraints',Constraints]))),
    assert_msg(ID1,Sender,outmgr,Re).


makeoutput(ID,':update-pss',ID1) :-
    gensym(path,PathID),!,
    assert_expr(ID2,[type,PathID,route]),
    pact(plan(PlanID),ID),
    pact(agent(PlanID, TrainID),ID),
    assert_expr(ContentID,['move-engine-along-path',TrainID,PathID]), 
    assert_expr(ID3,[type,TrainID,engine]),
    pact(goal(PlanID,GoalID),ID),
    pact(from(GoalID,From),ID),
    assert_expr(ID4,[source,PathID,From]),
    pact(to(GoalID,To),ID),
    assert_expr(ID5,[dest,PathID,To]),
    findall(Track,pact(track(_,Track),ID),Tracks),
    reverse(Tracks,TracksList),
    assert_expr(TracksID,TracksList),
    assert_expr(ID6,[tracks,PathID,TracksID]),
    assert_expr(ConstraintsID, [and,ID2,ID3,ID4,ID5,ID6]),
    assert_expr(PathListID,[PathID]),
    assert_om_msg(express,dm,ID,'inform_plan',PathListID,unspecified,
		  ContentID,ConstraintsID,ID1).

makeoutput(ID,'train-ref-err',ID1) :-
    assert_om_msg(express,dm,ID,'train-ref-err',[],unspecified,[],[],ID1).

makeoutput(ID,':undo',ID1) :-
    assert_om_msg(express,dm,ID,'ok',[],unspecified,[],[],ID1).

makeoutput(ID,Type,ID1) :-
    pact(sem(ID,SemID),ID),
    pact(lf(SemID,LFList),ID),
    LFList = [LF,LF1,LF2],
    pact(lex(LF1,LF1Val),ID),
    pact(lex(LF2,LF2Val),ID),
    getlexlist(LF1,LF1Val,LF1List),
    getlexlist(LF2,LF2Val,LF2List),
    makeoutputcontent(LF,LF1List,LF2List,Content),
    append(['and'],Content,Contents),
    (Type == deny ->
	 (assert_expr(DenyID,Contents),
	  assert_expr(ContentID,[not,DenyID]));
    assert_expr(ContentID,Contents)),
    (LF1Val == null ->
	 assert_expr(FocusID,LF2List);
    assert_expr(FocusID,LF1List)),
    pact(psConstraint(ID,[class,LF1,_],[type,_,LF1Type]),ID),
    pact(psConstraint(ID,[class,LF2,_],[type,_,LF2Type]),ID),
    makeoutputconstraints(LF1Type, LF1List, LF2Type, LF2List,Consts),
    append(['and'],Consts,Constraints),
    assert_expr(ConstraintsID, Constraints),
    assert_om_msg(express,dm,ID,Type,FocusID,unspecified,ContentID,ConstraintsID,ID1).
  
/*for unbound variables use variable name instead of null*/
getlexlist(LF,LFVal,LFList) :-
    (is_list(LFVal) ->
	 LFList = LFVal;
    (LFVal == null ->
	 LFList = [LF];
    LFList = [LFVal])).


makeoutputcontent(LF,[LF1|LF1List],[LF2|LF2List],Content) :-
    makeoutputcontent(LF,LF1List,LF2List,Conts),
    assert_expr(LFID,[LF,LF1,LF2]),
    append([LFID],Conts,Content).
	  	  
makeoutputcontent(LF,[],[],[]).
	  

makeoutputconstraints(LF1Type, [LF1|LF1List], LF2Type, [LF2|LF2List],Constraints) :- 
    makeoutputconstraints(LF1Type, LF1List, LF2Type, LF2List,Consts),
    assert_expr(LF1ID,[type,LF1,LF1Type]),
    assert_expr(LF2ID,[type,LF2,LF2Type]),
    (is_var(LF1) ->
	 (assert_expr(Var1ID,[var,LF1]),
	 VarList = [Var1ID]);
    VarList=[]),
    (is_var(LF2) ->
	 (assert_expr(Var2ID,[var,LF2]),
	  append(VarList,[Var2ID],Vars));
    Vars = VarList),
    append([LF1ID,LF2ID],Vars, Constrnt),
    append(Constrnt,Consts, Constraints).

makeoutputconstraints(LF1Type, [], LF2Type, [], []).


/*************************************************************************
##########################################################################
                            GENERIC OPERATIONS
**************************************************************************
########################################################################*/


%returns the set of Vals formed by substituting 
%in Lex values for Vars
multsubst(ID,Phase,RepNulls,[Var|Vars],Vals) :-
    subst(ID,Phase,RepNulls,Var,Val),
    multsubst(ID,Phase,RepNulls,Vars,Vals1),
    Vals = [Val|Vals1].
multsubst(_,_,_,[],[]).

recsubst(ID,Phase,RepNulls,[Var|Vars],Vals) :- 
    (is_list(Var) -> recsubst(ID,Phase,Var,Val1);
    subst(ID,Phase,RepNulls,Var,Val1)),
    recsubst(ID,Phase,RepNulls,Vars,Vals1),
    Vals = [Val1|Vals1].
recsubst(_,_,_,[],[]).

%find the proper name for Arg in the list of Obj - Name 
%bindings and replace Arg with it
subst(ID,Phase,RepNulls,Var,Var1) :-
    ((Q =.. [Phase,lex(Var,Var1),ID],clause(Q,true),(\+ Var1 = null; RepNulls = true));
    Var1 = Var).

%getvars recursively finds the vars in a structure
getvars([Arg|Args],Vars) :-
    is_list(Arg),
    getvars(Arg,Vars1),
    getvars(Args,Vars2),
    append(Vars1,Vars2,Vars).

getvars([Arg|Args],Vars) :-
    (is_var(Arg) -> Vars1 = [Arg];
    Vars1 = []),
    getvars(Args,Vars2),
    append(Vars1,Vars2,Vars).
getvars([],[]).

convert_vars(Arg,Arg1) :-
    (\+ is_list(Arg)),
    convert_var(Arg,Arg1).

%convert vars from parser format to PS format
convert_vars([Arg|Args],Args1) :- 
   (is_list(Arg) -> convert_vars(Arg,Arg1);
   convert_var(Arg,Arg1)),
   convert_vars(Args,Args2),
   Args1 = [Arg1|Args2].
   convert_vars([],[]).

%convert vars from parser format to PS format
unconvert_vars([Arg|Args],Args1) :- 
   (is_list(Arg) -> convert_vars(Arg,Arg1);
   unconvert_var(Arg,Arg1)),
   unconvert_vars(Args,Args2),
   Args1 = [Arg1|Args2].
   unconvert_vars([],[]).

%%cfa need to check if this is working on correct things
%this converts var constants into similar strings beginning with "?"
%%it also adds a colon to various constants to meet PS specs
convert_var(Arg,Arg1) :- 
    convert1_var(Arg,Arg1);
    ((\+ (convert1_var(Arg,Arg1), 
	  Arg \== Arg1)),
     Arg = Arg1).

convert1_var(Arg,Arg1) :- 
    atom(Arg),
    atom_chars(Arg,ArgStr),
/* v + digit....*/
    (ArgStr = [118|Rest],
     number_chars(_,Rest),
     ArgStr1 = [63,118|Rest]),
    atom_chars(Arg1,ArgStr1).

convert1_var(Arg,Arg1) :- 
    atom(Arg),
    ((Arg = 'at-loc' -> Arg1 = ':at-loc');
    (Arg = 'type' -> Arg1 = ':type');
    (Arg = 'engine' -> Arg1 = ':engine');
    (Arg = 'city' -> Arg1 = ':city')
    ).

unconvert_var(Arg,Arg1) :- 
    unconvert1_var(Arg,Arg1);
    ((\+ (unconvert1_var(Arg,Arg1), 
	  Arg \== Arg1)),
     Arg = Arg1).

unconvert1_var(Arg,Arg1) :- 
    atom(Arg),
    atom_chars(Arg,ArgStr),
    ArgStr = [63,118|Rest],
    number_chars(_,Rest),
    ArgStr1 = [118|Rest],
    atom_chars(Arg1,ArgStr1).

%get and assert the known object - name pairs
makebindings(ID) :-
    findall(Obj,ireq(obj(ID,Obj),ID),Objs),
    makebindings(ID,Objs).

makebindings(ID,[Obj|Objs]) :-
    (ireq(lex(Obj,Lex),ID) -> 
    oassert(ireq(lex(Obj,Lex),ID));
    oassert(ireq(lex(Obj,'null'),ID))),
    makebindings(ID,Objs).
makebindings(_,[]).

%get all the known object - name pairs
getbindings(ID,Phase,Bindings) :-
    findall(Obj,(Q =.. [Phase,obj(ID,Obj),ID],clause(Q,true)),Objs),
    getbindings1(ID,Objs,Bindings).

getbindings1(ID,[Obj|Objs],Bindings) :-
    ((dreq(lex(Obj,Lex),ID) -> Binding1 = [Obj,Lex]);
    Binding1 = [Obj,null]),
    getbindings1(ID,Objs,Bindings1),
    Bindings = [Binding1|Bindings1].
getbindings1(_,[],[]).

duplist(El,0,[]).

duplist(El,Num,Els) :-
    Num1 is Num - 1,
    duplist(El,Num1,Els1),
    append([El],Els1,Els).

/*********************
dm initialization and reset functions
**********************/

dm_init :- 
/*domain-dependent assertions */
    !,
    assert(domain_pred1('sa-request')),
    assert(domain_pred1('sa-reject')),
    assert(domain_pred1('speech-act')),
    assert(domain_pred1('sa-yn-question')),
    assert(domain_pred1('sa-wh-question')),
    assert(domain_pred1('reply')),
    assert(domain_pred1('new-subplan')),
    assert(domain_pred1('update-pss')),
    assert(domain_pred1('pss-update')),
    assert(domain_pred1('answer')),
    assert(domain_pred1('express')),
    assert(domain_pred1('plan-updated')),
    assert(domain_pred1('new-subplan')),
    assert(domain_pred1('plan-state')),
    assert(domain_pred1(tell)),
    assert(domain_pred1(quit)),
    assert(domain_pred1(restart)),
    assert(domain_pred2(description)),
    assert(domain_pred2('path')),
    assert(domain_pred2('prop')),
    assert(domain_pred2(go)),
    assert(remove_leading_colon),!,
    assert(use_kvs),!,
    assert(use_kv2s),!.
%dm_init1.

dm_init1 :-
    sendmsg1(['TELL :RECEIVER IM :CONTENT (READY)']),
    sendmsg1(['REQUEST :SENDER DM :RECEIVER IM :CONTENT (LISTEN PARSER)']).

/*
retraction code
*/

%retract the assertions about utterance ID
make_retracts(ID) :-
    kqml_retract(ID),
    retractall(ireq(lex(_,_),ID)),
    retractall(ireq(aPSPair(_,_),ID)),
    retractall(ireq(newname(_,_),ID)),
    retractall(ireq(aPSAction(_,_),ID)),
    retractall(ireq(aPSContent(_,_),ID)),
    retractall(ireq(aPSType(_,_),ID)),
    retractall(ireq(aPSCommand(_,_),ID)),
    retractall(ireq(psAspects(_,_),ID)),
    retractall(ireq(psConstraint(_,_,_),ID)),
    retractall(ireq(bindings(_,_),ID)),
    retractall(ireq(lcomp(_,_),ID)),
    retractall(ireq(lobj(_,_),ID)),
    retractall(ireq(lsubj(_,_),ID)),
    retractall(ireq(sem(_,_),ID)),
    retractall(ireq(to(PPath,To),ID)),
    retractall(ireq(constraint(_,_),ID)),
    retractall(ireq(from(_,_),ID)),
    retractall(ireq(path(_,_),ID)),
    retractall(ireq(at-loc(_,_),ID)),
    retractall(ireq(constraint(_,_),ID)),
    retractall(ireq(lex(_,_),ID)),
    retractall(ireq(constraint(_,_,_),ID)),
    retractall(ireq(class(_,_),ID)),
    retractall(ireq(obj(_,_),ID)),
    retractall(ireq(focus(_,_),ID)),
    retractall(ireq(type(_,_),ID)),
    retractall(ireq(sort-of(_,_),ID)),
    retractall(ireq(msg(_,_),ID)),
    retractall(ireq(status(_,_),ID)),
    retractall(ireq(lf(_,_),ID)),
    retractall(ireq(curr_utt(_),ID)),
    retractall(dreq(lex(_,_),ID)),
    retractall(dreq(aPSPair(_,_),ID)),
    retractall(dreq(newname(_,_),ID)),
    retractall(dreq(aPSAction(_,_),ID)),
    retractall(dreq(aPSContent(_,_),ID)),
    retractall(dreq(aPSType(_,_),ID)),
    retractall(dreq(aPSCommand(_,_),ID)),
    retractall(dreq(psAspects(_,_),ID)),
    retractall(dreq(psConstraint(_,_,_),ID)),
    retractall(dreq(bindings(_,_),ID)),
    retractall(dreq(lcomp(_,_),ID)),
    retractall(dreq(lobj(_,_),ID)),
    retractall(dreq(lsubj(_,_),ID)),
    retractall(dreq(sem(_,_),ID)),
    retractall(dreq(to(PPath,To),ID)),
    retractall(dreq(constraint(_,_),ID)),
    retractall(dreq(from(_,_),ID)),
    retractall(dreq(path(_,_),ID)),
    retractall(dreq(at-loc(_,_),ID)),
    retractall(dreq(constraint(_,_),ID)),
    retractall(dreq(lex(_,_),ID)),
    retractall(dreq(constraint(_,_,_),ID)),
    retractall(dreq(class(_,_),ID)),
    retractall(dreq(obj(_,_),ID)),
    retractall(dreq(focus(_,_),ID)),
    retractall(dreq(type(_,_),ID)),
    retractall(dreq(sort-of(_,_),ID)),
    retractall(dreq(msg(_,_),ID)),
    retractall(dreq(status(_,_),ID)),
    retractall(dreq(lf(_,_),ID)),
    retractall(dreq(curr_utt(_),ID)).

/***********************************
special code to assert expressions in ALMA
******************************/

assert_expr(ID,Exprs) :- !,
    gensym(kqml,ID),
    oassert(kqml_expr(ID,Exprs)).

assert_head(ID,Head) :-
    gensym(kqml,ID),
    oassert(kqml_head(ID,Head)).

/*********************
utility functions
*********************/

%gets the part of the input list structure which is bound to Var
getvarbinding(Var,Msg,Binding) :-
    getitem(Msg,Var,Item,1),
    Binding = [Var,Item].

%looks breadth-first inside Object for the list called Item that begins with Label
%if Num is anything other than 0 the Numth member of the list is returned as Item
getitem(O,Label,Item,Num) :-
    getitem1([O],Label,Item,Num).
getitem1([O|Objs],Label,Item,Num) :-
    O = [X|_],
    X = Label,
    Num > 0,
    getnth(O,Num,Item).
getitem1([O|Objs],Label,Item,Num) :-
    O = [X|Y],
    X = Label,
    Num =:= 0,
    Item = O.
getitem1([O|Objs],Label,Item,Num) :-
    O = [X|Y],
    \+ X = Label,
    append(Objs,O,NewObjs),
    getitem1(NewObjs,Label,Item,Num).
getitem1([O|Objs],Label,Item,Num) :-
    \+ O = [X],
    getitem1(Objs,Label,Item,Num).

%looks through a list to find the Numth Object after Label
%if Num is 0 then the remainder of the list is returned
getlistitem([O|Objs],Label,Item,Num) :-
    O = Label,
    Num == 0,
    Item = [O|Objs].
getlistitem([O|Objs],Label,Item,Num) :-
    O = Label,
    getnth([O|Objs],Num,Item).
getlistitem([O|Objs],Label,Item,Num) :-
    getlistitem(Objs,Label,Item,Num).

getnth([X|Xs],N,Obj) :-
    N == 0,
    Obj = X.
getnth([X|Xs],N,Obj) :-
    N > 0,
    N1 is N - 1,
    getnth(Xs,N1,Obj).

%takes a list and returns first member
car([First|_],First).
%takes a list and returns rest of list besides first member
cdr([_|Rest],Rest).

%necessary because one cannot use 'kqml___' in a msg
kqml_to_msg(Kqml,Msg) :-
    atom(Kqml),
    atom_chars(Kqml,[107,113,109,108|Rest]),
    atom_chars(Msg,[109,115,103|Rest]).

%current version that changes kqml cars into constants
%by adding a "\"
kqml_const(Kqml,Kqmlconst) :-
    atom(Kqml),
    atom_chars(Kqml,Chars1),
    Chars2 = [92|Chars1],
    atom_chars(Kqmlconst,Chars2).

msg_to_kqml(Msg,Kqml) :-
    atom(Msg),
    atom_chars(Msg,[109,115,103|Rest]),
    atom_chars(Kqml,[107,113,109,108|Rest]).

%used to assert formulas which are not to be passed on to alma
%if Var is uninstantiated do nothing.
passertall(Var) :-
    var(Var).

passertall([A|Asserts]) :-
    passert(A),
    passertall(Asserts).
passertall([]).

passert(Form) :-
    (clause(Form,true); 
    assert(Form)).

% do nothing for now
pretractall([A|Asserts]) :-
    pretract(A),
    pretractall(Asserts).
pretractall([]).

pretract(Form) :-
    (retractall(Form);
    true).









