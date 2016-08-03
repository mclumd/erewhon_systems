/*ID Number Policies and Registry
  Domain IDs: d#
              d0 = User/English
 
  Language IDs: c#
                c2 = English
 */

/******

EXECUTOR CODE

******/

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
       and(has(input, Plan, Input),
	   and(has(left_wall, Plan, LW),
	       has(successor, LW, Action)))),
conclusion(begin(Action, Input))).

/*ACTOR*/

fif(end(Action, _),
conclusion(done(Action))).
   
fif(and(end(Action, IO),
	has(successor, Action, Next_Action)),
conclusion(begin(Next_Action, IO))).

fif(and(end(Action, Output),
	and(has(action, Plan, Action),
	    eval_bound(\+ pos_int_u(has(successor, Action, Next_Action)), [Action]))),
conclusion(done(Plan))).

/*------- END EXECUTOR ------------ */

curMaxUniqueID(1).
notify_user(hello).
notify_user(initializing_alfred).


/*PRINTING TO SCREEN*/
/*Notify user that lexeme is completed.*/
fif(notify_user(lexemes_built),
    conclusion(alma(format('~n~nLexemes have been built.~nReady to accept utterances.~n~n',[])))).

fif(notify_user(hello),
    conclusion(alma(format('~n~nHello! I am Alfred.~n~nLet me initialize my lexicon before we start chatting.~n~n',[])))).

fif(notify_user(initializing_alfred),
    conclusion(alma(format('~n...initializing lexicon...~n',[])))).

fif(notify_user(Utt, processing_utterance),
    conclusion(alma(format('~n...begin processing utterance...~n',[])))).

fif(notify_user(Utt, parsing_utt),
    conclusion(alma(format('~n...parsing your utterance...~n',[])))).

fif(notify_user(Utt, parsing_utt_done),
    conclusion(alma(format('finished...~n',[])))).

fif(notify_user(Utt, theta_begin),
    conclusion(alma(format('~n...begin theta role assignment...~n',[])))).

fif(notify_user(Utt, theta_done),
    conclusion(alma(format('finished...~n',[])))).

fif(notify_user(Utt, begin_LF),
    conclusion(alma(format('~n...building logical form...~n',[])))).

fif(notify_user(Utt, end_LF),
    conclusion(alma(format('finished...~n',[])))).

fif(notify_user(Utt, building_domain_command_structure),
    conclusion(alma(format('~n...building domain command structure...~n',[])))).

fif(notify_user(Utt, done_building_command_structure),
    conclusion(alma(format('finished...~n',[])))).

fif(notify_user(Utt, begin_command),
    conclusion(alma(format('~n...linearizing domain command...~n',[])))).

fif(notify_user(Utt, command_string_done, Done_Command_String),
    conclusion(alma(format('~n...finished...string built is "~a"~n', Done_Command_String)))).

fif(notify_user(Utt, command_string_sent),
    conclusion(alma(format('~n...sent command string...~n',[])))).

/**********

   Romanized Alphanumeric Characters

***********/

/*build members of english alphabet, with both lowercase and
uppercase forms*/
/*Aa*/
isa(c1, letter, alpha1).
has(c1, member, c1, alpha1).
has(c1, form, alpha1, alpha1_lc).
isa(c1, lowercase, alpha1_lc).
has(c1, ascii_code, alpha1_lc, 97).
has(c1, form, alpha1, alpha1_uc).
isa(c1, uppercase, alpha1_uc).
has(c1, ascii_code, alpha1_uc, 65).
has(c1, successor, alpha1, alpha2).

/*Bb*/
isa(c1, letter, alpha2).
has(c1, member, c1, alpha2).
has(c1, form, alpha2, alpha2_lc).
isa(c1, lowercase, alpha2_lc).
has(c1, ascii_code, alpha2_lc, 98).
has(c1, form, alpha2, alpha2_uc).
isa(c1, uppercase, alpha2_uc).
has(c1, ascii_code, alpha2_uc, 66).
has(c1, successor, alpha2, alpha3).

/*Cc*/
isa(c1, letter, alpha3).
has(c1, member, c1, alpha3).
has(c1, form, alpha3, alpha3_lc).
isa(c1, lowercase, alpha3_lc).
has(c1, ascii_code, alpha3_lc, 99).
has(c1, form, alpha3, alpha3_uc).
isa(c1, uppercase, alpha3_uc).
has(c1, ascii_code, alpha3_uc, 67).
has(c1, successor, alpha3, alpha4).

/*Dd*/
isa(c1, letter, alpha4).
has(c1, member, c1, alpha4).
has(c1, form, alpha4, alpha4_lc).
isa(c1, lowercase, alpha4_lc).
has(c1, ascii_code, alpha4_lc, 100).
has(c1, form, alpha4, alpha4_uc).
isa(c1, uppercase, alpha4_uc).
has(c1, ascii_code, alpha4_uc, 68).
has(c1, successor, alpha4, alpha5).

/*Ee*/
isa(c1, letter, alpha5).
has(c1, member, c1, alpha5).
has(c1, form, alpha5, alpha5_lc).
isa(c1, lowercase, alpha5_lc).
has(c1, ascii_code, alpha5_lc, 101).
has(c1, form, alpha5, alpha5_uc).
isa(c1, uppercase, alpha5_uc).
has(c1, ascii_code, alpha5_uc, 69).
has(c1, successor, alpha5, alpha6).

/*Ff*/
isa(c1, letter, alpha6).
has(c1, member, c1, alpha6).
has(c1, form, alpha6, alpha6_lc).
isa(c1, lowercase, alpha6_lc).
has(c1, ascii_code, alpha6_lc, 102).
has(c1, form, alpha6, alpha6_uc).
isa(c1, uppercase, alpha6_uc).
has(c1, ascii_code, alpha6_uc, 70).
has(c1, successor, alpha6, alpha7).

/*Gg*/
isa(c1, letter, alpha7).
has(c1, member, c1, alpha7).
has(c1, form, alpha7, alpha7_lc).
isa(c1, lowercase, alpha7_lc).
has(c1, ascii_code, alpha7_lc, 103).
has(c1, form, alpha7, alpha7_uc).
isa(c1, uppercase, alpha7_uc).
has(c1, ascii_code, alpha7_uc, 71).
has(c1, successor, alpha7, alpha8).

/*Hh*/
isa(c1, letter, alpha8).
has(c1, member, c1, alpha8).
has(c1, form, alpha8, alpha8_lc).
isa(c1, lowercase, alpha8_lc).
has(c1, ascii_code, alpha8_lc, 104).
has(c1, form, alpha8, alpha8_uc).
isa(c1, uppercase, alpha8_uc).
has(c1, ascii_code, alpha8_uc, 72).
has(c1, successor, alpha8, alpha9).

/*Ii*/
isa(c1, letter, alpha9).
has(c1, member, c1, alpha9).
has(c1, form, alpha9, alpha9_lc).
isa(c1, lowercase, alpha9_lc).
has(c1, ascii_code, alpha9_lc, 105).
has(c1, form, alpha9, alpha9_uc).
isa(c1, uppercase, alpha9_uc).
has(c1, ascii_code, alpha9_uc, 73).
has(c1, successor, alpha9, alpha10).

/*Jj*/
isa(c1, letter, alpha10).
has(c1, member, c1, alpha10).
has(c1, form, alpha10, alpha10_lc).
isa(c1, lowercase, alpha10_lc).
has(c1, ascii_code, alpha10_lc, 106).
has(c1, form, alpha10, alpha10_uc).
isa(c1, uppercase, alpha10_uc).
has(c1, ascii_code, alpha10_uc, 74).
has(c1, successor, alpha10, alpha11).

/*Kk*/
isa(c1, letter, alpha11).
has(c1, member, c1, alpha11).
has(c1, form, alpha11, alpha11_lc).
isa(c1, lowercase, alpha11_lc).
has(c1, ascii_code, alpha11_lc, 107).
has(c1, form, alpha11, alpha11_uc).
isa(c1, uppercase, alpha11_uc).
has(c1, ascii_code, alpha11_uc, 75).
has(c1, successor, alpha11, alpha12).

/*Ll*/
isa(c1, letter, alpha12).
has(c1, member, c1, alpha12).
has(c1, form, alpha12, alpha12_lc).
isa(c1, lowercase, alpha12_lc).
has(c1, ascii_code, alpha12_lc, 108).
has(c1, form, alpha12, alpha12_uc).
isa(c1, uppercase, alpha12_uc).
has(c1, ascii_code, alpha12_uc, c290).
has(c1, successor, alpha12, alpha13).

/*Mm*/
isa(c1, letter, alpha13).
has(c1, member, c1, alpha13).
has(c1, form, alpha13, alpha13_lc).
isa(c1, lowercase, alpha13_lc).
has(c1, ascii_code, alpha13_lc, 109).
has(c1, form, alpha13, alpha13_uc).
isa(c1, uppercase, alpha13_uc).
has(c1, ascii_code, alpha13_uc, 77).
has(c1, successor, alpha13, alpha14).

/*Nn*/
isa(c1, letter, alpha14).
has(c1, member, c1, alpha14).
has(c1, form, alpha14, alpha14_lc).
isa(c1, lowercase, alpha14_lc).
has(c1, ascii_code, alpha14_lc, 110).
has(c1, form, alpha14, alpha14_uc).
isa(c1, uppercase, alpha14_uc).
has(c1, ascii_code, alpha14_uc, 78).
has(c1, successor, alpha14, alpha15).

/*Oo*/
isa(c1, letter, alpha15).
has(c1, member, c1, alpha15).
has(c1, form, alpha15, alpha15_lc).
isa(c1, lowercase, alpha15_lc).
has(c1, ascii_code, alpha15_lc, 111).
has(c1, form, alpha15, alpha15_uc).
isa(c1, uppercase, alpha15_uc).
has(c1, ascii_code, alpha15_uc, 79).
has(c1, successor, alpha15, alpha16).

/*Pp*/
isa(c1, letter, alpha16).
has(c1, member, c1, alpha16).
has(c1, form, alpha16, alpha16_lc).
isa(c1, lowercase, alpha16_lc).
has(c1, ascii_code, alpha16_lc, 112).
has(c1, form, alpha16, alpha16_uc).
isa(c1, uppercase, alpha16_uc).
has(c1, ascii_code, alpha16_uc, 80).
has(c1, successor, alpha16, alpha17).

/*Qq*/
isa(c1, letter, alpha17).
has(c1, member, c1, alpha17).
has(c1, form, alpha17, alpha17_lc).
isa(c1, lowercase, alpha17_lc).
has(c1, ascii_code, alpha17_lc, 113).
has(c1, form, alpha17, alpha17_uc).
isa(c1, uppercase, alpha17_uc).
has(c1, ascii_code, alpha17_uc, 81).
has(c1, successor, alpha17, alpha18).

/*Rr*/
isa(c1, letter, alpha18).
has(c1, member, c1, alpha18).
has(c1, form, alpha18, alpha18_lc).
isa(c1, lowercase, alpha18_lc).
has(c1, ascii_code, alpha18_lc, 114).
has(c1, form, alpha18, alpha18_uc).
isa(c1, uppercase, alpha18_uc).
has(c1, ascii_code, alpha18_uc, 82).
has(c1, successor, alpha18, alpha19).

/*Ss*/
isa(c1, letter, alpha19).
has(c1, member, c1, alpha19).
has(c1, form, alpha19, alpha19_lc).
isa(c1, lowercase, alpha19_lc).
has(c1, ascii_code, alpha19_lc, 115).
has(c1, form, alpha19, alpha19_uc).
isa(c1, uppercase, alpha19_uc).
has(c1, ascii_code, alpha19_uc, 83).
has(c1, successor, alpha19, alpha20).

/*Tt*/
isa(c1, letter, alpha20).
has(c1, member, c1, alpha20).
has(c1, form, alpha20, alpha20_lc).
isa(c1, lowercase, alpha20_lc).
has(c1, ascii_code, alpha20_lc, 116).
has(c1, form, alpha20, alpha20_uc).
isa(c1, uppercase, alpha20_uc).
has(c1, ascii_code, alpha20_uc, 84).
has(c1, successor, alpha20, alpha21).

/*Uu*/
isa(c1, letter, alpha21).
has(c1, member, c1, alpha21).
has(c1, form, alpha21, alpha21_lc).
isa(c1, lowercase, alpha21_lc).
has(c1, ascii_code, alpha21_lc, 117).
has(c1, form, alpha21, alpha21_uc).
isa(c1, uppercase, alpha21_uc).
has(c1, ascii_code, alpha21_uc, 85).
has(c1, successor, alpha21, alpha22).

/*Vv*/
isa(c1, letter, alpha22).
has(c1, member, c1, alpha22).
has(c1, form, alpha22, alpha22_lc).
isa(c1, lowercase, alpha22_lc).
has(c1, ascii_code, alpha22_lc, 118).
has(c1, form, alpha22, alpha22_uc).
isa(c1, uppercase, alpha22_uc).
has(c1, ascii_code, alpha22_uc, 86).
has(c1, successor, alpha22, alpha23).

/*Ww*/
isa(c1, letter, alpha23).
has(c1, member, c1, alpha23).
has(c1, form, alpha23, alpha23_lc).
isa(c1, lowercase, alpha23_lc).
has(c1, ascii_code, alpha23_lc, 119).
has(c1, form, alpha23, alpha23_uc).
isa(c1, uppercase, alpha23_uc).
has(c1, ascii_code, alpha23_uc, 87).
has(c1, successor, alpha23, alpha24).

/*Xx*/
isa(c1, letter, alpha24).
has(c1, member, c1, alpha24).
has(c1, form, alpha24, alpha24_lc).
isa(c1, lowercase, alpha24_lc).
has(c1, ascii_code, alpha24_lc, 120).
has(c1, form, alpha24, alpha24_uc).
isa(c1, uppercase, alpha24_uc).
has(c1, ascii_code, alpha24_uc, 88).
has(c1, successor, alpha24, alpha25).

/*Yy*/
isa(c1, letter, alpha25).
has(c1, member, c1, alpha25).
has(c1, form, alpha25, alpha25_lc).
isa(c1, lowercase, alpha25_lc).
has(c1, ascii_code, alpha25_lc, 121).
has(c1, form, alpha25, alpha25_uc).
isa(c1, uppercase, alpha25_uc).
has(c1, ascii_code, alpha25_uc, 89).
has(c1, successor, alpha25, alpha26).

/*Zz*/
isa(c1, letter, alpha26).
has(c1, member, c1, alpha26).
has(c1, form, alpha26, alpha26_lc).
isa(c1, lowercase, alpha26_lc).
has(c1, ascii_code, alpha26_lc, 122).
has(c1, form, alpha26, alpha26_uc).
isa(c1, uppercase, alpha26_uc).
has(c1, ascii_code, alpha26_uc, 90).





/*build members of english digits*/

isa(c3, digit_symbols, c3).

/*0*/
isa(c3, digit, num0).
has(c3, member, c3, num0).
has(c3, ascii_code, num0, 48).
has(c3, successor, num0, num1).

/*1*/
isa(c3, digit, num1).
has(c3, member, c3, num1).
has(c3, ascii_code, num1, 49).
has(c3, successor, num1, num2).

/*2*/
isa(c3, digit, num2).
has(c3, member, c3, num2).
has(c3, ascii_code, num2, 50).
has(c3, successor, num2, num3).

/*3*/
isa(c3, digit, num3).
has(c3, member, c3, num3).
has(c3, ascii_code, num3, 51).
has(c3, successor, num3, num4).

/*4*/
isa(c3, digit, num4).
has(c3, member, c3, num4).
has(c3, ascii_code, num4, 52).
has(c3, successor, num4, num5).

/*5*/
isa(c3, digit, num5).
has(c3, member, c3, num5).
has(c3, ascii_code, num5, 53).
has(c3, successor, num5, num6).

/*6*/
isa(c3, digit, num6).
has(c3, member, c3, num6).
has(c3, ascii_code, num6, 54).
has(c3, successor, num6, num7).

/*7*/
isa(c3, digit, num7).
has(c3, member, c3, num7).
has(c3, ascii_code, num7, 55).
has(c3, successor, num7, num8).

/*8*/
isa(c3, digit, num8).
has(c3, member, c3, num8).
has(c3, ascii_code, num8, 56).
has(c3, successor, num8, num9).

/*9*/
isa(c3, digit, num9).
has(c3, member, c3, num9).
has(c3, ascii_code, num9, 57).

/******
Begin language insert
******/
/*English for Planes and Mars:*/


/*Build a domain.*/
isa(d0, domain, d0).

/*Build a language and make it part of the domain.*/
isa(d0, language, c2).
has(d0, language, d0, c2).

/*Make categories*/
/*
c2cat1 -- c2cat3
*/

isa(c2, category, c2cat1).
has(c2, category, c2, c2cat1).
has(c2, label, c2cat1, v).

isa(c2, category, c2cat2).
has(c2, category, c2, c2cat2).
has(c2, label, c2cat2, n).

isa(c2, category, c2cat3).
has(c2, category, c2, c2cat3).
has(c2, label, c2cat3, p).




/*Domain Syntax Rules:
*/
/*
c2syntax1 -- c2syntax6

*/


/*S --> VP*/
isa(c2, domain_syntax_rule, c2syntax1).
has(c2, domain_syntax_rule, c2, c2syntax1).
has(c2, left_hand_side, c2syntax1, s).
has(c2, right_hand_side, c2syntax1, [vp]).
has(c2, semantic_checker_rule, c2syntax1, scr1).

/*VP --> V . NP*/
isa(c2, domain_syntax_rule, c2syntax2).
has(c2, domain_syntax_rule, c2, c2syntax2).
has(c2, left_hand_side, c2syntax2, vp).
has(c2, right_hand_side, c2syntax2, [v, np]).
has(c2, semantic_checker_rule, c2syntax2, scr3).

/*VP --> V*/
isa(c2, domain_syntax_rule, c2syntax3).
has(c2, domain_syntax_rule, c2, c2syntax3).
has(c2, left_hand_side, c2syntax3, vp).
has(c2, right_hand_side, c2syntax3, [v]).
has(c2, semantic_checker_rule, c2syntax3, scr1).

/*VP --> VP PP*/
isa(c2, domain_syntax_rule, c2syntax4).
has(c2, domain_syntax_rule, c2, c2syntax4).
has(c2, left_hand_side, c2syntax4, vp).
has(c2, right_hand_side, c2syntax4, [vp, pp]).
has(c2, semantic_checker_rule, c2syntax4, scr3).

