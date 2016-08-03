%ALMA-based dialog manager Version 3:
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

%testing
test.
fif(test,conclusion(call(ah_init,[],0))).

%utterance creation
fif(and(new_message(ID),
        eval_bound(\+ pos_int(call(ah_preprocess_msg(ID),_,ID)), [ID])),
conclusion(call(ah_preprocess_msg(ID),[new_message(ID)],ID))).

%****
%LREQ
%****

fif(and(done(ah_preprocess_msg(ID),Asserts,ID),
    	sender(ID,score)),
conclusion(call(ah_translate_score(ID),Asserts,ID))).

fif(and(done(ah_preprocess_msg(ID),Asserts,ID),
    sender(ID,parser)),
conclusion(lreq(utterance(ID),ID))).

fif(and(lreq(utterance(ID),ID), 
    eval_bound(\+ pos_int(utt_list(_)), [ID])),
conclusion(utt_list([ID]))).

fif(and(lreq(utterance(ID),ID), 
    and(utt_list(Ulist),
        eval_bound(\+ member(ID,Ulist),[ID, Ulist]))),
conclusion(update_utt_list(ID,Ulist))).

%Update Utterance list
fif(and(update_utt_list(ID,Ulist),
	eval_bound(delete_form(utt_list(Ulist)),[Ulist])),
conclusion(utt_list([ID|Ulist]))).

fif(and(done(ah_preprocess_msg(ID),Asserts,ID),
    sender(ID,ps)),
conclusion(psmsg(ID))).

%reply handling
fif(and(psmsg(ID2),
    and('in-reply-to'(ID2,ID3),
	msgname(ID1,ID3))),
conclusion(psreply(ID1,ID2))).

fif(and(lreq(utterance(ID),ID),
    and(utt_list([ID|[ID1|_]]),
    and(eval_bound(\+ pos_int(dreq(psbstate(ID,_),ID)),[ID]),
    	pact(psstate(_,PSState),ID1)))),
conclusion(dreq(psbstate(ID,PSState),ID))).

fif(and(lreq(utterance(ID),ID),
    and(utt_list([ID|[ID1|_]]),
    and(eval_bound(\+ pos_int(pact(psstate(_,_),ID1)),[ID1]),
        dreq(psbstate(_,PSState),ID1)))),
conclusion(dreq(psbstate(ID,PSState),ID))).

fif(and(lreq(utterance(ID),ID),
    and(utt_list([ID|[]]),
    	initial_ps_state(PSState))),
conclusion(dreq(psbstate(ID,PSState),ID))).
 
%**********************************************
%**********************************************

%send the new york train to boston

%****
%IREQ
%****
%utterance to interpretation
fif(lreq(utterance(ID),ID), 
conclusion(compute_ireq(ID))).

fif(and(compute_ireq(ID),
        new_message(ID)),
conclusion(call(ah_translate_parse(ID),[new_message(ID)],ID))).

fif(or(done(ah_translate_parse(ID),Asserts,ID),created_msg(ID)),
conclusion(done(compute_ireq(ID)))).

/*Maintain requests list*/
fif(and(ireq(type(ID,'sa-request'),ID),
	 eval_bound(\+ pos_int(req_utt_list(_)), [])),
conclusion(req_utt_list([ID]))).

fif(and(ireq(type(ID,'sa-request'),ID),
    and(req_utt_list(Ulist),
        eval_bound(\+ member(ID,Ulist),[ID, Ulist]))),
conclusion(update_req_utt_list(ID,Ulist))).

fif(and(update_req_utt_list(ID,Ulist),
	eval_bound(delete_form(req_utt_list(Ulist)),[Ulist])),
conclusion(req_utt_list([ID|Ulist]))).

%does one want to disambiguate all Objs at once or one at a time?
%no easy way to gather up predicates with bound vars
fif(done(compute_ireq(ID)),
conclusion(compute_dreq(ID))).

%****
%DREQ
%****

fif(compute_dreq(ID),
conclusion(copy_ireq_dreq(ID))).

/*this is awkward - there should be a way to express this more logically*/
fif(and(copy_ireq_dreq(ID),
    and(eval_bound(gather_all(ireq(Assert,ID),Asserts),[ID]),
        eval_bound(copy_all(dreq,Asserts,ID),[Asserts,ID]))),
conclusion(done(copy_ireq_dreq(ID)))).

fif(done(copy_ireq_dreq(ID)),
conclusion(disambiguate_dreq(ID))).

