isa(plan, plan1).
has(left_wall, plan1, lw1).

has(action, plan1, action1).
has(action, plan1, action2).
has(action, plan1, action3).
has(action, plan1, action4).
has(action, plan1, action5).
has(action, plan1, action6).
has(action, plan1, action7).
has(action, plan1, action8).
has(action, plan1, action9).
has(action, plan1, action10).
has(action, plan1, action11).
has(action, plan1, action12).
has(action, plan1, action13).
has(action, plan1, action14).
has(action, plan1, action15).
has(action, plan1, action16).

has(successor, lw1, action1).
has(successor, action1, action2).
has(successor, action2, action3).
has(successor, action3, action4).
has(successor, action4, action5).
has(successor, action5, action6).
has(successor, action6, action7).
has(successor, action7, action8).
has(successor, action8, action9).
has(successor, action9, action10).
has(successor, action10, action11).
has(successor, action11, action12).
has(successor, action12, action13).
has(successor, action13, action14).
has(successor, action14, action15).
has(successor, action15, action16).

has(token, act1, action1).
has(token, act2, action2).
has(token, act3, action3).
has(token, act4, action4).
has(token, act5, action5).
has(token, act6, action6).
has(token, act7, action7).
has(token, act8, action8).
has(token, act9, action9).
has(token, act10, action10).
has(token, act11, action11).
has(token, act12, action12).
has(token, act13, action13).
has(token, act14, action14).
has(token, act15, action15).
has(token, act16, action16).


/*Starts plan*/
fif(and(isa(plan, Plan),
       and(has(left_wall, Plan, LW),
           has(successor, LW, Action))),
conclusion(begin(Action, Utt))).

/*ACTOR*/

fif(end(Action, _),
conclusion(done(Action))).
   
fif(and(end(Action, Output),
	has(successor, Action, Next_Action)),
conclusion(begin(Next_Action, Input))).

fif(and(end(Action, Output),
	and(has(action, Plan, Action),
	    eval_bound(\+ pos_int_u(has(successor, Action, Next_Action)), [Action]))),
conclusion(done(Plan))).

/*ACTS*/

/*Act 1*/

fif(and(begin(Action),
	has(token, act1, Action)),
conclusion(started(Action, act1))).

fif(started(Action, act1),
conclusion(end(Action))).


/*Act 2*/

fif(and(begin(Action),
	has(token, act2, Action)),
conclusion(started(Action, act2))).

fif(started(Action, act2),
conclusion(end(Action))).


/*Act 3*/

fif(and(begin(Action),
	has(token, act3, Action)),
conclusion(started(Action, act3))).

fif(started(Action, act3),
conclusion(end(Action))).