/*NP --> N*/
isa(c2, domain_syntax_rule, c2syntax5).
has(c2, domain_syntax_rule, c2, c2syntax5).
has(c2, left_hand_side, c2syntax5, np).
has(c2, right_hand_side, c2syntax5, [n]).
has(c2, semantic_checker_rule, c2syntax5, scr4).

/*PP --> P NP*/
isa(c2, domain_syntax_rule, c2syntax6).
has(c2, domain_syntax_rule, c2, c2syntax6).
has(c2, left_hand_side, c2syntax6, pp).
has(c2, right_hand_side, c2syntax6, [p, np]).
has(c2, semantic_checker_rule, c2syntax6, scr2).


/*Make concepts for English theta-roles*/
/*
c2theta1 -- c2theta3
meanstheta1 -- meanstheta3
*/

/*Patient*/
isa(c2, theta_role, c2theta1).
has(c2, theta_role, c2, c2theta1).

/*Location*/
isa(c2, theta_role, c2theta2).
has(c2, theta_role, c2, c2theta2).

/*Destination*/
isa(c2, theta_role, c2theta3).
has(c2, theta_role, c2, c2theta3).

/*Make concepts for event_participants, i.e., meanings of theta-roles*/
/*Patient*/
isa(meanstheta1, meaning, meanstheta1).
isa(meanstheta1, event_participant, meanstheta1).
has(c2theta1, content, c2theta1, meanstheta1).

/*Location*/
isa(meanstheta2, meaning, meanstheta2).
isa(meanstheta2, event_participant, meanstheta2).
has(c2theta2, content, c2theta2, meanstheta2).

/*Destination*/
isa(meanstheta3, meaning, meanstheta3).
isa(meanstheta3, event_participant, meanstheta3).
has(c2theta3, content, c2theta3, meanstheta3).


/*Lexemes:
c2lex1 -- c2lex27
means1 -- means22
*/

/*For Planesh:*/
/*---- Verbs ----*/
/*report*/
do_add_lexeme(c2lex1, c2, report, c2cat1, means1, predicate, c2theta1).

/*circle*/
do_add_lexeme(c2lex3, c2, circle, c2cat1, means3, predicate, c2theta1).

/*disconnect*/
do_add_lexeme(c2lex6, c2, disconnect, c2cat1, means6, predicate, c2theta1).

/*land*/
do_add_lexeme(c2lex7, c2, land, c2cat1, means7, predicate, c2theta1).

/*close*/
do_add_lexeme(c2lex26, c2, close, c2cat1, means22, predicate, c2theta1).

/*---- Nouns ----*/
/*Grammar*/
do_add_lexeme(c2lex2, c2, grammar, c2cat2, means2, constant, nil).

/*Plane33*/
do_add_lexeme(c2lex4, c2, plane33, c2cat2, means4, constant, nil).

/*Plane44*/
do_add_lexeme(c2lex10, c2, plane44, c2cat2, means9, constant, nil).

/*Planes*/
do_add_lexeme(c2lex5, c2, planes, c2cat2, means5, constant, nil).

/*Approach Path 22*/
do_add_lexeme(c2lex9, c2, path22, c2cat2, means8, constant, nil).

/*Approach Path 11*/
do_add_lexeme(c2lex11, c2, path11, c2cat2, means10, constant, nil).

/*Paths*/
do_add_lexeme(c2lex27, c2, paths, c2cat2, means5, constant, nil).


/*---- Prepositions ----*/
/*at*/
do_add_lexeme(c2lex8, c2, at, c2cat3, nil, nil, c2theta2).


/*For Roverese:*/

/*---- Verbs ----*/
/*charge*/
do_add_lexeme(c2lex12, c2, charge, c2cat1, means11, predicate, nil).

/*recharge*/
do_add_lexeme(c2lex13, c2, recharge, c2cat1, means11, predicate, nil).

/*acknowledge*/
do_add_lexeme(c2lex14, c2, acknowledge, c2cat1, means12, predicate, nil).

/*localize*/
do_add_lexeme(c2lex15, c2, localize, c2cat1, means13, predicate, nil).

/*calibrate*/
do_add_lexeme(c2lex19, c2, calibrate, c2cat1, means17, predicate, nil).

/*move*/
do_add_lexeme(c2lex22, c2, move, c2cat1, means20, predicate, nil).

/*go*/
do_add_lexeme(c2lex24, c2, go, c2cat1, means20, predicate, nil).

/*experiment*/
do_add_lexeme(c2lex25, c2, experiment, c2cat1, means21, predicate, nil).

/*---- Nouns ----*/
/*WayStation0*/
do_add_lexeme(c2lex16, c2, waystation0, c2cat2, means14, constant, nil).

/*WayStation1*/
do_add_lexeme(c2lex17, c2, waystation1, c2cat2, means15, constant, nil).

/*WayStation2*/
do_add_lexeme(c2lex18, c2, waystation2, c2cat2, means16, constant, nil).

/*ScienceStation0*/
do_add_lexeme(c2lex20, c2, science0, c2cat2, means18, constant, nil).

/*ScienceStation1*/
do_add_lexeme(c2lex21, c2, science1, c2cat2, means19, constant, nil).

/*---- Prepositions ----*/
/*see 'at' above.*/

/*to*/
do_add_lexeme(c2lex23, c2, to, c2cat3, nil, nil, c2theta3).


/*For Corobotese:*/

/*---- Verbs ----*/


/*---- Nouns ----*/


/*---- Prepositions ----*/


/*---- Determiners ----*/





/*Roverese:  To be used with Matt's mars rover simulation with MonCon.

*/


/*Build Roverese domain d4.*/
isa(d4, domain, d4).

/*Build Roverese language c4 and make it part of the domain.*/
isa(d4, language, c4).
has(d4, language, d4, c4).

/*Make categories*/
/*

c4cat1 -- c4cat4

*/

isa(c4, category, c4cat1).
has(c4, category, c4, c4cat1).
has(c4, label, c4cat1, mr_c).

isa(c4, category, c4cat2).
has(c4, category, c4, c4cat2).
has(c4, label, c4cat2, adjunct).

isa(c4, category, c4cat3).
has(c4, category, c4, c4cat3).
has(c4, label, c4cat3, way_station).

isa(c4, category, c4cat4).
has(c4, category, c4, c4cat4).
has(c4, label, c4cat4, sci_station).


/*Domain Syntax Rules:*/
/*
c4syntax1 -- c4syntax8
*/

/*S -> MR_CP*/
isa(c4, domain_syntax_rule, c4syntax1).
has(c4, domain_syntax_rule, c4, c4syntax1).
has(c4, left_hand_side, c4syntax1, s).
has(c4, right_hand_side, c4syntax1, [mr_cp]).
has(c4, semantic_checker_rule, c4syntax1, scr1).

/*MR_CP -> MR_C*/
isa(c4, domain_syntax_rule, c4syntax2).
has(c4, domain_syntax_rule, c4, c4syntax2).
has(c4, left_hand_side, c4syntax2, mr_cp).
has(c4, right_hand_side, c4syntax2, [mr_c]).
has(c4, semantic_checker_rule, c4syntax2, scr1).

/*MR_CP -> MR_CP, AdjunctP*/
isa(c4, domain_syntax_rule, c4syntax3).
has(c4, domain_syntax_rule, c4, c4syntax3).
has(c4, left_hand_side, c4syntax3, mr_cp).
has(c4, right_hand_side, c4syntax3, [mr_cp, adjunctp]).
has(c4, semantic_checker_rule, c4syntax3, scr3).

/*AdjunctP -> Adjunct, Way_StationP*/
isa(c4, domain_syntax_rule, c4syntax4).
has(c4, domain_syntax_rule, c4, c4syntax4).
has(c4, left_hand_side, c4syntax4, adjunctp).
has(c4, right_hand_side, c4syntax4, [adjunct, way_stationp]).
has(c4, semantic_checker_rule, c4syntax4, scr2).

/*Way_StationP -> Way_Station*/
isa(c4, domain_syntax_rule, c4syntax5).
has(c4, domain_syntax_rule, c4, c4syntax5).
has(c4, left_hand_side, c4syntax5, way_stationp).
has(c4, right_hand_side, c4syntax5, [way_station]).
has(c4, semantic_checker_rule, c4syntax5, scr4).

/*Sci_StationP -> Sci_Station*/
isa(c4, domain_syntax_rule, c4syntax6).
has(c4, domain_syntax_rule, c4, c4syntax6).
has(c4, left_hand_side, c4syntax6, sci_stationp).
has(c4, right_hand_side, c4syntax6, [sci_station]).
has(c4, semantic_checker_rule, c4syntax6, scr4).

/*MR_CP -> MR_C, Sci_stationP*/
isa(c4, domain_syntax_rule, c4syntax7).
has(c4, domain_syntax_rule, c4, c4syntax7).
has(c4, left_hand_side, c4syntax7, mr_cp).
has(c4, right_hand_side, c4syntax7, [mr_c, sci_stationp]).
has(c4, semantic_checker_rule, c4syntax7, scr3).

/*MR_CP -> MR_C, Way_stationP*/
isa(c4, domain_syntax_rule, c4syntax8).
has(c4, domain_syntax_rule, c4, c4syntax8).
has(c4, left_hand_side, c4syntax8, mr_cp).
has(c4, right_hand_side, c4syntax8, [mr_c, way_stationp]).
has(c4, semantic_checker_rule, c4syntax8, scr3).

/*Make concepts for event_participants, i.e., meanings of theta-roles.
  Make sure this meaning is linked to the English equivalent theta-role.*/
/*
c4theta1 -- c4theta2
*/

/*Make concepts for Roverese theta-roles*/
/*Location*/
isa(c4, theta_role, c4theta1).
has(c4, theta_role, c4, c4theta1).
has(c4theta1, content, c4theta1, meanstheta2).

/*Destination*/
isa(c4, theta_role, c4theta2).
has(c4, theta_role, c4, c4theta2).
has(c4theta2, content, c4theta2, meanstheta3).


/*Create lexemes and their meanings:*/

/*
c4lex1 -- c4lex12

Use means# from English grammar file.
*/

/*---- Commands ----*/
/*Use "do_add_lexeme(lexemeID, LangID, string, categoryID, meaningID, semantic_type, theta_role_assigned)*/
/*charge*/
do_add_lexeme(c4lex1, c4, charge, c4cat1, means11, predicate, nil).

/*ack (rover)*/
do_add_lexeme(c4lex2, c4, ack, c4cat1, means12, predicate, nil).

/*loc*/
do_add_lexeme(c4lex3, c4, localize, c4cat1, means13, predicate, nil).

/*cal*/
do_add_lexeme(c4lex8, c4, cal, c4cat1, means17, predicate, c4theta1).

/*moveto*/
do_add_lexeme(c4lex10, c4, moveto, c4cat1, means20, predicate, c4theta2).

/*science*/
do_add_lexeme(c4lex12, c4, science, c4cat1, means21, predicate, c4theta1).

/*---- Arguments ----*/
/*0 (Way Station)*/
do_add_lexeme(c4lex5, c4, '0', c4cat3, means14, constant, nil).

/*1 (Way Station)*/
do_add_lexeme(c4lex6, c4, '1', c4cat3, means15, constant, nil).

/*2 (Way Station)*/
do_add_lexeme(c4lex7, c4, '2', c4cat3, means16, constant, nil).

/*0 (Science Station)*/
do_add_lexeme(c4lex9, c4, '0', c4cat4, means18, constant, nil).

/*1 (Science Station)*/
do_add_lexeme(c4lex11, c4, '1', c4cat4, means19, constant, nil).


/*---- Relations ----*/
/*loc*/
do_add_lexeme(c4lex4, c4, loc, c4cat2, nil, nil, c4theta1).


/******
End language insert
******/


/*Start the process with do_add_lexeme() 
e.g. do_add_lexeme(lex1, c2, recharge, pos1, meaning1, predicate, nil). */

/*Add meaning - these may get added twice - once with English, once with Roverese*/
fif(do_add_lexeme(_, _, _, _, MeaningID, _, _),
    conclusion(isa(MeaningID, meaning, MeaningID))).

fif(do_add_lexeme(_, _, _, _, MeaningID, MeaningID_Type, _),
    conclusion(has(MeaningID, type, MeaningID, MeaningID_Type))).

/*Add lexeme*/
fif(do_add_lexeme(LexID, _, _, _, _, _, _),
    conclusion(isa(LexID, lexeme, LexID))).

fif(do_add_lexeme(LexID, Domain, _, _, _, _, _),
    conclusion(has(LexID, lexeme, Domain, LexID))).

/*UNNEEDED: Add category for Roverese words and category for English words*/
fif(do_add_lexeme(LexID, Domain, _, Cat, _, _, _),
   conclusion(has(LexID, category, LexID, Cat))).


fif(and(do_add_lexeme(LexID, _, _, _, _, _, _),
	eval_bound(cappend_string('str', LexID, LexIDStr), [LexID])),
    conclusion(isa(LexID, string, LexIDStr))).

fif(and(do_add_lexeme(LexID, _, _, _, _, _, _),
	isa(LexID, string, LexIDStr)),
    conclusion(has(LexID, string, LexID, LexIDStr))).

fif(and(do_add_lexeme(LexID, _, String_Value, _, _, _, _),
	isa(LexID, string, LexIDStr)),
    conclusion(has(LexID, string_value, LexIDStr, String_Value))).

fif(do_add_lexeme(LexID, _, _, _, MeaningID, _, _),
    conclusion(has(LexID, content, LexID, MeaningID))).

/*Add Theta-marking*/
fif(and(do_add_lexeme(LexID, _, _, _, _, _, Theta_role_ID),
	isa(Lang, theta_role, Theta_role_ID)),
    conclusion(isa(LexID, theta_assigner, LexID))).

fif(and(do_add_lexeme(LexID, _, _, _, _, _, Theta_role_ID),
	isa(Lang, theta_role, Theta_role_ID)),
    conclusion(has(LexID, theta_role_to_assign, LexID, Theta_role_ID))).


/*Call lexeme speller: applies to each English and
  Roverese lexeme that has already been built.*/
fif(and(isa(Lex, lexeme, Lex),
	and(has(Lex, lexeme, c2, Lex),
	    has(Lex, string_value, LexStrID, String))),
conclusion(call(ac_lexeme_speller(Lex, String),[Lex, String]))).

/*After lexemes have been asserted, link their letters up to
  the alphabet or number concepts (i.e., link the ascii
  codes of the letters to the alpha or number concept ascii
  codes.*/
/*1: Is character in alphabet concepts?*/
fif(and(ready_to_link_lexeme_letter_to_alpha_or_num(ConNum1, Ltr1, Acode1),
	    and(has(ConNum2, ascii_code, Ltr_form, Acode1),
		has(ConNum2, form, Ltr2, Ltr_form))),
    conclusion(has(ConNum1, token, Ltr2, Ltr1))).

/*2: Is character in number concepts?*/
fif(and(ready_to_link_lexeme_letter_to_alpha_or_num(ConNum1, Num1, Acode1),
	    and(has(ConNum2, ascii_code, Num2, Acode1),
		isa(ConNum2, digit, Num2))),
    conclusion(has(ConNum1, token, Num2, Num1))).

/*Notify user when all lexeme letters have been linked to an
  alpha or number concept.*/

fif(and(ready_to_link_lexeme_letter_to_alpha_or_num(ConNum, Char, Acode),
        eval_bound(\+ pos_int(has(ConNum, token, _, Char)),[ConNum, Char])),
    conclusion(notify_user(lexemes_built))).

/*Dialog Management:
  For now, this consists of rudimentary record keeping. All 
  utterances are kept in the dialog_list in order of their 
  initial appearance.

  Furthermore, all utterances are at any given time in one of 
  the following bins:
   1) new_utterance: the UI adds utterances to this predicate; in the
                     future, any message from the domain will start
                     here also.
   2) utterance_queue: an ordering of utterances waiting to be processed.
   3) current_utterance: there is at max only one current_utterance, it
                         is the utterance being processed
   4) done_utterance: an ordered list of utterances that have been processed.

  Utterances move from 1 to 2 to 3 to 4 during their processing.
*/
/*Create the dialog list with nothing in it.  The dialog list will
  simply be an ordering of every utterance, where order is determined
  by when the utterance is initially entered into Alfred's KB.  It
  is not an explicit list, but rather a series of utterances connected
  by the successor relation with the first and last being marked.

  The utterance_queue and the dialog_list are currently kept separate.
*/

/*Create dialog_list with nothing in it.*/
isa(dia1, dialog_list, alf1).
isa(dia1, left_wall, alf2).
isa(dia1, right_wall, alf3).
has(dia1, member, alf1, alf2).
has(dia1, member, alf1, alf3).
has(dia1, successor, alf2, alf3).

/*Create utterance_queue and its left and right walls which are
  in the successor relation to each other.*/
isa(dia1, utterance_queue, alf4).
isa(dia1, left_wall, alf5).
isa(dia1, right_wall, alf6).
has(dia1, member, alf4, alf5).
has(dia1, member, alf4, alf6).
has(dia1, successor, alf5, alf6).


/*If there is a new utterance, send it to the token_utt_comma call
  which does several things: 1) if there are no commas, then it
  adds the entire utterance to the dialog_list and utterance queue; 
  2) if there is a comma, then it splits the utterance up into two 
  utterances -- the first from before the comma and the second from 
  after -- and adds them both to the dialog_list and utterance_queue.*/



/*----------------------Top-level Control-------------------------*/
/*Start Plan by providing input*/
fif(isa(Utt, new_utterance),
conclusion(has(input, plan1, Utt))).

/*------------------End Top-level Control-------------------------------*/

/*Act1*/

fif(and(begin(Action, Utt),
	and(has(token, act1, Action),
           isa(Utt, new_utterance))),
conclusion(started(Action, act1, Utt))).

fif(and(started(Action, act1, Utt),
       and(isa(Utt, new_utterance),
        and(has(Utt, ascii_string, Ascii_string),
            and(has(dia1, successor, Last_in_queue, alf6),
                has(dia1, successor, Last_in_dialog, alf3))))),
conclusion(call(ac_token_utt_comma(Utt, Ascii_string, Last_in_queue, Last_in_dialog),[Utt, Ascii_string, Last_in_queue, Last_in_dialog]))).