fif(and(disambiguate_dreq(ID),
    and(dreq(type(ID, 'sa-reject'), ID),
    and(dreq(focus(ID,Focus),ID),
    eval_bound(Focus \== nil,[Focus])))),
conclusion(done(disambiguate_dreq(ID)))).

fif(and(disambiguate_dreq(ID),
    and(dreq(type(ID,'sa-request'),ID),
    and(eval_bound(log_findall(Obj,[dreq(obj(ID,Obj),ID),
				    dreq(lex(Obj,null),ID)],[],Objs),[ID]),
        eval_bound(Objs == [],[Objs])))),
conclusion(done(disambiguate_dreq(ID)))).

/*This is for both requests and questions*/
fif(and(disambiguate_dreq(ID),
    and(dreq(obj(ID,Obj),ID),
        dreq(lex(Obj,null),ID))),
conclusion(dreq(disambiguate(ID,Obj),ID))).

%ask ps about unbound vars
%really would like a mechanism here to check
%FORALL X (obj(X) -> lex(X,Y) ^ not(null(Y)))
fif(and(dreq(disambiguate(ID,Obj),ID),
    and(dreq(lex(Obj,null),ID),
        eval_bound(gather_all(dreq(_,ID), Asserts),[ID]))),
conclusion(call(ah_kbr_question(ID,all,[],ID1),Asserts,ID))).

fif(and(disambiguate_dreq(ID),
    and(dreq(type(ID, 'sa-reject'),ID),
    and(dreq(focus(ID, nil), ID),
    and(req_utt_list([ID1|_]),
	eval_bound(mult_gather_all([dreq(_,ID), dreq(_,ID1)], Asserts),[ID,ID1]))))),
conclusion(call(ah_undo_state(ID,ID1),Asserts,ID))).

fif(and(disambiguate_dreq(ID),
    and(dreq(type(ID, 'sa-yn-question'), ID),
    and(eval_bound(log_findall(Obj,[dreq(obj(ID,Obj),ID),
				    dreq(lex(Obj,null),ID)],[],Objs),[ID]),
    eval_bound(Objs == [],[Objs])))),
conclusion(dreq(check_constraint(ID)))).

fif(and(dreq(check_constraint(ID)),
    and(dreq(psConstraint(ID,Constraint,PSConstraint),ID),
        eval_bound(gather_all(dreq(_,ID), Asserts),[ID]))),
conclusion(call(ah_kbr_question(ID,if,PSConstraint,ID1),Asserts,ID))).

fif(and(done(ah_kbr_question(ID,_,_,ID1),_,_),
    and(psreply(ID1,ID2),
    and(new_message(ID2),
        eval_bound(mult_gather_all([dreq(lf(_,_),ID),
				    dreq(lex(_,_),ID)],Asserts),[ID])))),
conclusion(call(ah_translate_kbr(ID,ID2),[new_message(ID2)|Asserts],ID2))).

fif(dreq(result(ID1,nil),ID),
conclusion(dreq(result(ID,nil),ID))).

/*check whether we got all replies; if no nil result so far assert T*/

fif(and(done(ah_translate_kbr(ID,_),_,_),
    and(eval_bound(\+ pos_int(doing(ah_translate_kbr(ID,ID2),Asserts,ID2)),[ID]),
	eval_bound(\+ pos_int(dreq(result(_,nil),ID)), [ID]))),
conclusion(dreq(result(ID,'T'),ID))).

/*if all objects are bound then disambiguation is complete*/
fif(and(disambiguate_dreq(ID),
    and(dreq(lex(Var,Value),ID),
    and(eval_bound(\+ pos_int(check_constraint(ID)),[ID]),
    and(eval_bound(\+ pos_int(done(disambiguate_dreq(ID))),[ID]),
    and(eval_bound(log_findall(Obj,[dreq(obj(ID,Obj),ID),dreq(lex(Obj,null),ID)],[],Objs),[ID]),
        eval_bound(Objs == [],[Objs])))))),
conclusion(done(disambiguate_dreq(ID)))).

/*reference resolution*/

fif(and(dreq(type(ID,'sa-yn-question'),ID),
    and(dreq(candidates(Var,Binding),ID),
    	eval_bound(delete_form(dreq(lex(Var,null),ID)),[ID]))),
conclusion(dreq(lex(Var,Binding),ID))).

fif(and(dreq(type(ID,'sa-wh-question'),ID),
    and(dreq(candidates(Var,Binding),ID),
    	eval_bound(delete_form(dreq(lex(Var,null),ID)),[ID]))),
conclusion(dreq(lex(Var,Binding),ID))).