fif(and(started(Action, Act, Utt),
    and(done_token_utt_comma(Utt),
       isa(Utt, utterance, New_Utt))),
conclusion(end(Action, New_Utt))).

/*When there is no current utterance, pop off the first element
  from the utterance_queue and make it current.*/
fif(and(eval_bound(\+ pos_int_u(isa(Utt, current_utterance)), []),
	and(isa(dia1, utterance_queue, Queue),
	    and(has(dia1, member, Queue, LW),
		and(isa(dia1, left_wall, LW),
		    and(has(dia1, successor, LW, Next_utt),
			and(has(dia1, successor, Next_utt, New_first_utt),
			    has(dia1, member, Queue, New_first_utt))))))),
conclusion(pop_off_utt_queue(Next_utt, New_first_utt, LW))).

fif(pop_off_utt_queue(Next_utt, _, _),
conclusion(isa(Next_utt, current_utterance))).

fif(pop_off_utt_queue(_, New_first_utt, LW),
conclusion(has(dia1, successor, LW, New_first_utt))).

fif(and(pop_off_utt_queue(Next_utt, New_first_utt, _),
       eval_bound(df(has(dia1, successor, Next_utt, New_first_utt)),[Next_utt, New_first_utt])),
conclusion(deleted(utt_successor))).

fif(and(pop_off_utt_queue(Next_utt, New_first_utt, _),
        and(isa(dia1, utterance_queue, Queue),
          eval_bound(df(isa(dia1, member, Queue, Next_utt)),[Queue, Next_utt]))),
conclusion(deleted(utt_as_member))).
/*When there is no current utterance, pop off the first element*/

fif(and(pop_off_utt_queue(Next_utt, New_first_utt, LW),
    eval_bound(df(has(dia1, successor, LW, Next_tt)),[LW, Next_utt])),
conclusion(deleted(lw_successor))).

fif(isa(Utt, current_utterance),
    conclusion(notify_user(Utt, processing_utterance))).




/******
 Action 2 : Translation creation
********/


fif(and(begin(Action, Utt),
	and(has(token, act2, Action),
           isa(Utt, current_utterance))),
conclusion(started(Action, act2, Utt))).

fif(and(started(Action, act2, Utt),
         and(eval_bound(form_to_name(isa(Utt, current_utterance), New_ID), [Utt]),
             eval_bound(cappend_num_to_string('trans', New_ID, Trans_ID), [New_ID]))),
    conclusion(create_new_translation(Utt, Trans_ID, c2))).

fif(create_new_translation(Utt, Trans_ID, Lang_ID),
conclusion(isa(Utt, translation, Trans_ID))).

fif(create_new_translation(Utt, Trans_ID, Lang_ID),
conclusion(has(Utt, language, Trans_ID, Lang_ID))).

fif(isa(Utt, translation, Trans_ID),
    conclusion(has(Utt, translation, Utt, Trans_ID))).

fif(and(has(Utt, ascii_string, Utt, Ascii_string),
        and(has(Utt, translation, Utt, Trans_ID),
            eval_bound(df(has(Utt, ascii_string, _)), [Utt]))),
    conclusion(has(Utt, ascii_string, Trans_ID, Ascii_string))).

fif(and(started(Action, act2, Utt),
    and(has(Utt, translation, Utt, Trans_ID),
	and(has(Utt, ascii_string, Trans_ID, _),
            create_new_translation(Utt, Trans_ID, c2)))),
conclusion(end(Action, Trans_ID))).

/******
 Action 3 : Tokenize utterance
******/

fif(and(begin(Action, TransID),
	and(has(token, act3, Action),
           and(isa(Utt, current_utterance),
               has(Utt, translation, Utt, TransID)))),
conclusion(started(Action, act3, TransID))).


/*Tokenize all current utterances into words and letters.*/
fif(and(started(Action, act3, TransID),
     and(isa(Utt, current_utterance),
        and(has(Utt, translation, Utt, TransID),
	   has(Utt, ascii_string, TransID, Sp)))),
  conclusion(call(ac_token_utt(Utt, Sp), [Utt,Sp]))).

/*match utterance letters to conceptual alphabet or digits.
  Split up into three rules: 1 - find characters in utterance;
  2 - see if character matches letter in alphabet;
  3 - see if character matches number in digits.
*/

/*The following code (1 - 3) is used to link letters in
  an utterance to the conceptual alphabet.*/
/*1: Find all characters in spellings associate with current utt.*/
fif(and(isa(Utt, current_utterance),
	and(isa(Utt, spelling, Sp),
	    and(has(Utt, letter, Sp, Char1),
		(has(Utt, ascii_code, Char1, Acode1))))),
    conclusion(ready_to_link_to_alpha_or_num(Utt, Char1, Acode1))).

/*2: Is character in alphabet concepts?*/
fif(and(ready_to_link_to_alpha_or_num(ConNum1, Ltr1, Acode1),
	    and(has(ConNum2, ascii_code, Ltr_form, Acode1),
		has(ConNum2, form, Ltr2, Ltr_form))),
    conclusion(has(ConNum1, token, Ltr2, Ltr1))).

/*3: Is character in number concepts?*/
fif(and(ready_to_link_to_alpha_or_num(ConNum1, Num1, Acode1),
	    and(has(ConNum2, ascii_code, Num2, Acode1),
		isa(ConNum2, digit, Num2))),
    conclusion(has(ConNum1, token, Num2, Num1))).



fif(and(started(Action, act3, TransID),
       and(ready_to_link_to_alpha_or_num(ConNum, Char, Acode),
          has(ConNum, token, Char2, Char))),
conclusion(end(Action, TransID))).

/**********
Action 4 : Lookup and match with lexemes, alphanumeric chars, and creates tokens 
**********/

/*Lexical Lookup*/
/*Find each word of utterance*/

fif(and(begin(Action, TransID),
	has(token, act4, Action)),
conclusion(started(Action, act4, TransID))).

fif(and(started(Action, act4, TransID),
       and(has(Utt, translation, Utt, TransID),
          and(isa(Utt, current_utterance),
            has(Utt, word, Utt, Word_needs_concept)))),
    conclusion(find_utt_word_in_lexicon(Utt, Word_needs_concept))).

/*Find the first char of the word*/
    fif(and(find_utt_word_in_lexicon(Utt, Word_needs_concept),
	    and(has(Utt, spelling, Word_needs_concept, Sp_of_word),
		and(has(Utt, leftwall, Sp_of_word, Word_LW),
		    and(has(Utt, successor, Word_LW, First_char_of_word),
			has(Utt, token, First_char_concept, First_char_of_word))))),
	conclusion(first_char_is_num_or_lex(Utt, Word_needs_concept, Sp_of_word, First_char_of_word, First_char_concept))).

    /*Does the first character match the first letter of a lexeme?*/
    fif(and(first_char_is_num_or_lex(Utt, Word_needs_lexeme, Sp_of_word, First_letter_of_word, Alpha_concept),
	    and(isa(Lex, lexeme, Lex),
		and(has(Lex, spelling, Lex, Sp_of_lex),
		    and(has(Lex, leftwall, Sp_of_lex, Lex_LW),
			and(has(Lex, successor, Lex_LW, First_letter_of_lex),
			    has(Lex, token, Alpha_concept, First_letter_of_lex)))))),
	conclusion(match_rest_of_letters(Utt, Word_needs_lexeme, Sp_of_word, First_letter_of_word, Lex, Sp_of_lex, First_letter_of_lex))).
    /*If it is a letter of a lexeme, keep looking for letters in lexemes (and not numbers).*/

    /*Or, does the first character match a number concept?*/
    fif(and(first_char_is_num_or_lex(Utt, Word_needs_num, Sp_of_word, First_char_of_word, Num_concept),
	   isa(ConNum, digit, Num_concept)),
	conclusion(match_rest_of_numbers_in_word(Utt, Word_needs_num, Sp_of_word, First_char_of_word))).
    /*If it is a number, than keep looking for numbers (and not letters).*/

        /*If looking for letters, loop through the rest of the letters in word*/
        /*Find the next letter of word and match it to the next letter of lexeme*/
        fif(and(match_rest_of_letters(Utt, Word_needs_lexeme, Sp_of_word, Current_letter_of_word, Lex, Sp_of_lex, Current_letter_of_lex),
	        and(has(Utt, successor, Current_letter_of_word, Next_letter_of_word),
		    and(has(Lex, successor, Current_letter_of_lex, Next_letter_of_lex),
			and(has(Utt, token, AlphaChar, Next_letter_of_word),
			    has(Lex, token, AlphaChar, Next_letter_of_lex))))),
	    conclusion(match_rest_of_letters(Utt, Word_needs_lexeme, Sp_of_word, Next_letter_of_word, Lex, Sp_of_lex, Next_letter_of_lex))).

        /*Find the next number of word*/
        fif(and(match_rest_of_numbers_in_word(Utt, Word_needs_num, Sp_of_word, Current_char_of_word),
	    and(has(Utt, successor, Current_char_of_word, Next_char_of_word),
		and(has(Utt, token, Number, Next_char_of_word),
		    isa(ConNum, digit, Number)))),
            conclusion(match_rest_of_numbers_in_word(Utt, Word_needs_num, Sp_of_word, Next_char_of_word))).

        /*Stop condition for letters: if there are no more letters of the word and the lexeme, end lexical lookup of this word*/
        fif(and(match_rest_of_letters(Utt, Word_needs_lexeme, Sp_of_word, Current_letter_of_word, Lex, Sp_of_lex, Current_letter_of_lex),
		and(eval_bound(\+ pos_int_u(has(Utt, successor, Current_letter_of_word, Next_letter_of_word)), [Utt, Current_letter_of_word]),
		    eval_bound(\+ pos_int_u(has(Lex, successor, Current_letter_of_lex, Next_letter_of_lex)), [Utt, Current_letter_of_word]))),
	    conclusion(end_of_lexical_lookup_for_word(Utt, Word_needs_lexeme, Lex))).

        /*Assert that the word is a token of the lexeme that matches all letters exactly*/
        fif(end_of_lexical_lookup_for_word(Utt, Word_needs_lexeme, Lex),
	    conclusion(has(Utt, token, Lex, Word_needs_lexeme))).

        /*Stop condition for numbers: if there are no more characters in the word, end the number recognizer*/
        fif(and(match_rest_of_numbers_in_word(Utt, Word_needs_num, Sp_of_word, Current_char_of_word),
                eval_bound(\+ pos_int_u(has(Utt, successor, Current_char_of_word, Next_char_of_word)), [Utt, Current_char_of_word])),
            conclusion(add_number(Utt, Word_needs_num))).

    /*End of loop within word*/

/*End of lexical lookup*/


/* --------------- Add Number to Lexicon ------------------*/


fif(add_number(Utt, Word),
conclusion(add_number_to_english(Utt, Word))).

fif(add_number(Utt, Word),
conclusion(add_number_to_domain(Utt, Word))).

fif(and(add_number_to_english(Utt, Word),
    and(eval_bound(form_to_name(add_number_to_english(Utt, Word), New_Val), [Utt, Word]),
        eval_bound(cappend_num_to_string('c2lex', New_Val, New_ID), [New_Val]))),
conclusion(do_add_lexeme(New_ID, c2, Word, c2cat3, mean_num, constant, nil))).

fif(and(add_number_to_english(Utt, Word),
    do_add_lexeme(Lex_ID, c2, Word, c2cat3, mean_num, constant, nil)),
conclusion(has(Utt, token, Lex_ID, Word))).

fif(and(add_number_to_domain(Utt, Word),
    and(eval_bound(form_to_name(add_number_to_domain(Utt, Word), New_Val), [Utt, Word]),
        eval_bound(cappend_num_to_string('c4lex', New_Val, New_ID), [New_Val]))),
conclusion(do_add_lexeme(New_ID, c4, Word, c4cat3, mean_num, constant, nil))).

/* --------------------End Number Stuff -------------------*/


/*Again, we assume that if one of the words have gone through the lexical lookup, then all of them will go through - hence we assert end of action*/
fif(and(started(Action, act4, TransID),
       and(end_of_lexical_lookup_for_word(Utt, Word_needs_lexeme, Lex),
          has(Utt, token, Lex, Word_needs_lexeme))),
conclusion(end(Action, TransID))).


/**************
Action 5 : Part of speech assigner <--- CATEGORIES NOW


Part of Speech assigner: Look-up part of speech of each word
  in utterance by using token predicate.

************/

fif(and(begin(Action, TransID),
	has(token, act5, Action)),
conclusion(started(Action, act5, TransID))).

fif(and(started(Action, act5, TransID),
       and(has(Utt, translation, Utt, TransID),
	and(isa(Utt, current_utterance),
	    and(has(Utt, word, Utt, Word),
		and(has(Utt, token, Lexeme, Word),
		    has(Lexeme, category, Lexeme, Part_of_speech)))))),
    conclusion(has(Utt, category, Word, Part_of_speech))).

/*Check to see that all words in utterance have been given their category,
  then start the syntactic parsing.  TO-DO: Is this only needed for tracking
  the parsing process?  If so, can delete.*/
/*Start by checking the first word.*/
fif(and(isa(Utt, current_utterance),
        and(has(Utt, leftwall, Utt, LW),
            and(has(Utt, successor, LW, First_word),
                has(Utt, category, First_word, _)))),
    conclusion(check_next_word_for_PoS(Utt, First_word))).

/*Recursively check the rest of the words.*/
fif(and(check_next_word_for_PoS(Utt, Prev_word),
        and(has(Utt, successor, Prev_word, Next_word),
            has(Utt, category, Next_word, _))),
    conclusion(check_next_word_for_PoS(Utt, Next_word))).

/*Stop Condition: if there is no successor to the current
  word, then start parser.*/
fif(and(started(Action, act5, TransID),
	and(check_next_word_for_PoS(Utt, Prev_word),
	    eval_bound(\+ pos_int_u(has(Utt, successor, Prev_word, Next_word)),[Utt, Prev_word]))),
    conclusion(end(Action, TransID))).


fif(start_parsing_process1(Utt),
    conclusion(notify_user(Utt, parsing_utt))).


/*******
 Action 6 : Make word list
*******/

fif(and(begin(Action, TransID),
	has(token, act6, Action)),
conclusion(started(Action, act6, TransID))).

/*Make word list.*/
/*Get first word of utterance.*/
fif(and(started(Action, act6, TransID),
	and(has(Utt, translation, Utt, TransID),
                      and(has(Utt, leftwall, Utt, LW),
                  has(Utt, successor, LW, First_word)))),
    conclusion(make_word_list2(Utt, First_word, [First_word]))).


/*Recursively get the rest of the words in the utterance.*/
fif(and(make_word_list2(Utt, Prev_word, Word_list),
        and(has(Utt, successor, Prev_word, Next_word),
            eval_bound(append(Word_list, [Next_word], New_word_list),[Next_word, Word_list]))),
    conclusion(make_word_list2(Utt, Next_word, New_word_list))).

/*Stop Condition: if there is no successor to the current
  word, then end making word list.*/
fif(and(make_word_list2(Utt, Prev_word, Word_list),
        eval_bound(\+ pos_int_u(has(Utt, successor, Prev_word, Next_word)),[Utt, Prev_word])),
    conclusion(done_making_word_list(Utt, Word_list))).

fif(and(started(Action, act6, TransID),
	and(has(Utt, translation, Utt, TransID),
	    done_making_word_list(Utt, _))),
conclusion(end(Action, TransID))).

/******


 Action 7 : Create syntactic structure


******/
/* 1*/

fif(and(begin(Action, TransID),
	has(token, act7, Action)),
conclusion(started(Action, act7, TransID))).

fif(and(started(Action, act7, TransID),
	and(done_making_word_list(Utt, _),
	    and(isa(Utt, translation, Trans_ID),
                and(has(Utt, language, Trans_ID, c2),
		    eval_bound(cappend_string('struct', Trans_ID, Struct_ID), [Trans_ID]))))),
    conclusion(has(Utt, syntactic_structure, Trans_ID, Struct_ID))).

fif(and(started(Action, act7, TransID),
	and(done_making_word_list(Utt, _),
	    and(isa(Utt, translation, Trans_ID),
		has(Utt, syntactic_structure, Trans_ID, Struct_ID)))),
    conclusion(isa(Utt, structure, Struct_ID))).

fif(and(started(Action, act7, Trans_ID),
	has(Utt, syntactic_structure, Trans_ID, Struct_ID)),
conclusion(end(Action, Struct_ID))).

/*Syntactic Parser: This is a top-down, breadth-first parser based on an Earley algorithm.
  (Without an explicit chart, which isn't needed in this non-algorithmic version.)
  See Jurafsky and Martin, chap. 13.

  The parser consists of:

        - Context free grammar rules
        - Start sequence
        - Predictor
        - Scanner
        - Completer
        - Structure builder

  The parser creates a list of states generated by context free
  grammar rules, such as S --> NP VP. This rule can be read as
  'S goes to NP and VP' or 'S is made up of NP and VP'. I refer to
  the left hand side of the arrow as the LHS, and the right hand 
  side as RHS. The parser 'reads' the RHS from left to right, and
  checks to see if the next constituent of the RHS can be expanded
  by another rule, or if it is a part-of-speech tag (as in VP --> verb),
  checks to see if the next word in the utterance matchs that
  part-of-speech.  We can represent the position of the parser
  in a CFG rule by using the "dotted-rule" notation, where a '.' 
  marks the current position of the parser.  For instance:

      S --> .NP VP
      S -->  NP.VP
      S -->  NP VP.

  This parser's version of the dotted rule, or how it keeps track 
  of what position it is at the RHS of a rule, is two lists: the 
  processed part of the RHS and the unprocessed part of the RHS. 
  As it moves from left to right, it pops the top off the 
  unprocessed list and appends it to the processed list.

      S --> .NP VP         [],       [NP, VP]
      S -->  NP.VP         [NP],     [VP]
      S -->  NP VP.        [NP, VP]  []

This information is included in each state generated by the parser.

Also included in each state are:

Utterance #             
State #                 
LHS of rule             
list of processed RHS of rule   
list of unprocessed RHS of rule 
list of processed words         
list of unprocessed words       
list of states in the history of derivation   

The Start Sequence generates the seed state.

The Predictor uses the CFG rules to generate new states from
old states.  It looks at the list of unprocessed RHS (in each
state) and if the top item can be expanded by another rule, 
it creates a new state.

The Scanner looks at the unprocessed RHS of states and if
the top item is a part-of-speech, it checks the current
word to see if it matches. If it does, it adds a new state.

The Completer looks at old states that have no items in
their unprocessed RHS list. It then tries to match that state
with a previous state. If it finds one, it creates a new state.

After a legal parse is found, the Structure Builder follows
the derivation by reading the history list, starting with the 
state associated with the top S-node, down to all of the 
terminals, building the structure as it goes.
*/


/*******

Action 8 : Syntactic parser


*******/


/*Start Sequence: create state, 
  find all the words in the utterance, and then create 
  the first state. */

/*Make new state ID.*/


fif(and(begin(Action, Struct_ID),
	has(token, act8, Action)),
conclusion(started(Action, act8, Struct_ID))).

fif(and(started(Action, act8, Struct_ID),
	and(has(Utt, syntactic_structure, Trans_ID, Struct_ID),
	    and(has(Utt, translation, Utt, Trans_ID),
		and(eval_bound(unique_id([ID]),[]),
		    eval_bound(cappend_string('st', ID, State), [ID]))))),
    conclusion(start_parsing_process2(Utt, State))).

fif(and(done_making_word_list(Utt, Word_list),
        start_parsing_process2(Utt, State)),
    conclusion(start_parsing_process4(Utt, State, Word_list))).




/*After making word list, make start state, which consists of the 
  dummy start rule:
                      start_s --> *s

  This means that the LHS will be 'start_s', and the RHS will be
  's'.  The 'dot' is on the left of the RHS, so the processed list
  will be empty, the unprocessed list will be [s].  Hence the first 
  state will be contain:

Utterance               --    Utt ID
State                   --    State ID
LHS of rule             --    start_s
processed list of RHS   --    [] (empty because nothing has been processed)
unprocessed list of RHS --    [s]
processed words         --    [] (empty because nothing has been processed)
unprocessed words       --    [Word list]
history of derivation   --    [] (empty because there has been no derivation so far)
*/

fif(start_parsing_process4(Utt, State, Word_list),
    conclusion(parse_state(Utt, State, start_s, [], [s], [], Word_list, []))).


/*Predictor: 
  The Predictor looks at all current states for any that have
  a non-terminal to the right of the dot, except for non-terminals
  that are parts-of-speech categories.  That is, it looks for states
  in which the first element of the list of unprocessed RHS items
  is S, VP, PP, NP, etc.

  When it finds one, it checks to see if there is a CFG rule that
  expands the first element of the unprocessed RHS items. For instance, 
  if the first item is S, then S --> VP would apply; if it were VP, 
  then VP --> V would apply, etc.  If a rule can be successfully applied,
  it creates a new state that:

     -- has a new state ID
     -- has a new LHS (according to the rule used to expand the old state)
     -- places the dot at the far left of the RHS of the rule,
            -- uses an empty list for the processed RHS variable
            -- lists all the items on RHS of the rule in the unprocessed 
               RHS variable
     -- starts at the beginning of the old state's unprocessed words
            -- processed words list is empty
            -- unprocessed words list is same as old state's unprocessed words
     -- leaves the history list empty, since the predictor begins the 
        processing of rules; the history list includes the states that
        represent the substrees that are the daughters of the current state

It creates the new state ID by concatenating the old state ID with the
rule ID used to generate the new state.

It also checks to make sure a state describing the same subtree does
not already exist (using \+ pos int).

*/

fif(and(parse_state(Utt, State, _, _, [First_RHS | Rest_RHS], _, Unprocessed_words, _),
        and(isa(c2, domain_syntax_rule, Rule),
            and(has(c2, left_hand_side, Rule, First_RHS),
                and(has(c2, right_hand_side, Rule, New_RHS),
                    and(eval_bound(\+ pos_int_u(parse_state(Utt, _, First_RHS, [], New_RHS, [], Unprocessed_words, [])),[Utt, First_RHS, New_RHS, Unprocessed_words]),

                        eval_bound(cappend_string(State, Rule, New_state),[State, Rule])))))),
    conclusion(predictor_state1(Utt, New_state, First_RHS, New_RHS, Unprocessed_words))).

fif(and(predictor_state1(Utt, New_state, First_RHS, New_RHS, Unprocessed_words),
	eval_bound(gather_all(predictor_state1(Utt, _, First_RHS, New_RHS, Unprocessed_words), Poss_Dupes),[Utt, First_RHS, New_RHS, Unprocessed_words])),
conclusion(predictor_state2_a(Poss_Dupes))).

/*Get list of formula names*/
/*Start condition: find the first formula number for first element of duplicates list, send it to loop.*/
fif(and(predictor_state2_a([First | Rest]),
        eval_bound(form_to_name(First, Formula_number),[First])),
conclusion(predictor_state2_b(Rest, [Formula_number]))).

/*Loop: go through each formula, find its number, and append it to the list.*/
fif(and(predictor_state2_b([First | Rest], Formula_nums),
        and(eval_bound(form_to_name(First, First_number),[First]),
	    eval_bound(append(Formula_nums, [First_number], New_formula_nums),[Formula_nums, First_number]))),
conclusion(predictor_state2_b(Rest, [New_formula_nums]))).

/*Stop condition: when list is empty, go on with check.*/
fif(predictor_state2_b([], Formula_nums),
conclusion(predictor_state3(Formula_nums))).

/*Now send list to prolog to discard duplicates (if any), return a single parse state number,
  and us it to create the new parse state.*/
fif(and(predictor_state3(Formula_nums),
	and(eval_bound(discard_duplicates(Formula_nums, Parse_state),[Formula_nums]),
	    predictor_state1(Utt, Parse_state, LHS, RHS, Unprocessed_words))),
conclusion(parse_state(Utt, Parse_state, LHS, [], RHS, [], Unprocessed_words, []))).

/*Scanner:
  The scanner applies to any state that has a part-of-speech category
  as the first item to the right of the dot on the RHS of the rule (that 
  is (v, n, or p) as the first member of its unprocessed 
  RHS list) and has a first member of its unprocessed word list with the same 
  part-of-speech category. So, if the RHS of a rule calls for a Verb, and
  the first word in the unprocessed word list is a verb, then the state
  matches.

  When the scanner finds such a state, it creates a new state that:

     -- has a new state ID created with the 'form_to_name'
        function in alma.
     -- has the part-of-speech tag as its LHS
     -- has the word ID as the processed RHS
     -- has an empty unprocessed RHS
     -- pops the first item off the original state's unprocessed
        word list and uses it as the first (and only) item of the
        new state's processed word list
     -- uses the remaining items (if any) from the original state's 
        unprocessed word list for the new state's unprocessed word list
     -- the history list is empty, since the scanner only creates
        subtrees at the bottom of the tree

  It creates the new state ID by concatenating the old state ID
  and the ID of the first unprocessed word.

  It also makes sure that the new state subtree has not already
  been created.
*/

fif(and(parse_state(Utt, _, _, _, [First_RHS | Rest_RHS], _, [First_unprocessed_word | Rest_unprocessed_words], _),
        and(has(Utt, category, First_unprocessed_word, PoS),
            and(isa(c2, category, PoS),
            and(has(c2, label, PoS, First_RHS),
                eval_bound(\+ pos_int_u(parse_state(Utt, _, First_RHS, [First_unprocessed_word], [], [First_unprocessed_word], _, [])),[Utt, First_RHS, First_unprocessed_word]))))),
    conclusion(scanner_finish(Utt, nil, First_RHS, [First_unprocessed_word], [], [First_unprocessed_word], Rest_unprocessed_words, []))).

fif(and(scanner_finish(Utt, nil, LHS, RHS, [], Word1, Word2, []),
        and(eval_bound(form_to_name(scanner_finish(Utt, nil, LHS, RHS, [], Word1, Word2, []), New_ID),[Utt, LHS, RHS, Word1, Word2]),
            eval_bound(cappend_num_to_string('st', New_ID, New_state),[New_ID]))),
    conclusion(parse_state(Utt, New_state, LHS, RHS, [], Word1, Word2, []))).

/*Completer:
  The Completer is triggered by:

    -- a state where the dot is on the far right of the RHS 
       of the rule. This occurs when the unprocessed RHS
       list is empty.  Call this state S1.

    -- and another state, S2, in which: 
              -- the first member of the unprocessed RHS 
                 list is the same as the LHS of S1,

              -- the processed word list of S1 is on top of the
                 unprocessed word list of S2. This list may
                 include more than one item, so it requires
                 a recursive matching of the lists.

When the Completer finds two states with this relationship,
it essentially moves the dot forward one item on the previous
state (S2). In other words, when one state signifies that a rule
has been completed, all states needing that rule have their RHS
progressed by one item. This is done by moving the item from 
the unprocessed RHS list to the processed RHS list.  This, 
in turn, can trigger the Predictor or the Scanner to apply 
to the new state.

The Completer also keeps a history of the derivation by adding
the state numbers of S1 and S2 to the history list of the new
state.

The Completer creates a new state that:

     -- has a new state ID created from the 'form_to_name' function
        in alma which returns the formula number for a formula
        in the KB.
     -- has the same LHS as S2
     -- has S2's processed RHS list appended with the top member
        of S2's unprocessed RHS list
     -- has the top member of S2's unprocessed RHS list removed
     -- has S2's processed word list, appended with
        the S1's processed word list
     -- has S2's unprocessed word list but with
        the S1's processed word list removed from the top
    -- adds the state number of S1 to the history list; in this 
       way, the history list of a completed rule will contain
       the state numbers of the daughters of the current state
*/

/*First part of loop; check that the unprocessed RHS list of S1
  is empty, and that the LHS of S1 is the first member of the
  unprocessed RHS of S2.

  But also, check that the first processed word of S1
  is the same as the first unprocessed word of S2.
  If it is, move on into the loop to check the rest of the
  processed words of S1.*/

fif(and(parse_state(Utt, State1, LHS1, _, [], [First_processed_word | Rest_processed_words], _, _),
        parse_state(Utt, State2, LHS2, Processed_RHS, [LHS1 | Rest_unprocessed_RHS], _, [First_processed_word | Rest_unprocessed_words], _)),
    conclusion(completer_loop(Utt, State1, State2, Rest_processed_words, Rest_unprocessed_words))).


/*Completer loop*/
fif(completer_loop(Utt, State1, State2, [First_S1_processed_word | Rest_S1_processed_words], [First_S1_processed_word | Rest_S2_unprocessed_words]),
    conclusion(completer_loop(Utt, State1, State2, Rest_S1_processed_words, Rest_S2_unprocessed_words))).

/*Stop condition: if there are no more words in processed word list, 
  stop loop.*/
fif(completer_loop(Utt, State1, State2, [], Rest_S2_unprocessed_words),
    conclusion(completer_finish(Utt, State1, State2, Rest_S2_unprocessed_words))).

/*Finish the Completer process on State1 and State2, create new state.*/
fif(and(completer_finish(Utt, State1, State2, New_unprocessed_words),
        and(parse_state(Utt, State1, _, _, _, S1_processed_words, _, _),
            and(parse_state(Utt, State2, LHS_2, S2_processed_RHS, [First_S2_unprocessed_RHS | Rest_S2_unprocessed_RHS], S2_processed_words, _, History),
                and(eval_bound(append(S2_processed_RHS, [First_S2_unprocessed_RHS], New_processed_RHS),[S2_processed_RHS, First_S2_unprocessed_RHS]),
                    and(eval_bound(append(S2_processed_words, S1_processed_words, New_processed_words),[S2_processed_words, S1_processed_words]),
                        and(eval_bound(append(History, [State1], New_history),[History, State1]),
                            and(eval_bound(form_to_name(completer_finish(Utt, State1, State2, New_unprocessed_words), New_ID),[Utt, State1, State2, New_unprocessed_words]),
                                eval_bound(cappend_num_to_string('st', New_ID, New_state), [New_ID])))))))),
    conclusion(parse_state(Utt, New_state, LHS_2, New_processed_RHS, Rest_S2_unprocessed_RHS, New_processed_words, New_unprocessed_words, New_history))).

/*The parser is complete when it makes a state with the dot
  rule:
             start_s --> s.

  (in the list notation:  start_s, [s], []) and, all of 
  the words have been processed.
*/

fif(and(started(Action, act8, Struct_ID),
	and(has(Utt, syntactic_structure, Trans_ID, Struct_ID),
	    and(has(Utt, translation, Utt, Trans_ID),
                and(done_making_word_list(Utt, Wordlist),
	            parse_state(Utt, State, start_s, [s], [], Wordlist, [], _))))),
    conclusion(end(Action, Struct_ID))).


/***************

Action 9 : Tree structure builder


****************/


/*When the first part of the parsing is complete, build a 
  phrase marker by looking through the histories of the states
  that lead to the final start_s -> s. state. This is a 
  recursive process.  The first step is to build the S-phrase.
*/
/*First, find the stateID for 'start_s --> s.'  Then make an S phrase.
  When the S phrase has been built, use the history list from stateID
  to find the next state(s), which will give us S's daughter(s). 
  Use these states to enter the recursive phrase_marker builder that 
  goes DOWN the tree.*/

fif(and(begin(Action, Struct_ID),
	has(token, act9, Action)),
conclusion(started(Action, act9, Struct_ID))).

fif(and(started(Action, act9, Struct_ID),
	and(has(Utt, syntactic_structure, Trans_ID, Struct_ID),
	    and(has(Utt, translation, Utt, Trans_ID),
                parse_state(Utt, State, start_s, [s], [], _, [], _)))),
    conclusion(start_building_structure(Utt, State))).

/*Make S node with its properties.*/
fif(and(start_building_structure(Utt, State),
    parse_state(Utt, State, start_s, [s], [], _, [], _)),
    conclusion(create_S_node(Utt, State))).

fif(create_S_node(Utt, State), 
conclusion(isa(Utt, phrase, State))).

fif(create_S_node(Utt, State), 
conclusion(isa(Utt, start_s, State))).

fif(create_S_node(Utt, State), 
conclusion(isa(Utt, tree_state, State))).

/* 1*/

fif(and(parse_state(Utt, State, start_s, [s], [], _, [], _),
        has(Utt, syntactic_structure, _, Struct_ID)),
    conclusion(has(Utt, top_phrase, Struct_ID, State))).

/* 2*/
fif(has(Utt, top_phrase, Struct_ID, State),
    conclusion(isa(Utt, top_phrase, State))).

fif(and(create_S_node(Utt, State),
        and(has(Utt, syntactic_structure, _, Struct_ID),
            has(Utt, top_phrase, Struct_ID, Top_ID))),
    conclusion(has(Utt, daughter, Top_ID, State))).

/*Build_structure/*
/*If History is non empty, create left wall.*/
fif(and(start_building_structure(Utt, State),
        and(parse_state(Utt, State, _, _, _, _, _, History),
            eval_bound(\+ pos_int(parse_state(Utt, State, _, _, _, _, _, [])), [Utt, State]))),
    conclusion(create_left_wall(Utt, State, History))).

/*If History is empty, make terminal*/
fif(and(start_building_structure(Utt, State),
        parse_state(Utt, State, LHS, Processed_RHS, _, Processed_Words, _, [])),
    conclusion(make_terminal(Utt, State, LHS, Processed_RHS, Processed_Words, []))).

/*Create left wall.*/
fif(and(create_left_wall(Utt, Mother_State, [History_First | History_Rest]),
        and(eval_bound(cappend_string(lw, Mother_State, Leftwall),[Mother_State]),
            parse_state(Utt, History_First, LHS, _, _, _, _, _))),
    conclusion(create_first_node(Utt, History_First, Leftwall, Mother_State))).

/*Create first daughter node (must have left wall ID sent to it).*/
fif(create_first_node(Utt, History_First, Leftwall, Mother_State),
conclusion(isa(Utt, leftwall, Leftwall))).

fif(create_first_node(Utt, History_First, Leftwall, Mother_State),
conclusion(has(Utt, leftwall, Mother_State, Leftwall))).

fif(create_first_node(Utt, History_First, Leftwall, Mother_State),
conclusion(has(Utt, successor, Leftwall, History_First))).

fif(create_first_node(Utt, History_First, Leftwall, Mother_State),
conclusion(isa(Utt, tree_state, History_First))).	

fif(and(create_left_wall(Utt, Mother_State, History),
        and(has(Utt, leftwall, Mother_State, LW_State),
            parse_state(Utt, Mother_State, _, _, _, _, _, _))),
    conclusion(create_successor(Utt, Mother_State, LW_State, History))).

fif(and(create_successor(Utt, Mother_State, Predecessor, [History_First | History_Rest]),
        parse_state(Utt, History_First, LHS, _, _, _, _, _)),
    conclusion(create_node(Utt, History_First, Predecessor, Mother_State, LHS))).
	
fif(create_node(Utt, History_First, Predecessor, Mother_State, LHS),
conclusion(isa(Utt, phrase, History_First))).

fif(create_node(Utt, History_First, Predecessor, Mother_State, Label),
conclusion(isa(Utt, Label, History_First))).

fif(create_node(Utt, History_First, Predecessor, Mother_State, LHS),
conclusion(has(Utt, daughter, Mother_State, History_First))).

fif(create_node(Utt, History_First, Predecessor, Mother_State, LHS),
conclusion(has(Utt, successor, Predecessor, History_First))).

fif(create_node(Utt, History_First, Predecessor, Mother_State, LHS),
conclusion(isa(Utt, tree_state, History_First))).

/*If a node has a sister (i.e., there is another state in the history
  list), then go through the successor loop again.*/
fif(and(create_successor(Utt, Mother_State, Predecessor, [History_First | History_Rest]),
        eval_bound(is_not_empty(History_Rest), [History_Rest])),
    conclusion(create_successor(Utt, Mother_State, History_First, History_Rest))).

/*Whenever a node has been created (via 'create successor'), make
  that node the new mother and call 'start_building_structure' again.*/
fif(create_successor(Utt, _, Predecessor, [History_First | History_Rest]),
    conclusion(start_building_structure(Utt, History_First))).

/*Make terminal*/
fif(and(make_terminal(Utt, State, LHS, [Processed_RHS], Processed_Words, _),
        and(eval_bound(cappend_string(lw, State, Leftwall),[State]),
            eval_bound(cappend_string(word, State, Terminal_State),[State]))),
    conclusion(create_terminal_node(Utt, Terminal_State, Leftwall, State, Processed_RHS))).
	