fif(and(dreq(type(ID,'sa-request'),ID),
    and(dreq(lf(_,[move,_,_]),ID),
    and(dreq(candidates(Var,Bindings),ID),
	eval_bound(mult_gather_all([dreq(_,ID), not(move(_,_))],Asserts),[ID])))),
conclusion(call(ah_resolve_ref(ID,Var,Bindings),Asserts,ID))).

fif(and(done(ah_resolve_ref(ID,Var,Bindings),Asserts,ID),
	dreq(lex(Var,null),ID)),
conclusion(ref_confusion(ID,Var,Bindings))).

/*if  result, then disambiguation is done*/
fif(and(dreq(result(ID,_),ID),
    and(dreq(type(ID,Type),ID),
    and(eval_bound(Type \== 'sa-request', [Type]),
    eval_bound(\+ pos_int(done(disambiguate_dreq(ID))),[ID])))),
conclusion(done(disambiguate_dreq(ID)))).

fif(error(ah_translate_kbr(ID,ID2),_,ID2),
conclusion(call(senderrmsg(ID),[],ID))).

fif(done(disambiguate_dreq(ID)),
conclusion(done(compute_dreq(ID)))).

fif(ref_confusion(ID,Var,Bindings),
conclusion(done(compute_dreq(ID)))).

fif(done(compute_dreq(ID)),
conclusion(compute_pact(ID))).

%********
%The intensional model
%*******
fif(and(dreq(lf(_,[move,Eng,Cit]),ID),
    and(dreq(lex(Eng,Engine),ID),
    and(dreq(lex(Cit,City),ID),
    and(eval_bound(Engine\== null, [Engine]),
    	eval_bound(City \== null, [City]))))),
conclusion(move(Engine,City))).    

%****************Contradiction handling*************

fif(and(contra(X,Y,Z),
    and(eval_bound(name_to_formula(X,Form),[X]),
    and(or(eval_bound(Form = [move(Engine,City)], [Form]),
	   eval_bound(Form = [not(move(Engine,City))], [Form])),
    and(eval_bound(name_to_time(X,T1),[X]),
    and(eval_bound(name_to_time(Y,T2),[Y]),
	eval_bound((T2 > T1 -> ReForm=X; ReForm=Y), [T1,T2,X,Y])))))),  % Funny, I would expect T2< T1!!! -darsana
conclusion(reinstate(ReForm))).

%****
%PACT
%****

fif(and(compute_pact(ID),
    and(dreq(type(ID,'sa-yn-question'),ID),
    and(eval_bound(gather_all(dreq(Assert,ID),Asserts),[ID]),
        eval_bound(copy_all(pact,Asserts,ID),[Asserts])))),
conclusion(done(compute_pact(ID)))).

fif(and(compute_pact(ID),
    and(dreq(type(ID,'sa-wh-question'),ID),
    and(eval_bound(gather_all(dreq(Assert,ID),Asserts),[ID]),
        eval_bound(copy_all(pact,Asserts,ID),[Asserts])))),
conclusion(done(compute_pact(ID)))).

fif(and(compute_pact(ID),
    and(new_message(ID),
    and(dreq(type(ID,'sa-reject'),ID),
    and(dreq(focus(ID,PSState),ID),
    and(pact(psstate(ID1,PSState),ID1),
    and(eval_bound(gather_all(pact(Assert,ID1),Asserts),[ID1]),
        eval_bound(copy_all(pact,Asserts,ID),[Asserts]))))))),
conclusion(done(compute_pact(ID)))).

fif(and(compute_pact(ID),
    and(dreq(type(ID,'sa-request'),ID),
   	ref_confusion(ID,_,_))),
conclusion(done(compute_pact(ID)))).

fif(and(compute_pact(ID),
    and(dreq(type(ID,'sa-request'),ID),
    and(eval_bound(\+pos_int(ref_confusion(ID,_,_)),[ID]),
        eval_bound(gather_all(dreq(_,ID),Asserts1),[ID])))),
conclusion(call(ah_ir_question(ID,':new-subplan',ID1),Asserts1,ID))).

/*Need ID1, since if the :new-subplan fails, we need to call 
ir_question and translate again*/
fif(and(done(ah_ir_question(ID,Plantype,ID1),_,_),
    psreply(ID1,ID2)),
conclusion(call(ah_translate_ir(ID,ID2,_),[new_message(ID2)],ID2))).

/*if result of translated ir with new-subplan is nil, try 'do-what-you-can'*/
fif(and(done(ah_translate_ir(ID,ID1,nil),_,ID1),
    and(eval_bound(\+ pos_int(done(ah_ir_question(ID,':do-what-you-can',_),_,ID)),[ID]),
	eval_bound(gather_all(dreq(_,ID),Asserts1),[ID]))),
conclusion(call(ah_ir_question(ID,':do-what-you-can',ID2),Asserts1,ID))).