fif(create_terminal_node(Utt, Terminal_State, Leftwall, State, Processed_RHS),
conclusion(isa(Utt, leftwall, Leftwall))).

fif(create_terminal_node(Utt, Terminal_State, Leftwall, State, Processed_RHS),
conclusion(has(Utt, leftwall, State, Leftwall))).

fif(create_terminal_node(Utt, Terminal_State, Leftwall, State, Processed_RHS),
conclusion(has(Utt, successor, Leftwall, Terminal_State))).

fif(create_terminal_node(Utt, Terminal_State, Leftwall, State, Processed_RHS),
conclusion(isa(Utt, terminal_phrase, Terminal_State))).

fif(create_terminal_node(Utt, Terminal_State, Leftwall, State, Processed_RHS),
conclusion(isa(Utt, Processed_RHS, Terminal_State))).

fif(create_terminal_node(Utt, Terminal_State, Leftwall, State, Processed_RHS),
conclusion(has(Utt, daughter, State, Terminal_State))).


/*Check that tree is complete by checking that all terminals
  have a place in the tree.*/
fif(and(parse_state(Utt, State, start_s, [s], [], _, [], _),
        and(done_making_word_list(Utt, [FirstWord | RestWords]),
	    and(isa(Utt, FirstWord, State2),
                isa(Utt, terminal_phrase, State2)))),
    conclusion(check_rest_of_words_for_terminal_states(Utt, RestWords))).

fif(and(check_rest_of_words_for_terminal_states(Utt, [NextWord | RestWords]),
        and(isa(Utt, NextWord, State),
            isa(Utt, terminal_phrase, State))),
conclusion(check_rest_of_words_for_terminal_states(Utt, RestWords))).

fif(check_rest_of_words_for_terminal_states(Utt, []),
    conclusion(second_parsing_complete(Utt))).

fif(and(started(Action, act9, Struct_ID),
	and(has(Utt, syntactic_structure, Trans_ID, Struct_ID),
	    and(has(Utt, translation, Utt, Trans_ID),
		second_parsing_complete(Utt)))),
conclusion(end(Action, Struct_ID))).



fif(second_parsing_complete(Utt),
    conclusion(notify_user(Utt, parsing_utt_done))).

/**********

Action 10 : Theta-role Assignment

**********/


/*Theta-role assignment finds lexical items that assign semantic roles such as
  patient and location and then assigns those roles to the assigner's syntactic
  sister.*/

fif(and(begin(Action, Struct_ID),
       has(token, act10, Action)),
conclusion(started(Action, act10, Struct_ID))).


fif(and(started(Action, act10, Struct_ID),
   	and(has(Utt, syntactic_structure, Trans_ID, Struct_ID),
	    and(has(Utt, translation, Utt, Trans_ID),
                notify_user(Utt, parsing_utt_done)))),
conclusion(theta_assignment_begin(Utt))).

fif(theta_assignment_begin(Utt),
conclusion(notify_user(Utt, theta_begin))).

/*Start condition: Get first word in utterance, and then move onto
                   the next word. Find its lexemeID, and
                   check to see if it assigns a theta role.  If it does,
                   then start the assignment loop.*/

fif(and(theta_assignment_begin(Utt),
        done_making_word_list(Utt, WordList)),
conclusion(theta_assignment_loop(Utt, WordList))).

/*Loop:*/

fif(and(theta_assignment_loop(Utt, [FirstWord | RestWords]),
        and(has(Utt, token, LexID, FirstWord),
            has(LexID, theta_role_to_assign, LexID, ThetaID))),
conclusion(assign_theta_role_loop(Utt, FirstWord, LexID, ThetaID))).

fif(theta_assignment_loop(Utt, [FirstWord | RestWords]),
conclusion(theta_assignment_loop(Utt, RestWords))).

/*Stop Condition: If there are no more words in list, then report that
                  theta_assignment is done and move on to linking.*/
fif(theta_assignment_loop(Utt, []),
conclusion(start_theta_assignment_check(Utt))).

/*Assign_theta_role_loop:*/
    /*Find Phrase ID: */
fif(and(assign_theta_role_loop(Utt, FirstWord, LexID, ThetaID), 
       and(has(Utt, token, LexID, FirstWord),
          and(isa(Utt, FirstWord, PhraseID),
             isa(Utt, terminal_phrase, PhraseID)))),
conclusion(place_theta_loop(Utt, PhraseID, ThetaID))).

    /*Loop: */

fif(and(place_theta_loop(Utt, PhraseID, ThetaID),
	and(has(Utt, daughter, Mother, PhraseID),
            and(has(Utt, successor, Leftwall, PhraseID),
                and(has(Utt, leftwall, Mother, Leftwall),
                    eval_bound(\+ pos_int_u(has(Utt, successor, PhraseID, OtherPhraseID)),[Utt, PhraseID]))))),
	conclusion(place_theta_loop(Utt, Mother, ThetaID))).

   /*Stop Conditions: (1) phrase has sister that comes after it,
                      (2) phrase has sister that comes before it

                      Then stop placement of theta-role.*/

fif(and(place_theta_loop(Utt, PhraseID, ThetaID),
	and(has(Utt, daughter, Mother, PhraseID),
	    and(has(Utt, daughter, Mother, OtherPhraseID),
		has(Utt, successor, PhraseID, OtherPhraseID)))),
	conclusion(has(Utt, theta_role, OtherPhraseID, ThetaID))).

fif(and(place_theta_loop(Utt, PhraseID, ThetaID),
	and(has(Utt, daughter, Mother, PhraseID),
	    and(has(Utt, daughter, Mother, OtherPhraseID),
		has(Utt, successor, OtherPhraseID, PhraseID)))),
	conclusion(has(Utt, theta_role, OtherPhraseID, ThetaID))).


/*Done with theta-marking when all the words in the utterance
  that need to assign theta roles have assigned them.  Get wordlist
  and begin at first word.

/*Start Condition: Grabs beginning of wordlist*/
fif(and(done_making_word_list(Utt, WordList),
        start_theta_assignment_check(Utt)),	
conclusion(theta_loop_end_check(Utt, WordList))).

/*Loop A: If word has a theta-role to assign, check that it has been
  assigned.  If so, then go to next word.*/
fif(and(theta_loop_end_check(Utt, [FirstWord | RestWords]),
	and(has(Utt, token, LexID, FirstWord),
	    and(has(LexID, theta_role_to_assign, LexID, ThetaID),
		and(has(Utt, theta_role, Phrase, ThetaID),
		    isa(Utt, phrase, Word))))),
conclusion(theta_loop_end_check(Utt, RestWords))).

/*Loop B: If word does not have a theta-role to assign, then go to next word.*/
fif(and(theta_loop_end_check(Utt, [FirstWord | RestWords]),
	and(has(Utt, token, LexID, FirstWord),
	   eval_bound(\+ pos_int_u(has(LexID, theta_role_to_assign, LexID, ThetaID)), [LexID]))),
conclusion(theta_loop_end_check(Utt, RestWords))).


/*End Condition: When word list is empty, theta-role assignment is done.*/
fif(theta_loop_end_check(Utt, []),
    conclusion(theta_assignment_done(Utt))).

fif(theta_assignment_done(Utt),
conclusion(notify_user(Utt, theta_done))).

fif(and(started(Action, act10, Struct_ID),
	and(has(Utt, syntactic_structure, Trans_ID, Struct_ID),
	    and(has(Utt, translation, Utt, Trans_ID),
		theta_assignment_done(Utt)))),
conclusion(end(Action, Struct_ID))).





fif(and(theta_assignment_done(Utt),
	notify_user(Utt, theta_done)),
conclusion(notify_user(Utt, begin_LF))).

/*****************


Action 11 : Linking rules



Notes: Starts in 3 different places.
*****************/

/*-------------------------------make linking rules-----------------------------*/
/*Linking rules find the terminals in the syntactic tree (i.e., the words) and
  create LF-phrases/semantic values for them.

    1. Find a word.
    2. Find its meaning.
    3. Identify whether the meaning is a predicate, constant, or relation.
*/

fif(and(begin(Action, Struct_ID),
       has(token, act11, Action)),
conclusion(started(Action, act11, Struct_ID))).



/*Find predicates*/
fif(and(started(Action, act11, Struct_ID),
        and(has(Utt, syntactic_structure, Trans_ID, Struct_ID),
	    and(theta_assignment_done(Utt),
               and(isa(Utt, terminal_phrase, Terminal_State),
                  and(isa(Utt, WordID, Terminal_State),

and(parse_state(Utt, _, _, [WordID], _, _, _, _),


                     and(has(Utt, token, LexID, WordID),
                        and(has(LexID, content, LexID, MeaningID),
                           has(MeaningID, type, MeaningID, predicate))))))))),
    conclusion(create_predicate_chain(Utt, MeaningID, Terminal_State))).    

fif(and(create_predicate_chain(Utt, MeaningID, Terminal_State), 
        eval_bound(cappend_string('lf', Terminal_State, LF_ID),[Terminal_State])), 
conclusion(create_predicate_chain_b(Utt, MeaningID, Terminal_State, LF_ID))).

fif(and(create_predicate_chain_b(Utt, MeaningID, Terminal_State, LF_ID), 
        eval_bound(cappend_string('var', LF_ID, Temp_ID),[LF_ID])), 
conclusion(create_predicate_chain_c(Utt, MeaningID, Terminal_State, LF_ID, Temp_ID))).

fif(and(create_predicate_chain_c(Utt, MeaningID, Terminal_State, LF_ID, Temp_ID), 
        eval_bound(cappend_string(Temp_ID, Utt, VariableID),[Temp_ID, Utt])), 
conclusion(create_predicate_chain_d(Utt, MeaningID, Terminal_State, LF_ID, VariableID))).

fif(create_predicate_chain_d(Utt, MeaningID, Terminal_State, LF_ID, VariableID),
conclusion(isa(Utt, lf_phrase, LF_ID))).

fif(create_predicate_chain_d(Utt, MeaningID, Terminal_State, LF_ID, VariableID),
conclusion(isa(Utt, predicate, LF_ID))).

fif(create_predicate_chain_d(Utt, MeaningID, Terminal_State, LF_ID, VariableID),
conclusion(has(Utt, token, MeaningID, LF_ID))).

fif(create_predicate_chain_d(Utt, MeaningID, Terminal_State, LF_ID, VariableID),
conclusion(has(Utt, semantic_value, Terminal_State, LF_ID))).

fif(create_predicate_chain_d(Utt, MeaningID, Terminal_State, LF_ID, VariableID),
conclusion(isa(Utt, variable, VariableID))).

fif(create_predicate_chain_d(Utt, MeaningID, Terminal_State, LF_ID, VariableID),
conclusion(isa(Utt, LF_ID, VariableID))).

/*Find constants*/
fif(and(started(Action, act11, Struct_ID),
        and(has(Utt, syntactic_structure, Trans_ID, Struct_ID),
           and(theta_assignment_done(Utt),
       and(create_predicate_chain_d(Utt, _, _, _, _),
        and(isa(Utt, terminal_phrase, Terminal_State),
            and(isa(Utt, WordID, Terminal_State),
and(parse_state(Utt, _, _, [WordID], _, _, _, _),
                and(has(Utt, token, LexID, WordID),
                    and(has(LexID, content, LexID, MeaningID),
                        has(MeaningID, type, MeaningID, constant)))))))))),
    conclusion(create_constant_chain(Utt, MeaningID, Terminal_State))).  

fif(and(create_constant_chain(Utt, MeaningID, Terminal_State),
        eval_bound(cappend_string('lf', Terminal_State, NewID),[Terminal_State])),
conclusion(create_constant_chain_b(Utt, MeaningID, Terminal_State, NewID))).

fif(and(create_constant_chain_b(Utt, MeaningID, Terminal_State, ConstID),
        eval_bound(cappend_string('var1', ConstID, VarID),[ConstID])),
conclusion(create_constant_chain_c(Utt, MeaningID, Terminal_State, ConstID, VarID))).

fif(create_constant_chain_c(Utt, MeaningID, Terminal_State, ConstID, VarID),
conclusion(isa(Utt, lf_phrase, ConstID))).

fif(create_constant_chain_c(Utt, MeaningID, Terminal_State, ConstID, VarID),
conclusion(isa(Utt, constant, ConstID))).

fif(create_constant_chain_c(Utt, MeaningID, Terminal_State, ConstID, VarID),
conclusion(has(Utt, token, MeaningID, ConstID))).

fif(create_constant_chain_c(Utt, MeaningID, Terminal_State, ConstID, VarID),
conclusion(has(Utt, semantic_value, Terminal_State, ConstID))).

fif(create_constant_chain_c(Utt, MeaningID, Terminal_State, ConstID, VarID),
conclusion(isa(Utt, variable, VarID))).

fif(create_constant_chain_c(Utt, MeaningID, Terminal_State, ConstID, VarID),
conclusion(isa(Utt, ConstID, VarID))).

/*Find semantically vacuous items.  Link them to a nil semantic value.*/
fif(and(started(Action, act11, Struct_ID),
        and(has(Utt, syntactic_structure, Trans_ID, Struct_ID),
           and(theta_assignment_done(Utt),
              and(isa(Utt, terminal_phrase, Terminal_State),
                 and(isa(Utt, WordID, Terminal_State),
and(parse_state(Utt, _, _, [WordID], _, _, _, _),
                    and(has(Utt, token, LexID, WordID),
                        has(LexID, content, LexID, nil)))))))),
    conclusion(has(Utt, semantic_value, Terminal_State, nil))).  



fif(and(started(Action, act11, Struct_ID),
	and(has(Utt, syntactic_structure, Trans_ID, Struct_ID),
	    and(has(Utt, translation, Utt, Trans_ID),
		create_predicate_chain_d(Utt, MeaningID, Terminal_State, LF_ID, VariableID)))),
conclusion(end(Action, Struct_ID))).

/*******************


Action 12 : Semantic cominatorial rules


******************/



/*---------------semantic combinatorial rules-------------------------------------*/

fif(and(begin(Action, Struct_ID),
       has(token, act12, Action)),
conclusion(started(Action, act12, Struct_ID))).


/*Combinatorial rule for A -> B, where A has no theta-role. Pass the semantic value of B up to A.*/
fif(and(started(Action, act12, Struct_ID),
        and(has(Utt, syntactic_structure, Trans_ID, Struct_ID),
        and(has(Utt, daughter, Mother_State, Daughter_State),
	and(parse_state(Utt, Mother_State, _, _, _, _, _, _),
        and(has(Utt, semantic_value, Daughter_State, LFphraseID),
            and(has(Utt, leftwall, Mother_State, LW),
                has(Utt, successor, LW, Daughter_State))))))),
conclusion(add_semantic_value1(Utt, Mother_State, Daughter_State, LFphraseID))).

fif(and(add_semantic_value1(Utt, Mother_State, Daughter_State, LFphraseID),
    and(eval_bound(\+ pos_int_u(has(Utt, theta_role, Mother_State, _)), [Utt, Mother_State]),
        eval_bound(\+ pos_int_u(has(Utt, successor, Daughter_State, Daughter_State2)),[Utt, Daughter_State]))),
    conclusion(has(Utt, semantic_value, Mother_State, LFphraseID))).

/*Combinatorial rule for A -> B C, where B is vacuous and C is a
  constant or a predicate.*/

fif(and(started(Action, act12, Struct_ID),
        and(has(Utt, syntactic_structure, Trans_ID, Struct_ID),
        and(has(Utt, daughter, Mother_State, Daughter_State),
        and(has(Utt, daughter, Mother_State, Daughter_State1),
	and(parse_state(Utt, Mother_State, _, _, _, _, _, _),
        and(has(Utt, daughter, Mother_State, Daughter_State2),
            and(has(Utt, successor, Daughter_State1, Daughter_State2),
                and(has(Utt, semantic_value, Daughter_State1, LFphraseID1),
                    has(Utt, semantic_value, Daughter_State2, nil))))))))),
conclusion(has(Utt, semantic_value, Mother_State, LFphraseID1))).

fif(and(started(Action, act12, Struct_ID),
        and(has(Utt, syntactic_structure, Trans_ID, Struct_ID),
        and(has(Utt, daughter, Mother_State, Daughter_State),
        and(has(Utt, daughter, Mother_State, Daughter_State1),
	and(parse_state(Utt, Mother_State, _, _, _, _, _, _),
        and(has(Utt, daughter, Mother_State, Daughter_State2),
            and(has(Utt, successor, Daughter_State2, Daughter_State1),
                and(has(Utt, semantic_value, Daughter_State1, LFphraseID1),
                    has(Utt, semantic_value, Daughter_State2, nil))))))))),
conclusion(has(Utt, semantic_value, Mother_State, LFphraseID1))).


/*Combinatorial rule for A -> B C, where B and C are both predicates.
  Simply conjoin the semantic values of B and C to make the semantic 
  value of A.*/

fif(and(started(Action, act12, Struct_ID),
        and(has(Utt, syntactic_structure, Trans_ID, Struct_ID),
        and(has(Utt, daughter, Mother_State, Daughter_State1),
        and(has(Utt, daughter, Mother_State, Daughter_State2),
	and(parse_state(Utt, Mother_State, _, _, _, _, _, _),
            has(Utt, successor, Daughter_State1, Daughter_State2)))))),
conclusion(got_combo(Utt, Mother_State, Daughter_State1, Daughter_State2))).

fif(and(got_combo(Utt, Mother_State, Daughter_State1, Daughter_State2),
        has(Utt, semantic_value, Daughter_State1, LFphraseID1)),
conclusion(got_combo2a(Utt, Mother_State, LFphraseID1, Daughter_State2))).

fif(and(got_combo2a(Utt, Mother_State, LFphraseID1, Daughter_State2),
        has(Utt, semantic_value, Daughter_State2, LFphraseID2)),
conclusion(got_combo2(Utt, Mother_State, LFphraseID1, LFphraseID2))).

fif(and(got_combo2(Utt, Mother_State, LFphraseID1, LFphraseID2),
        and(isa(Utt, predicate, LFphraseID1),
            isa(Utt, predicate, LFphraseID2))),
conclusion(got_combo3(Utt, Mother_State, LFphraseID1, LFphraseID2))).