%if we got a plan, the pact is complete
fif(and(compute_pact(ID),
    and(eval_bound(\+ pos_int(done(compute_pact(ID))),[ID]),
    and(done(ah_translate_ir(ID,ID1,ID2),_,ID1),
	eval_bound(ID2 \== nil, [ID2])))),
conclusion(done(compute_pact(ID)))).

fif(and(done(compute_pact(ID)),
    and(eval_bound(\+ pos_int(pact(psstate(_,_),ID)), [ID]),
        pact(psbstate(ID,PSState),ID))),
conclusion(pact(psstate(ID,PSState),ID))).

fif(error(ah_ir_question(ID,Plantype,ID1),_,ID),
conclusion(call(senderrmsg(ID),[],ID))).

fif(error(ah_translate_ir(ID,ID1,ID2),_,ID1),
conclusion(call(senderrmsg(ID),[],ID))).

fif(done(compute_pact(ID)),
conclusion(compute_eact(ID))).

%****
%EACT
%****
fif(and(compute_eact(ID),
    and(dreq(type(ID,'sa-yn-question'),ID),
    and(dreq(result(ID,nil),ID),
	eval_bound(gather_all(pact(_,ID),Asserts),[ID])))),
conclusion(call(ah_outmgrconfirm(ID,'deny',ID1),Asserts,ID))).

fif(and(compute_eact(ID),
    and(dreq(type(ID,'sa-yn-question'),ID),
    and(dreq(result(ID,'T'),ID),
	eval_bound(gather_all(pact(_,ID),Asserts),[ID])))),
conclusion(call(ah_outmgrconfirm(ID,'affirm',ID1),Asserts,ID))).

fif(and(compute_eact(ID),
    and(dreq(type(ID,'sa-wh-question'),ID),
	eval_bound(gather_all(pact(_,ID),Asserts),[ID]))),
conclusion(call(ah_outmgrconfirm(ID,'inform',ID1),Asserts,ID))).

fif(and(compute_eact(ID),
    and(dreq(type(ID,'sa-reject'),ID),
    and(eval_bound(\+ pos_int(done(compute_eact(ID))), [ID]),
	pact(psstate(_,PSState),ID)))),
conclusion(call(ah_ur_question(ID,':undo',PSState,ID1),[],ID))).

fif(and(compute_eact(ID),
    and(dreq(type(ID,'sa-request'),ID),
    and(eval_bound(\+ pos_int(ref_confusion(ID,_,_)),[ID]),
    and(eval_bound(\+ pos_int(done(compute_eact(ID))), [ID]),
	pact(psstate(ID,PSState),ID))))),
conclusion(call(ah_ur_question(ID,':update-pss',PSState,ID1),[],ID))).

fif(and(compute_eact(ID),
    and(done(ah_ur_question(ID,Type,_,_),_,ID),
	eval_bound(gather_all(pact(_,ID),Asserts),[ID]))),
conclusion(call(ah_outmgrconfirm(ID,Type,ID1),Asserts,ID))).

fif(and(compute_eact(ID),
    and(ref_confusion(ID,Var,_),
	dreq(class(Var,train),ID))),
conclusion(call(ah_outmgrconfirm(ID,'train-ref-err',ID1),[],ID))).

fif(and(compute_eact(ID),
    and(done(ah_ur_question(ID,_,_,ID1),_,ID),
        psreply(ID1,ID2))),
conclusion(call(ah_confirmsuccess(ID,ID2),[new_message(ID2)],ID))).

fif(error(ah_ur_question(ID,Type,ID2,ID3),_,ID),
conclusion(call(senderrmsg(ID),[],ID))).

fif(error(ah_confirmsuccess(ID,ID1),_,ID1),
conclusion(call(senderrmsg(ID),[],ID))).

fif(done(ah_outmgrconfirm(ID,_,_),Asserts,ID),
conclusion(done(compute_eact(ID)))).


%****
%OACT
%****

fif(done(ah_confirmsuccess(ID,ID1),_,ID),
conclusion(oact(plan_confirmed(ID,ID1),ID))).

fif(and(oact(plan_confirmed(ID,ID1),ID),
        done(ah_outmgrconfirm(ID,_,_),Asserts,ID)),
conclusion(done(compute_eact(ID)))).

fif(and(reset_alma(ID),
        eval_bound(reset_alma,[])),
conclusion(and(alma_reset(ID),
               df(reset_alma(ID))))).