fif(got_combo3(Utt, Mother_State, LFphraseID1, LFphraseID2),
conclusion(complete_combo_rule3a(Utt, Mother_State, LFphraseID1, LFphraseID2))).

fif(and(complete_combo_rule3a(Utt, Mother_State, LFphraseID1, LFphraseID2),
        and(eval_bound(cappend_string(lf, Mother_State, LF_MotherID),[Mother_State]),
            eval_bound(cappend_string(var, LF_MotherID, VariableID),[LF_MotherID]))),
    conclusion(complete_combo_rule3b(Utt, Mother_State, LFphraseID1, LFphraseID2, LF_MotherID, VariableID))).

fif(complete_combo_rule3b(Utt, Mother_State, LFphraseID1, LFphraseID2, LF_MotherID, VariableID),    
conclusion(isa(Utt, lf_phrase, LF_MotherID))).

fif(complete_combo_rule3b(Utt, Mother_State, LFphraseID1, LFphraseID2, LF_MotherID, VariableID),
conclusion(isa(Utt, predicate, LF_MotherID))).

fif(complete_combo_rule3b(Utt, Mother_State, LFphraseID1, LFphraseID2, LF_MotherID, VariableID),
conclusion(has(Utt, daughter, LF_MotherID, LFphraseID1))).

fif(complete_combo_rule3b(Utt, Mother_State, LFphraseID1, LFphraseID2, LF_MotherID, VariableID),
conclusion(has(Utt, daughter, LF_MotherID, LFphraseID2))).

fif(complete_combo_rule3b(Utt, Mother_State, LFphraseID1, LFphraseID2, LF_MotherID, VariableID),
conclusion(has(Utt, token, 888, LF_MotherID))).

fif(complete_combo_rule3b(Utt, Mother_State, LFphraseID1, LFphraseID2, LF_MotherID, VariableID),
conclusion(has(Utt, semantic_value, Mother_State, LF_MotherID))).

fif(complete_combo_rule3b(Utt, Mother_State, LFphraseID1, LFphraseID2, LF_MotherID, VariableID),
conclusion(isa(Utt, variable, VariableID))).

fif(complete_combo_rule3b(Utt, Mother_State, LFphraseID1, LFphraseID2, LF_MotherID, VariableID),
conclusion(isa(Utt, VariableID, LF_MotherID))).

fif(and(complete_combo_rule3b(Utt, Mother_State, LFphraseID1, LFphraseID2, LF_MotherID, VariableID),
        and(isa(Utt, Variable1, LFphraseID1),
            isa(Utt, variable, Variable1))),
conclusion(equals4(Utt, Variable1, VariableID))).

fif(and(complete_combo_rule3b(Utt, Mother_State, LFphraseID1, LFphraseID2, LF_MotherID, VariableID),
        and(isa(Utt, Variable2, LFphraseID2),
            isa(Utt, variable, Variable2))),
conclusion(equals1(Utt, Variable2, VariableID))).

/*Combinatorial rule for A -> B, where A has a theta-role and B is a constant.*/
/*TO-DO: Add requirement that B be a constant; add the theta-meaning part of logical form.*/
fif(and(started(Action, act12, Struct_ID),
        and(has(Utt, syntactic_structure, Trans_ID, Struct_ID),
        and(has(Utt, daughter, Mother_State, Daughter_State),
        and(has(Utt, daughter, Mother_State, Daughter_State),
	and(parse_state(Utt, Mother_State, _, _, _, _, _, _),
        and(has(Utt, semantic_value, Daughter_State, LFphraseID),
            and(has(Utt, leftwall, Mother_State, LW),
                and(has(Utt, successor, LW, Daughter_State),                    
                   and(has(Utt, theta_role, Mother_State, ThetaID),
                        eval_bound(\+ pos_int_u(has(Utt, successor, Daughter_State, Daughter_State2)),[Utt, Daughter_State])))))))))),
conclusion(complete_combo_rule4a(Utt, Mother_State, Daughter_State, ThetaID))).

fif(and(complete_combo_rule4a(Utt, Mother_State, Daughter_State, ThetaID),
    and(has(Utt, semantic_value, Daughter_State, LFphraseID),
        and(eval_bound(cappend_string(lf, Mother_State, LF_MotherID),[Mother_State]),
            eval_bound(cappend_string(var, LF_MotherID, VariableID),[LF_MotherID])))),
    conclusion(complete_combo_rule4b(Utt, Mother_State, LFphraseID, LF_MotherID, VariableID, ThetaID))).

fif(complete_combo_rule4b(Utt, Mother_State, LFphraseID, LF_MotherID, VariableID, ThetaID),    
conclusion(isa(Utt, lf_phrase, LF_MotherID))).

fif(complete_combo_rule4b(Utt, Mother_State, LFphraseID, LF_MotherID, VariableID, ThetaID),
conclusion(isa(Utt, predicate, LF_MotherID))).

fif(complete_combo_rule4b(Utt, Mother_State, LFphraseID, LF_MotherID, VariableID, ThetaID),
conclusion(has(Utt, daughter, LF_MotherID, LFphraseID))).

fif(complete_combo_rule4b(Utt, Mother_State, LFphraseID, LF_MotherID, VariableID, ThetaID),
conclusion(has(Utt, semantic_value, Mother_State, LF_MotherID))).

fif(complete_combo_rule4b(Utt, Mother_State, LFphraseID, LF_MotherID, VariableID, ThetaID),
conclusion(isa(Utt, variable, VariableID))).

fif(complete_combo_rule4b(Utt, Mother_State, LFphraseID, LF_MotherID, VariableID, ThetaID),
conclusion(isa(Utt, VariableID, LF_MotherID))).

fif(complete_combo_rule4b(Utt, Mother_State, LFphraseID, LF_MotherID, VariableID, ThetaID),
conclusion(isa(Utt, event, VariableID))).

fif(and(complete_combo_rule4b(Utt, Mother_State, LFphraseID, LF_MotherID, VariableID, ThetaID),
        has(ThetaID, content, ThetaID, MeanID)),
conclusion(has(Utt, token, MeanID, LF_MotherID))).

fif(and(complete_combo_rule4b(Utt, Mother_State, LFphraseID, LF_MotherID, VariableID, ThetaID),
        and(isa(Utt, LFphraseID, Variable),
            and(isa(Utt, variable, Variable),
                has(Lang, content, ThetaID, MeanID)))),
conclusion(has(Utt, MeanID, VariableID, Variable))).

fif(and(started(Action, act12, Struct_ID),
	and(has(Utt, syntactic_structure, Trans_ID, Struct_ID),
	    and(has(Utt, translation, Utt, Trans_ID),
                and(isa(Utt, s, State),
	            has(Utt, semantic_value, State, _))))),
conclusion(end(Action, Struct_ID))).


/***********


Action 13 : Create top phrase


*************/

fif(and(begin(Action, Struct_ID),
       has(token, act13, Action)),
conclusion(started(Action, act13, Struct_ID))).


fif(and(started(Action, act13, Struct_ID),
       and(has(Utt, syntactic_structure, Trans_ID, Struct_ID), 
          and(isa(Utt, s, State),
	     and(has(Utt, semantic_value, State, _),
	        and(isa(Utt, translation, Trans_ID),
        	    eval_bound(cappend_string('lfstruct', Trans_ID, LFStruct_ID), [Trans_ID])))))),
conclusion(has(Utt, lf_structure, Trans_ID, LFStruct_ID))).

fif(has(Utt, lf_structure, LFTrans_ID, LFStruct_ID),
conclusion(isa(Utt, lf_structure, LFStruct_ID))).

fif(and(has(Utt, lf_structure, _, Struct_ID),
	and(isa(Utt, lf_phrase, Top_ID),
	    eval_bound(\+ pos_int_u(has(Utt, daughter, _, Top_ID)), [Utt, Top_ID]))),
    conclusion(has(Utt, top_phrase, Struct_ID, Top_ID))).

/*Notify user when complete LF has been built.*/

fif(and(isa(Utt, s, State),
        has(Utt, semantic_value, State, LF_sentence)),
conclusion(done_building_LF(Utt))).

fif(done_building_LF(Utt),
conclusion(notify_user(Utt, end_LF))).

fif(and(started(Action, act13, Struct_ID),
	and(has(Utt, syntactic_structure, Trans_ID, Struct_ID),
	    and(done_building_LF(Utt),
               and(has(Utt, lf_structure, Trans_ID2, Struct_ID2),
                  has(Utt, top_phrase, Struct_ID2, Top_ID))))),
conclusion(end(Action, Top_ID))).


/*******************

Action 14 : Generate command structure

*******************/

fif(and(begin(Action, Top_ID),
       has(token, act14, Action)),
conclusion(started(Action, act14, Top_ID))).

/*--------------------------------------------------------------------------------*/
/*Build Command Structure (then linearize it)*/

fif(and(started(Action, act14, Top_ID),
       has(Utt, top_phrase, Struct_ID, Top_ID)),
conclusion(generate_domain_command_structure1(Utt))).


fif(generate_domain_command_structure1(Utt),
    conclusion(notify_user(Utt, building_domain_command_structure))).

/*First, make LF_list which is the set of all logical form phrases created in the
  previous process.*/

/*Creates the unprocessed list by gathering the formulas, then taking their Phrase_ids as a list*/
fif(and(generate_domain_command_structure1(Utt),
        and(eval_bound(gather_all(isa(Utt, lf_phrase, _), LF_formula_list),[Utt]),
            eval_bound(get_lf_ids(LF_formula_list, [], LF_list),[LF_formula_list]))),
conclusion(generate_domain_command_structure2(Utt, LF_list))).


/*Next, create a structure using the Earley parsing algorithm */
/*Start: create first state. */
/*Make new state ID.*/

fif(and(generate_domain_command_structure2(Utt, LF_list),
        and(eval_bound(unique_id([ID]),[]),
            eval_bound(cappend_string('st', ID, State), [ID]))),
    conclusion(domain_parse_state(Utt, State, start, [], [s], [], LF_list, [], [], [], scr1, []))).


/*
   TODO : Remove ugly hack for specific-domain naming c4. we need to decide how to determine what language we are translating into
*/

fif(and(isa(Utt, current_utterance),
     and(domain_parse_state(Utt, State, start, [], [s], [], LF_list, [], [], [], scr1, []),
          and(eval_bound(form_to_name(generate_domain_command_structure2(Utt, LF_list), New_ID), [Utt, LF_list]),
             eval_bound(cappend_num_to_string('trans', New_ID, Trans_ID), [New_ID])))),
    conclusion(create_translation(Utt, Trans_ID, c4))).


fif(create_translation(Utt, Trans_ID, Lang_ID),
conclusion(isa(Utt, translation, Trans_ID))).

fif(create_translation(Utt, Trans_ID, Lang_ID),
conclusion(has(Utt, language, Trans_ID, Lang_ID))).

/*translation plan*/

fif(and(isa(Utt, translation, Trans_ID1),
	and(isa(Utt, translation, Trans_ID2),
	    and(has(Utt, language, Trans_ID1, c2),
		has(Utt, language, Trans_ID2, c4)))),
    conclusion(make_translation_plan1(Utt, Trans_ID1, Trans_ID2))).

fif(and(make_translation_plan1(Utt, Trans_ID1, Trans_ID2),
         and(eval_bound(form_to_name(make_translation_plan1(Utt, Trans_ID1, Trans_ID2), New_ID), [Utt, Trans_ID1, Trans_ID2]),
             eval_bound(cappend_num_to_string('plan', New_ID, Plan_ID), [New_ID]))),
    conclusion(make_translation_plan2(Utt, Plan_ID, Trans_ID1, Trans_ID2))).

fif(make_translation_plan2(Utt, Plan_ID, Trans_ID1, Trans_ID2),
    conclusion(isa(Utt, translation_plan, Plan_ID))).

fif(make_translation_plan2(Utt, Plan_ID, Trans_ID1, Trans_ID2),
    conclusion(has(Utt, translation_plan, Utt, Plan_ID))).

fif(make_translation_plan2(Utt, Plan_ID, Trans_ID1, Trans_ID2),
    conclusion(has(Utt, begin, Plan_ID, Trans_ID1))).

fif(make_translation_plan2(Utt, Plan_ID, Trans_ID1, Trans_ID2),
    conclusion(has(Utt, end, Plan_ID, Trans_ID2))).

/*The Predictor*/

fif(and(domain_parse_state(Utt, State, _, _, [First_RHS | Rest_RHS], _, U_lf, History, Needs_theta, Gives_theta, Sem_check_rule, _),
        and(isa(c4, domain_syntax_rule, Rule),
            and(has(c4, left_hand_side, Rule, First_RHS),
                and(has(c4, right_hand_side, Rule, New_RHS),
                    and(eval_bound(\+ pos_int_u(domain_parse_state(Utt, _, First_RHS, [], New_RHS, [], 
		    U_lf, [], _, _, Sem_check_rule, _)),[Utt, First_RHS, New_RHS, U_lf, Sem_check_rule]),
			and(has(Concept, semantic_checker_rule, Rule, New_semantic_rule_check),
			    eval_bound(cappend_string(State, Rule, New_state),[State, Rule]))))))),
    conclusion(predictor_state1(Utt, New_state, First_RHS, New_RHS, U_lf, History, Needs_theta, Gives_theta, New_semantic_rule_check))).

fif(and(predictor_state1(Utt, New_state, First_RHS, New_RHS, Unprocessed_lf, _, _, _, New_semantic_rule_check),
	eval_bound(gather_all(predictor_state1(Utt, _, First_RHS, New_RHS, Unprocessed_lf, _, _, _, New_semantic_rule_check), Poss_Dupes),
	[Utt, First_RHS, New_RHS, Unprocessed_lf])),
conclusion(predictor_state2_a(Poss_Dupes))).

/*Get list of formula names*/
/*Start condition: find the first formula number for first element of duplicates list, send it to loop.*/
fif(and(predictor_state2_a([First | Rest]),
        eval_bound(form_to_name(First, Formula_number),[First])),
conclusion(predictor_state2_b(Rest, [Formula_number]))).

/*Loop: go through each formula, find its number, and append it to the list.*/
fif(and(predictor_state2_b([First | Rest], Formula_nums),
        and(eval_bound(form_to_name(First, First_number),[First]),
	    eval_bound(append(Formula_nums, [First_number], New_formula_nums),[Formula_nums, First_number]))),
conclusion(predictor_state2_b(Rest, New_formula_nums))).

/*Stop condition: when list is empty, go on with check.*/
fif(predictor_state2_b([], Formula_nums),
conclusion(predictor_state3(Formula_nums))).

/*Now send list to prolog to discard duplicates (if any), return a single parse state number,
  and use it to create the new parse state.*/
fif(and(predictor_state3(Formula_nums),
	and(eval_bound(discard_duplicates(Formula_nums, Parse_state),[Formula_nums]),
	    predictor_state1(Utt, Parse_state, LHS, RHS, Unprocessed_lf, _, _, _, Sem_rule_check))),
conclusion(domain_parse_state(Utt, Parse_state, LHS, [], RHS, [], Unprocessed_lf, [], [], [], Sem_rule_check, []))).


/*The Scanner: */
/*Check to see the new parse state already exists.*/


/*Scanner #1: Vacuous case*/
fif(and(domain_parse_state(Utt, StateID, _, _,[First_RHS | _],_, LF_list, _, _, _, _, _),
	and(has(c4, label, CatID, First_RHS),
    	      and(has(LexID, category, LexID, CatID),
		  has(LexID, content, LexID, nil)))),
conclusion(scanner3(Utt, StateID, First_RHS, LexID, [], LF_list, []))).

fif(and(domain_parse_state(Utt, StateID, _, _,[First_RHS | _],_, LF_list, _, _, _, _, _),
	and(has(c4, label, CatID, First_RHS),
               and(has(LexID, category, LexID, CatID),
	  eval_bound(\+ pos_int(has(LexID, content, LexID, nil)),[LexID])))),
conclusion(scanner2(Utt, StateID, First_RHS, LF_list, []))).

/*Scanner #2: Meaningful case*/
fif(and(scanner2(Utt, StateID, First_RHS, [First_lf | Rest_lf], Front_lf),
	and(has(Utt, token, MeaningID, First_lf),
	    and(has(LexID, content, LexID, MeaningID),
		and(eval_bound(\+ pos_int(has(LexID, content, LexID, nil)),[LexID]),
		    and(has(LexID, category, LexID, CatID),
			has(c4, label, CatID, First_RHS)))))),
conclusion(scanner3(Utt, StateID, First_RHS, LexID, [First_lf], Rest_lf, Front_lf))).

fif(and(scanner2(Utt, StateID, First_RHS, [First_lf | Rest_lf], Front_lf),
	and(eval_bound(\+ pos_int(has(Utt, token, _, First_lf)),[Utt, First_lf]),
	    eval_bound(append(Front_lf, [First_lf], New_front_lf),[Front_lf, First_lf]))),
conclusion(scanner2(Utt, StateID, First_RHS, Rest_lf, New_front_lf))).

fif(and(scanner3(Utt, StateID, First_RHS, LexID, First_lf, Rest_lf, Front_lf),
	eval_bound(gather_all(scanner3(Utt, _, First_RHS, LexID, First_lf, Rest_lf, Front_lf), Poss_Dupes),
	[Utt, First_RHS, LexID, First_lf, Rest_lf, Front_lf])),
conclusion(scanner3_a(Poss_Dupes))).

/*Get list of formula names*/
/*Start condition: find the first formula number for first element of duplicates list, send it to loop.*/
fif(and(scanner3_a([First | Rest]),
        eval_bound(form_to_name(First, Formula_number),[First])),
conclusion(scanner3_b(Rest, [Formula_number]))).

/*Loop: go through each formula, find its number, and append it to the list.*/
fif(and(scanner3_b([First | Rest], Formula_nums),
        and(eval_bound(form_to_name(First, First_number),[First]),
	    eval_bound(append(Formula_nums, [First_number], New_formula_nums),[Formula_nums, First_number]))),
conclusion(scanner3_b(Rest, New_formula_nums))).

/*Stop condition: when list is empty, go on with check.*/
fif(scanner3_b([], Formula_nums),
conclusion(scanner3_c(Formula_nums))).

/*Now send list to prolog to discard duplicates (if any), return a single parse state number,
  and use it to create the new parse state.*/
fif(and(scanner3_c(Formula_nums),
	and(eval_bound(discard_duplicates(Formula_nums, Parse_state),[Formula_nums]),
	    scanner3(Utt, Parse_state, First_RHS, LexID, First_lf, Rest_lf, Front_lf))),
conclusion(scanner4(Utt, Parse_state, First_RHS, LexID, First_lf, Rest_lf, Front_lf))).    


fif(and(scanner4(Utt, StateID, First_RHS, LexID, First_lf, Rest_lf, Front_lf),
	and(has(LexID, theta_role_to_assign, LexID, Theta),
	    eval_bound(\+ pos_int_u(domain_parse_state(Utt, _, First_RHS, [LexID], [], First_lf, _, [], _, [Theta], done, _)),[Utt, First_RHS, First_lf, LexID, Theta]))),
conclusion(domain_scanner_finish(Utt, nil, First_RHS, [LexID], First_lf, Rest_lf, Front_lf, [Theta]))).

fif(and(scanner4(Utt, StateID, First_RHS, LexID, First_lf, Rest_lf, Front_lf),
	and(eval_bound(\+ pos_int_u(has(LexID, theta_role_to_assign, LexID, Theta)),[LexID]),
	    eval_bound(\+ pos_int_u(domain_parse_state(Utt, _, First_RHS, [LexID], [], First_lf, _, [], _, [], done, _)),[Utt, First_RHS, First_lf, LexID]))),
conclusion(domain_scanner_finish(Utt, StateID, First_RHS, [LexID], First_lf, Rest_lf, Front_lf, []))).

/*
  This intermediate step was added in order to build a word list to later verify that 
  the tree-building finishes
*/
fif(and(domain_scanner_finish(Utt, StateID, LHS, RHS, First_lf, Rest_lf, Front_lf, Theta_list),
        and(eval_bound(form_to_name(domain_scanner_finish(Utt, StateID, LHS, RHS, First_lf, Rest_lf, Front_lf, Theta_list), New_ID),
        [Utt, StateID, LHS, RHS, First_lf, Rest_lf, Front_lf, Theta_list]),
            and(eval_bound(cappend_num_to_string('st', New_ID, New_state),[New_ID]),
		eval_bound(append(Front_lf, Rest_lf, Unprocessed_lf),[Front_lf, Rest_lf])))),
    conclusion(word_list_and_state(Utt, New_state, LHS, RHS, First_lf, Unprocessed_lf, Theta_list))).

fif(word_list_and_state(Utt, New_state, LHS, RHS, First_lf, Unprocessed_lf, Theta_list),
conclusion(domain_parse_state(Utt, New_state, LHS, RHS, [], First_lf, Unprocessed_lf, [], [], Theta_list, done, First_lf))).

fif(word_list_and_state(Utt, New_state, LHS, [RHS | _ ], First_lf, Unprocessed_lf, Theta_list),
conclusion(has(Utt, member, word_set, RHS))).


fif(and(domain_scanner_finish(Utt, StateID, First_RHS, LexID, First_lf, Rest_lf, Front_lf, Theta_list),
	eval_bound(append(Front_lf, First_lf, New_front_lf),[Front_lf, Rest_lf])),
conclusion(scanner2(Utt, StateID, First_RHS, Rest_lf, New_front_lf))).


/*
 *   Completer
 */ 
fif(and(domain_parse_state(Utt, State, LHS, P_rhs, [], P_lf_list, U_lf_list, History, Needs_theta, Gives_theta, done, D_lf),
     and(domain_parse_state(Utt, State2, LHS2, P_rhs2, [LHS | Rest_U_rhs], P_lf_list2, U_lf_list2, History2, Needs_theta2, Gives_theta2, Sem_rule_check2, D_lf2),
    	and(eval_bound(two_lists_to_set(P_lf_list2, P_lf_list, New_proccessed_set),[P_lf_list2, P_lf_list]),
            and(eval_bound(append([History2, [State]], New_history), [State, History2]),
                and(eval_bound(append(Needs_theta,  Needs_theta2, New_needs_theta), [Needs_theta, Needs_theta2]),
                   and(eval_bound(append(Gives_theta, Gives_theta2, New_gives_theta), [Gives_theta, Gives_theta2]),
                       and(eval_bound(subseq(U_lf_list2, New_unproccessed_set, P_lf_list), [U_lf_list2, P_lf_list]),
                          eval_bound(append(P_rhs2,  [LHS], New_Proc_RHS), [P_rhs2, LHS])))))))),
conclusion(domain_ps_theta_check(Utt, LHS2, New_Proc_RHS, Rest_U_rhs, New_proccessed_set, New_unproccessed_set, New_history, New_needs_theta, New_gives_theta, Sem_rule_check2, D_lf, D_lf2))).

/* 
assign thetarole gets passed from B unless theta role to assign gets satisfied, then that lfPhraseID is moved from unproc to proced
*/

fif(and(domain_ps_theta_check(Utt, LHS, P_rhs, U_rhs, P_lf_list, U_lf_list, History, Needs_theta, Gives_theta, Sem_rule_check, D_lf, D_lf2),
	eval_bound(form_to_name(domain_ps_theta_check(Utt, LHS, P_rhs, U_rhs, P_lf_list, U_lf_list, History, Needs_theta, Gives_theta, Sem_rule_check, D_lf, D_lf2), StateNum), 
		   [Utt, LHS, P_rhs, U_rhs, P_lf_list, U_lf_list, History, Needs_theta, Gives_theta, Sem_rule_check])),
conclusion(domain_ps_theta_check2(Utt, StateNum, LHS, P_rhs, U_rhs, P_lf_list, U_lf_list, History, Needs_theta, Gives_theta, Sem_rule_check, D_lf, D_lf2))).


fif(and(domain_ps_theta_check2(Utt, StateNum, LHS, P_rhs, U_rhs, P_lf_list, U_lf_list, History, [Needs_theta | Rest_needs_theta], [Gives_theta | Rest_gives_theta], Sem_rule_check, D_lf, D_lf2),
                and(isa(LangID, theta_role, Gives_theta),
                   and(has(Gives_theta, content, Gives_theta, MeaningId),
                     and(isa(MeaningId, meaning, MeaningId),
		      and(eval_bound(cappend_num_to_string('st', StateNum, New_state_num),[StateNum]),
                          and(has(Utt, token, MeaningId, Needs_theta),
                              and(eval_bound(delete(U_lf_list, Needs_theta, New_U_lf_list), [U_lf_list, Needs_theta]),
                                  eval_bound(append(D_lf2, [Needs_theta], New_D_lf), [D_lf2, Needs_theta])))))))),
conclusion(domain_parse_state(Utt, New_state_num, LHS, P_rhs, U_rhs, [Needs_theta | P_lf_list], New_U_lf_list, History, Rest_needs_theta, Rest_gives_theta, Sem_rule_check, New_D_lf))).



fif(and(domain_ps_theta_check2(Utt, StateNum, LHS, P_rhs, U_rhs, P_lf_list, U_lf_list, History, [], [Gives_theta | Rest_Gives_theta], Sem_rule_check, D_lf, D_lf2),
        and(eval_bound(append(D_lf, D_lf2, New_D_lf), [D_lf, D_lf2]),
           eval_bound(cappend_num_to_string('st', StateNum, New_state_num),[StateNum]))),
conclusion(domain_parse_state(Utt, New_state_num, LHS, P_rhs, U_rhs, P_lf_list, U_lf_list, History, [], [Gives_theta | Rest_Gives_theta], Sem_rule_check, New_D_lf))).


fif(and(domain_ps_theta_check2(Utt, StateNum, LHS, P_rhs, U_rhs, P_lf_list, U_lf_list, History, [], [], Sem_rule_check, D_lf, D_lf2),
       and(eval_bound(append(D_lf, D_lf2, New_D_lf), [D_lf, D_lf2]),
          eval_bound(cappend_num_to_string('st', StateNum, New_state_num),[StateNum]))),
conclusion(domain_parse_state(Utt, New_state_num, LHS, P_rhs, U_rhs, P_lf_list, U_lf_list, History, [], [], Sem_rule_check, New_D_lf))).

fif(and(domain_ps_theta_check2(Utt, StateNum, LHS, P_rhs, U_rhs, P_lf_list, U_lf_list, History, [Needs_theta | Rest_needs_theta], [], Sem_rule_check, D_lf, D_lf2),
        and(eval_bound(append(D_lf, D_lf2, New_D_lf), [D_lf, D_lf2]),
          eval_bound(cappend_num_to_string('st', StateNum, New_state_num),[StateNum]))),
conclusion(domain_parse_state(Utt, New_state_num, LHS, P_rhs, U_rhs, P_lf_list, U_lf_list, History, [Needs_theta | Rest_needs_theta], [], Sem_rule_check, New_D_lf))).



/*  The Semantic Checker  */

/*Start semantic checker if:
	a)NP on the LHS???
	b). on the right end
	c)No check mark - i.e. not 'done' in last column
*/
fif(and(domain_parse_state(Utt, State_ID, _, Processed_RHS, [], _, _, _, _, _, _, _),
        eval_bound(\+ pos_int_u(domain_parse_state(Utt, State_ID, _, _, _, _, _, _, _, _, done, _)), [Utt, State_ID])),
conclusion(create_sch_state(Utt, State_ID))).

/*
Create new 'parse state' for the semantic checker to work on.
*/

fif(and(create_sch_state(Utt, State_ID),
	and(domain_parse_state(Utt, State_ID, LHS, Processed_RHS, Unprocessed_RHS, Processed_LF, Unprocessed_LF, History, Needs_Theta, Assigned_Theta, SCH_Rule, D_lf),
		eval_bound(cappend_string(State_ID, 'sc', New_ID), [State_ID]))),
conclusion(sch_parse_state(Utt, New_ID, LHS, Processed_RHS, Unprocessed_RHS, Processed_LF, Unprocessed_LF, History, Needs_Theta, Assigned_Theta, SCH_Rule, D_lf))).

/*
Semantic checker rule 1: A->B where A has no theta-role assigner.

In the unprocessed lf list of the parse state, find an lf phrase which has just one daughter, where that daughter is a member of the processed lf list of the history state. 
*/

fif(sch_parse_state(Utt, State_ID, LHS, Processed_RHS, Unprocessed_RHS, Processed_LF, Unprocessed_LF, History, Needs_Theta, Assigned_Theta, scr1, D_lf),
conclusion(domain_parse_state(Utt, State_ID, LHS, Processed_RHS, Unprocessed_RHS, Processed_LF, Unprocessed_LF, History, Needs_Theta, Assigned_Theta, done, D_lf))).






/*
Remove that lf phrase from the unprocessed lf list.
*/
fif(and(execute_sch_remove(Utt, State_ID, LF_ID),
	and(sch_parse_state(Utt, State_ID, _, _, _, Processed_LF, Unprocessed_LF, _, _, _, _, _),
		eval_bound(delete(Unprocessed_LF, LF_ID, New_Unprocessed_LF), [Unprocessed_LF, LF_ID]))),
conclusion(execute_sch_add(Utt, State_ID, LF_ID, New_Unprocessed_LF))).

/*
Add that lf phrase to the processed lf list and append to Daughter lf list.
*/
fif(and(execute_sch_add(Utt, State_ID, LF_ID, New_Unprocessed_LF),
	and(sch_parse_state(Utt, State_ID, _, _, _, Processed_LF, Unprocessed_LF, _, _, _, _, D_lf),
		eval_bound(append([LF_ID], Processed_LF, New_Processed_LF), [LF_ID, Processed_LF]))),
              conclusion(execute_sch_modify_state(Utt, State_ID, New_Unprocessed_LF, New_Processed_LF))).

fif(and(execute_sch_modify_state(Utt, State_ID, New_Unprocessed_LF, New_Processed_LF),
    and(eval_bound(sort(New_Processed_LF, Sorted_New_Processed_LF), [New_Processed_LF]),
	sch_parse_state(Utt, State_ID, LHS, Processed_RHS, Unprocessed_RHS, Processed_LF, Unprocessed_LF, History, Needs_Theta, Assigned_Theta, SCH_Rule, D_lf))),
conclusion(domain_parse_state(Utt, State_ID, LHS, Processed_RHS, Unprocessed_RHS, Sorted_New_Processed_LF, New_Unprocessed_LF, History, Needs_Theta, Assigned_Theta, 
    done, D_lf))).

/*
Semantic checker rule 2: A->BC where B is vacuous and C is a constant.

Do nothing, just add the check mark.
*/

fif(and(sch_parse_state(Utt, State_ID, LHS, Processed_RHS, Unprocessed_RHS, Processed_LF, Unprocessed_LF, [History_State1, History_State2], Needs_Theta, Assigned_Theta, scr2, D_lf),
	and(isa(Utt, lf_phrase, LF_ID),
	    and(isa(Utt, predicate, LF_ID),
               and(eval_bound(member(LF_ID, Processed_LF), [LF_ID, Processed_LF]),
		  and(domain_parse_state(Utt, History_State1, _, [First_RHS|_], _, _, _, _, _, _, _, _),
                     and(has(First_RHS, lexeme, c4, First_RHS),
                        and(has(First_RHS, content, First_RHS, nil),
			   and(domain_parse_state(Utt, History_State2, _, _, _, _, Daughter_Unprocessed_LF, _, Daughter_Needs_Theta, _, _, _),
                              and(eval_bound(append(Daughter_Unprocessed_LF, Daughter_Needs_Theta, New_list),[Daughter_Unprocessed_LF, Daughter_Needs_Theta]),
                                 eval_bound(member(LF_ID, New_list), [LF_ID, New_list])))))))))),
conclusion(domain_parse_state(Utt, State_ID, LHS, Processed_RHS, Unprocessed_RHS, Processed_LF, Unprocessed_LF, [History_State1, History_State2], Needs_Theta, 
    Assigned_Theta, done, D_lf))).

/*
Semantic checker rule 3: A -> BC where B and C are both predicates.

In the unprocessed lf list of the parse state, find an lf phrase which has two distinct daughters, where each daughter is a member of the processed lf list of a 
history state. 
*/
fif(and(sch_parse_state(Utt, State_ID, LHS, Processed_RHS, Unprocessed_RHS, Processed_LF, Unprocessed_LF, [History_State1, History_State2], Needs_Theta, 
    Assigned_Theta, scr3, D_lf),
	and(isa(Utt, lf_phrase, LF_ID),
	    and(isa(Utt, predicate, LF_ID),
		and(has(Utt, daughter, LF_ID, Daughter1_ID),
		    and(isa(Utt, predicate, Daughter1_ID),
			and(has(Utt, daughter, LF_ID, Daughter2_ID),	
			    and(isa(Utt, predicate, Daughter2_ID),
                                and(eval_bound(not_equal_string(Daughter1_ID, Daughter2_ID), [Daughter1_ID, Daughter2_ID]),
                                    and(eval_bound(member(Daughter1_ID, D_lf), [Daughter1_ID, D_lf]),
                                       eval_bound(member(Daughter2_ID, D_lf),[Daughter2_ID, D_lf])))))))))),	         				
conclusion(execute_sch_remove(Utt, State_ID, LF_ID))).

/*
Semantic checker rule 4: A->B where A has a theta role assigner and B is a constant.

In the unprocessed lf list of the parse state, find an lf phrase which has just one daughter, where that daughter is a member of the processed lf list of the 
history state. If that lf phrase also has a theta role assigner, then move the lf phrase to the 'needs theta' column. 
*/

fif(and(sch_parse_state(Utt, State_ID, LHS, Processed_RHS, Unprocessed_RHS, Processed_LF, Unprocessed_LF, [History_State], Needs_Theta, Assigned_Theta, scr4, D_lf),
	and(isa(Utt, lf_phrase, LF_ID),
	    and(has(Utt, daughter, LF_ID, Daughter_ID),
		and(eval_bound(\+ pos_int_u(has(Utt, successor, Daughter_ID, _)), [Utt, Daughter_ID]),
		    and(has(Utt, semantic_value, Semantic_State, LF_ID),
			and(has(Utt, theta_role, Semantic_State, _),
			    and(domain_parse_state(Utt, History_State, _, _, _, History_Processed_LF, _, _, _, _, _, _),
				and(eval_bound(member(LF_ID, Unprocessed_LF), [LF_ID, Unprocessed_LF]),
				    eval_bound(member(Daughter_ID, History_Processed_LF), [Daughter_ID, History_Processed_LF]))))))))),
conclusion(execute_sch_remove_theta(Utt, State_ID, LF_ID))).


/*
Remove that lf phrase from the unprocessed lf list.
*/
fif(and(execute_sch_remove_theta(Utt, State_ID, LF_ID),
	and(sch_parse_state(Utt, State_ID, _, _, _, Processed_LF, Unprocessed_LF, _, _, _, _, _),
		eval_bound(delete(Unprocessed_LF, LF_ID, New_Unprocessed_LF), [Unprocessed_LF, LF_ID]))),
conclusion(execute_sch_add_theta(Utt, State_ID, LF_ID, New_Unprocessed_LF))).

/*
Add that lf phrase to the needs theta list.
*/
fif(and(execute_sch_add_theta(Utt, State_ID, LF_ID, New_Unprocessed_LF),
	and(sch_parse_state(Utt, State_ID, _, _, _, Processed_LF, Unprocessed_LF, _, Needs_Theta, _, _, _),
		eval_bound(append([LF_ID], Needs_Theta, New_Needs_Theta), [LF_ID, Needs_Theta]))),
conclusion(execute_sch_modify_state_theta(Utt, State_ID, New_Unprocessed_LF, New_Needs_Theta))).

fif(and(execute_sch_modify_state_theta(Utt, State_ID, New_Unprocessed_LF, New_Needs_Theta),
    and(eval_bound(sort(New_Needs_Theta, Sorted_Theta), [New_Needs_Theta]),
	sch_parse_state(Utt, State_ID, LHS, Processed_RHS, Unprocessed_RHS, Processed_LF, Unprocessed_LF, History, Needs_Theta, Assigned_Theta, SCH_Rule, D_lf))),
conclusion(domain_parse_state(Utt, State_ID, LHS, Processed_RHS, Unprocessed_RHS, Processed_LF, New_Unprocessed_LF, History, Sorted_Theta, Assigned_Theta, done, D_lf))).


/*----End of Semantic Checker ----- */


fif(and(domain_parse_state(Utt, State, start, [s], [], _, [], _, _, _, done, _),
    and(started(Action, act14, Top_ID),
        and(has(Utt, top_phrase, Struct_ID, Top_ID),
           and(isa(Utt, translation, Trans_ID),
              has(Utt, language, Trans_ID, c4))))),
conclusion(end(Action, Trans_ID))). 





/*********************

Action 15 : Structure builder


**********************/

/*When the first part of the parsing is complete, build a 
  phrase marker by looking through the histories of the states
  that lead to the final start_s -> s. state. This is a 
  recursive process.  The first step is to build the S-phrase.
*/
/*First, find the stateID for 'start_s --> s.'  Then make an S phrase.
  When the S phrase has been built, use the history list from stateID
  to find the next state(s), which will give us S's daughter(s). 
  Use these states to enter the recursive phrase_marker builder that 
  goes DOWN the tree.*/

fif(and(begin(Action, Trans_ID),
       has(token, act15, Action)),
conclusion(started(Action, act15, Trans_ID))).

fif(and(domain_parse_state(Utt, State, start, [s], [], _, [], _, _, _, done, _),
    started(Action, act15, Trans_ID)),
    conclusion(domain_start_building_structure(Utt, State))).


/* Start off the process */
fif(and(domain_start_building_structure(Utt, S_State),
	and(domain_parse_state(Utt, S_State, _, _, _, _, _, History, _, _, _, Daughter_LFs),
		eval_bound(\+ pos_int_u(domain_parse_state(Utt, S_State, _, _, _, _, _, [], _, _, _, _)), [Utt, S_State]))),
	conclusion(domain_start_building_node(Utt, S_State, History, Daughter_LFs))).

/* Create the leftwall before starting working on the current node of the tree - if the history is empty in the parse state,
then it's a terminal -  so don't build a leftwall; if there is a predecessor, then also don't build a leftwall */
fif(and(domain_start_building_node(Utt, State, History, Daughter_LFs),
	and(eval_bound(\+ pos_int_u(domain_parse_state(Utt, State, _, _, _, _, _, [], _, _, _, _)), [Utt, State]),
               eval_bound(cappend_string(lw, State, Leftwall), [State]))),
	conclusion(domain_create_leftwall(Utt, State, Leftwall, History, Daughter_LFs))).

/*               and(eval_bound(\+ pos_int_u(has(Utt, successor, _, State)), [Utt, State]),*/

fif(domain_create_leftwall(Utt, State, Leftwall, History, _),
	conclusion(isa(Utt, leftwall, Leftwall))).

fif(domain_create_leftwall(Utt, State, Leftwall, History, _),
	conclusion(has(Utt, leftwall, State, Leftwall))).

fif(domain_create_leftwall(Utt, State, Leftwall, [First|_], _),
	conclusion(has(Utt, successor, Leftwall, First))).

/* Once the leftwall has been created, start working on the current node */
fif(and(domain_create_leftwall(Utt, State, Leftwall, History, Daughter_LFs),
	and(isa(Utt, leftwall, Leftwall),
		and(has(Utt, leftwall, State, Leftwall),
			has(Utt, successor, Leftwall, _)))),
	conclusion(domain_build_node(Utt, State, History, Daughter_LFs))).

/* If we're not creating a leftwall, go straight to build node */
fif(and(domain_start_building_node(Utt, State, History, Daughter_LFs),
	    domain_parse_state(Utt, State, _, _, _, _, _, [], _, _, _, _)),
	conclusion(domain_build_node(Utt, State, History, Daughter_LFs))).

fif(and(domain_start_building_node(Utt, State, History, Daughter_LFs),
	    has(Utt, successor, _, State)),
	conclusion(domain_build_node(Utt, State, History, Daughter_LFs))).

/* Add the facts about the current node */
fif(domain_build_node(Utt, State, History, Daughter_LFs),
	conclusion(domain_build_node_facts(Utt, State, History, Daughter_LFs))).

fif(domain_build_node_facts(Utt, State, History, _),
	conclusion(isa(Utt, phrase, State))).

fif(and(domain_build_node_facts(Utt, State, History, _),
		domain_parse_state(Utt, State, LHS, _, _, _, _, _, _, _, _, _)),
	conclusion(isa(Utt, LHS, State))).

/* If the history is empty in the domain parse state, then it's a terminal phrase */
fif(and(domain_build_node_facts(Utt, State, History, _),
		domain_parse_state(Utt, State, _, _, _, _, _, [], _, _, _, _)),
	conclusion(isa(Utt, terminal_phrase, State))).

fif(and(domain_build_node_facts(Utt, State, History, Daughter_LFs),
       and(isa(Utt, terminal_phrase, State),
           and(domain_parse_state(Utt, State, _, [Processed_RHS], _, _, _, _, _, _, _, _),
               and(eval_bound(form_to_name(isa(Utt, terminal_phrase, State), FormNum),[Utt, State]),
                   eval_bound(cappend_num_to_string('w', FormNum, WordID), [FormNum]))))),
conclusion(domain_create_terminal_node(Utt, State, Processed_RHS, WordID))).
	
fif(domain_create_terminal_node(Utt, Terminal_State, Processed_RHS, WordID),
conclusion(isa(Utt, WordID, Terminal_State))).

/*TODO : Once we start using correct look-up values throughout the entire program, remove the started() fact
below - in it's current state it could lead to problems if there are multiple instances of act15 */

fif(and(domain_create_terminal_node(Utt, Terminal_State, Processed_RHS, WordID),
    started(_, act15, Trans_ID)),
conclusion(isa(Trans_ID, word, WordID))).

fif(domain_create_terminal_node(Utt, Terminal_State, Processed_RHS, WordID),
conclusion(has(Utt, token, Processed_RHS, WordID))).

fif(domain_create_terminal_node(Utt, Terminal_State, Processed_RHS, WordID),
conclusion(isa(Utt, word, Utt, WordID))).

/* Add a daughter relation to the next item in the history list */
fif(and(domain_build_node(Utt, State, [First|_], Daughter_LFs),
		domain_parse_state(Utt, First, _, _, _, _, _, _, _, _, _, _)),
	conclusion(has(Utt, daughter, State, First))).

/* Add the semantic value link between that daughter and the next item in the daughter lf list */
fif(and(domain_build_node(Utt, State, [First|_], [First_LF|_]),
		domain_parse_state(Utt, First, _, _, _, _, _, _, _, _, _, _)),
	conclusion(has(Utt, semantic_value, First, First_LF))).

/* Start building the daughter node - loops back above */
fif(and(domain_build_node(Utt, State, [First|Rest], _),
		domain_parse_state(Utt, First, _, _, _, _, _, First_History, _, _, _, First_Daughter_LFs)),
	conclusion(domain_start_building_node(Utt, First, First_History, First_Daughter_LFs))).

/* If there is no more history with the current node, then go back to working on the parent with it's remaining history */
fif(and(domain_build_node(Utt, State, [], _),
	and(has(Utt, daughter, Parent, State),
		domain_build_node(Utt, Parent, [State|Rest], Daughter_LFs))),
	conclusion(domain_build_successor_node(Utt, Parent, State, Rest, Daughter_LFs))).

/* Create the successor relationship with the next item in the parent's remaining history */
fif(and(domain_build_successor_node(Utt, Parent, State, [First|_], Daughter_LFs),
		eval_bound(\+ pos_int_u(domain_build_successor_node(Utt, Parent, State, [], _)), [Utt, Parent, State])),
	conclusion(has(Utt, successor, State, First))).

/* Loop back: start building the next item in the parent's remaining history */
fif(domain_build_successor_node(Utt, Parent, State, Rest, [First_LF|Rest_LFs]),
	conclusion(domain_build_node(Utt, Parent, Rest, Rest_LFs))).

fif(domain_build_successor_node(Utt, Parent, State, Rest, []),
	conclusion(domain_build_node(Utt, Parent, Rest, []))).

/* Assign semantic value for S manually */
fif(and(domain_start_building_structure(Utt, State),
	domain_parse_state(Utt, _, start, [s], [], _, [], _, _, _, _, [Daughter_LF])),
    conclusion(has(Utt, semantic_value, State, Daughter_LF))).

/* If the work for the current node is done (i.e. all the history has been processed and the history is now empty), and if the current node is 
not the daughter of any other node, then we're back at the root and the tree is complete */
fif(and(domain_build_node(Utt, State, [], _),
		eval_bound(\+ pos_int_u(has(Utt, daughter, _, State)), [Utt, State])),
	conclusion(domain_done_building_structure(Utt))).


fif(domain_done_building_structure(Utt),
conclusion(second_generation_complete(Utt))).

fif(second_generation_complete(Utt),
    conclusion(notify_user(Utt, parsing_utt_done))).

fif(second_generation_complete(Utt),
    conclusion(notify_user(Utt, begin_linearization))).

fif(second_generation_complete(Utt),
    conclusion(start_building_domain_structure(Utt))).

fif(and(start_building_domain_structure(Utt),
        and(isa(Utt, translation, Trans_ID),
           and(has(Utt, language, Trans_ID, c4),
            eval_bound(cappend_string('genstruct', Trans_ID, Struct_ID), [Trans_ID])))),
    conclusion(create_structure(Utt, Struct_ID, Trans_ID))).

/*
fif(and(generate_domain_command_structure2(Utt, _),
        and(isa(Utt, translation, Trans_ID),
           and(has(Utt, language, Trans_ID, c4),
            eval_bound(cappend_string('genstruct', Trans_ID, Struct_ID), [Trans_ID])))),
    conclusion(create_structure(Utt, Struct_ID, Trans_ID))).
*/

fif(create_structure(Utt, Struct_ID, Trans_ID),
conclusion(isa(Utt, structure, Struct_ID))).

fif(and(create_structure(Utt, Struct_ID, Trans_ID),
      and(isa(Utt, translation_plan, Plan_ID),
        and(has(Utt, end, Plan_ID, Trans_ID),
           and(has(Utt, language, Trans_ID, c4),
              isa(Utt, structure, Struct_ID))))),
    conclusion(has(Utt, generation_structure, Trans_ID, Struct_ID))).


fif(and(domain_parse_state(Utt, State, start, [s], [], _, [], _, _, _, done, _),
        and(has(Utt, generation_structure, Trans_ID, Struct_ID),
            has(Utt, language, Trans_ID, c4))),
    conclusion(has(Utt, top_phrase, Struct_ID, State))).

fif(and(started(Action, act15, Trans_ID),
    and(has(Utt, generation_structure, Trans_ID, Struct_ID),
       has(Utt, top_phrase, Struct_ID, Top_ID))),
conclusion(end(Action, Top_ID))).




/*----------------------------------------------------------------------------*/
/**********************

Action 16 : Linearize command tree

********************/


fif(and(begin(Action, Top_ID),
       has(token, act16, Action)),
conclusion(started(Action, act16, Top_ID))).



/*Linerizing command tree*/

/*start at the S node*/
fif(and(started(Action, act16, Top_ID),
       and(start_building_domain_structure(Utt),
          and(second_generation_complete(Utt),
                 and(notify_user(Utt, begin_linearization),
                   domain_parse_state(Utt, Top_ID, start, [s], [], _, [], _, _, _, done, _))))),
conclusion(start_domain_command_linearization(Utt, Top_ID, [], []))).

/*Is not a terminal node, has only one daughter*/
fif(and(start_domain_command_linearization(Utt, State, Branch_history, Command_list),
	and(eval_bound(\+ pos_int(isa(Utt, terminal_phrase, State)),[Utt, State]),
	    and(has(Utt, leftwall, State, Leftwall),
		and(has(Utt, daughter, State, Daughter),
		    and(has(Utt, successor, Leftwall, Daughter),
			eval_bound(\+ pos_int_u(has(Utt, successor, Daughter, Next_daughter)),[Utt, Daughter])))))),
conclusion(start_domain_command_linearization(Utt, Daughter, Branch_history, Command_list))).

/*Is not a terminal node, has two daughters*/
fif(and(start_domain_command_linearization(Utt, State, Branch_history, Command_list),
	and(eval_bound(\+ pos_int(isa(Utt, terminal_phrase, State)),[Utt, State]),
	    and(has(Utt, leftwall, State, Leftwall),
		and(has(Utt, daughter, State, Daughter),
		    and(has(Utt, successor, Leftwall, Daughter),
			and(has(Utt, successor, Daughter, Next_daughter),
			    eval_bound(append([Next_daughter], Branch_history, New_branch_history),[Next_daughter, Branch_history]))))))) ,
conclusion(start_domain_command_linearization(Utt, Daughter, New_branch_history, Command_list))).

/*Is a terminal node, has branch history*/
fif(and(start_domain_command_linearization(Utt, State, [First_branch_history | Rest_branch_history], Command_list),
	and(isa(Utt, terminal_phrase, State),
	   and(isa(Utt, TokenID, State),
              and(has(Utt, token, LexID, TokenID),
		    and(eval_bound(append(Command_list, [TokenID], New_command_list),[Command_list, TokenID]),			
			eval_bound(is_not_empty([First_branch_history]), [First_branch_history])))))),
conclusion(start_domain_command_linearization(Utt, First_branch_history, Rest_branch_history, New_command_list))).

/*Is a terminal node, has empty branch history*/
fif(and(start_domain_command_linearization(Utt, State, [], Command_list),
	and(isa(Utt, terminal_phrase, State),
	   and(isa(Utt, TokenID, State),
              and(has(Utt, token, LexID, TokenID),
		 eval_bound(append(Command_list, [TokenID], New_command_list),[Command_list, TokenID]))))),
conclusion(domain_command_linearization_done(Utt, New_command_list))).

/*final build string process: find domain words, get string values,
  create command string, do funkiness for 'moveto'.*/

fif(domain_command_linearization_done(Utt, Command_list),
conclusion(domain_string_build(Utt, Command_list))).

/*Start rule: get domain lexeme for first member of command list.
  Then call the main loop.*/
fif(and(domain_string_build(Utt, [First_command | Rest_command]),
	and(has(Utt, token, Domainlex, First_command), 
	and(isa(Domainlex, string, String_ID),
	has(DomainLex, string_value, String_ID, String)))),
	conclusion(domain_string_build_loop(Utt, Rest_command, String))).

/*Generic build loop for the string of the domain commands.*/
fif(and(domain_string_build_loop(Utt, [Next_command | Rest_command], String),
	and(eval_bound(cappend_string(String, ' ', Spaced_string), [String]),
	and(has(Utt, token, Domainlex, Next_command), 
	and(isa(Domainlex, string, String_ID),
	and(has(Domainlex, string_value, String_ID, Next_string),
	and(eval_bound(\+ pos_int(has(Domainlex, string_value, String_ID, 'moveto')),[Domainlex, String_ID]),
	eval_bound(cappend_string(Spaced_string, Next_string, New_string),[Spaced_string, Next_string]))))))),
	conclusion(domain_string_build_loop(Utt, Rest_command, New_string))).
	
/*This checks the case of the string being "moveto" with "loc" and number following.*/
/*fif(and(domain_string_build_loop(Utt, [Next_command | [Rest_command | [Rest_rest_command | Rest_rest_rest_commmand]]], String),
        and(eval_bound(is_not_empty(Rest_rest_rest_command),[Rest_rest_rest_command]),
	and(eval_bound(cappend_string(String, ' ', Spaced_string), [String]),
	and(has(Utt, intended_domain, Utt, Domain),
	and(has(dlex24, content, dlex24, Next_command), 
	and(eval_bound(cappend_string(Spaced_string, 'moveto(', New_string), [Spaced_string]),
	and(has(Domainlex, content, Domainlex, Rest_rest_command),
	and(has(Domainlex, string_value, String_ID, Num_string),
	and(eval_bound(cappend_string(New_string, Num_string, Newest_string),[New_string, Num_string]),
	eval_bound(cappend_string(Newest_string, ')', Final_string),[Newest_string])))))))))),
	conclusion(domain_string_build_loop(Utt, Rest_rest_rest_command, Final_string))).
*/

fif(and(domain_string_build_loop(Utt, [Next_command | [Rest_command | [Rest_rest_command | Rest_rest_rest_command]]], String),
        and(eval_bound(is_empty(Rest_rest_rest_command),[Rest_rest_rest_command]),
	and(eval_bound(cappend_string(String, ' ', Spaced_string), [String]),
	and(has(dlex24, content, dlex24, Next_command),
	and(eval_bound(cappend_string(Spaced_string, 'moveto(', New_string), [Spaced_string]),
	and(has(Domainlex, content, Domainlex, Rest_rest_command),
	and(has(Domainlex, lexeme, Domain, Domainlex), 
	and(has(Domainlex, string_value, String_ID, Num_string),
	and(eval_bound(cappend_string(New_string, Num_string, Newest_string),[New_string, Num_string]),
	eval_bound(cappend_string(Newest_string, ')', Final_string),[Newest_string])))))))))),
conclusion(domain_string_built(Utt, Final_string))).

/*Stop condition: when command list is empty, the command string has been
  built (String).*/
fif(domain_string_build_loop(Utt, [], String),
conclusion(domain_string_built(Utt, String))).

fif(domain_string_built(Utt, String),
conclusion(notify_user(Utt, command_string_done, String))).

fif(domain_string_built(Utt, String),
conclusion(notify_user(Utt, command_string_done, String))).


/*Extra meanings*/
/*Meaning for '&'.*/
isa(888, meaning, 888).
isa(888, connector, 888).


fif(and(domain_string_built(Utt, String),
    and(started(Action, act16, Top_ID),
       and(has(Utt, generation_structure, Trans_ID, Struct_ID),
          has(Utt, top_phrase, Struct_ID, Top_ID)))),
conclusion(end(Action, Top_ID))).



/******************

Action 17 : Send command


*******************/

/*Code by Shomir for sending string to socket (found in config file linalfred/etc/domainhost.USERNAME)*/
/*
fif(and(command_string_ready(Utt, Command_string),
	eval_bound(domain_tag(MySocket),[])),
  conclusion(send_to_domain(Utt, MySocket, Command_string))).

fif(and(send_to_domain(Utt, MySocket, Command_string),
	eval_bound(sending_to_domain(MySocket, Command_string), [MySocket, Command_string])),
  conclusion(sent_command_string(Utt))).

fif(sent_command_string(Utt),
conclusion(notify_user(Utt, command_string_sent))).

fif(sent_command_string(Utt),
  conclusion(isa(Utt, done_utterance))).

fif(sent_command_string(Utt),
  conclusion(eval_bound(df(isa(Utt, current_utterance)), [Utt]))).

*/
