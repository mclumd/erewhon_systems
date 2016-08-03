/*Template for adding a domain to Alfred.*/
/*Step 1: Replace "domainID_" with the new domain ID.*/
/*Step 2: Replace "languageID_" with the new domain language ID.*/
/*Step 3: Make Categories -
          Make a list of every terminal element's category_name.
          Create a category ID number for each category_name.
          Copy the "Make category" text below once for each
              category ID and name pair, inserting the new ID 
              and new name_ into each copy.*/
/*Step 4: Lexical Entry -
          Works for both English and Domain language.
          A) For each new lexeme, make/find:
                        lexemeID_
                        domainID_ (English or domain)
                        string_value_ (the actual string value of the word)
                        meaningID_ 
                        meaning_type_ (predicate, constant, or relation)
          B) make copies of "Lexical Entry" text for each lexeme, inserting
             IDs, etc.*/
/*Step 5: Phrase Structure Rules:
          Currently two different sets of rule templates because of a 
          predicate name difference.
          A) for each new PS rule, make/find:
                        languageID_
                        ruleID_
                        X (symbol on left hand side of rule)
                        Y (symbols on right hand side of rule in a list)*/
/*Step 6: DAGs
          */

/*Planesh*/

/*Begin copy for insertion into main.al*/
/* Uses d3~d4*/
/*Build a domain.*/
isa(null, domain, d4).

/*Build a language.*/
isa(d4, language, d3).
has(d4, language, d4, d3).
isa(d3, planesh, d3).

/*Make categories*/
/*Uses d5 ~ d17*/
has(d3, d3, cat_type, category).

isa(d3, category, d5).
has(d3, category, d3, d5).
isa(d3, planeid, d5).

isa(d3, category, d6).
has(d3, category, d3, d6).
isa(d3, statusid, d6).

isa(d3, category, d7).
has(d3, category, d3, d7).
isa(d3, approachpathid, d7).

isa(d3, category, d8).
has(d3, category, d3, d8).
isa(d3, radius, d8).

isa(d3, category, d9).
has(d3, category, d3, d9).
isa(d3, height, d9).

isa(d3, category, d10).
has(d3, category, d3, d10).
isa(d3, number, d10).

isa(d3, category, d11).
has(d3, category, d3, d11).
isa(d3, parameter, d11).

isa(d3, category, d12).
has(d3, category, d3, d12).
isa(d3, radar, d12).

isa(d3, category, d13).
has(d3, category, d3, d13).
isa(d3, approach, d13).

isa(d3, category, d14).
has(d3, category, d3, d14).
isa(d3, status, d14).

isa(d3, category, d15).
has(d3, category, d3, d15).
isa(d3, grammar, d15).

isa(d3, category, d16).
has(d3, category, d3, d16).
isa(d3, velocity, d16).

isa(d3, category, d17).
has(d3, category, d3, d17).
isa(d3, command, d17).


/*Lexical Entry*/
/*Planesh and English*/

/*Uses:
         means1 ~ means16
         lex1 ~ lex19
         plex1 ~ plex16
*/

/*---- Predicates ----*/
/*report*/
do_add_lexeme(lex1, c2, report, pos1, means1, predicate).
do_add_lexeme(plex1, d3, report, d17, means1, predicate).
 
/*circle*/
do_add_lexeme(lex2, c2, circle, pos1, means2, predicate).
do_add_lexeme(plex2, d3, circle, d17, means2, predicate).

/*move*/
do_add_lexeme(lex3, c2, move, pos1, means3, predicate).
do_add_lexeme(plex3, d3, move, d17, means3, predicate).

/*disconnect*/
do_add_lexeme(lex4, c2, disconnect, pos1, means4, predicate).
do_add_lexeme(plex4, d3, disconnect, d17, means4, predicate).

/*increase*/
do_add_lexeme(lex5, c2, increase, pos1, means5, predicate).
do_add_lexeme(plex5, d3, increase, d17, means5, predicate).

/*decrease*/
do_add_lexeme(lex6, c2, decrease, pos1, means6, predicate).
do_add_lexeme(plex6, d3, decrease, d17, means6, predicate).

/*close*/
do_add_lexeme(lex7, c2, close, pos1, means7, predicate).
do_add_lexeme(plex7, d3, close, d17, means7, predicate).

/*land*/
do_add_lexeme(lex8, c2, land, pos1, means8, predicate).
do_add_lexeme(plex8, d3, land, d17, means8, predicate).

/*---- Relations ----*/
/*do_add_lexeme()*/

/*---- Constants ----*/

/*Plane IDs*/
do_add_lexeme(lex9, c2, p33, pos3, means9, constant).
do_add_lexeme(plex9, d3, p33, d5, means9, constant).

do_add_lexeme(lex10, c2, p44, pos3, means10, constant).
do_add_lexeme(plex10, d3, p44, d5, means10, constant).

/*Status IDs*/
do_add_lexeme(lex11, c2, s88, pos3, means11, constant).
do_add_lexeme(plex11, d3, s88, d6, means11, constant).

do_add_lexeme(lex12, c2, s99, pos3, means12, constant).
do_add_lexeme(plex12, d3, s99, d6, means12, constant).

/*Approach Path IDs*/
do_add_lexeme(lex13, c2, a17, pos3, means13, constant).
do_add_lexeme(plex13, d3, a17, d7, means13, constant).

do_add_lexeme(lex14, c2, a16, pos3, means14, constant).
do_add_lexeme(plex14, d3, a16, d7, means14, constant).


/*Domain phrase structure rules.*/
/*S -> CP*/
isa(d3, domain_syntax_rule, dsp20).
has(d3, domain_syntax_rule, d3, dsp20).
has(d3, left_hand_side, dsp20, s).
has(d3, right_hand_side, dsp20, [cp]).

/*CP -> C.PID*/
isa(d3, domain_syntax_rule, dsp21).
has(d3, domain_syntax_rule, d3, dsp21).
has(d3, left_hand_side, dsp21, cp).
has(d3, right_hand_side, dsp21, [c, pid]).

/*CP -> C.AID*/
isa(d3, domain_syntax_rule, dsp22).
has(d3, domain_syntax_rule, d3, dsp22).
has(d3, left_hand_side, dsp22, cp).
has(d3, right_hand_side, dsp20, [c, aid]).

/*CP -> C.ALL*/
isa(d3, domain_syntax_rule, dsp23).
has(d3, domain_syntax_rule, d3, dsp23).
has(d3, left_hand_side, dsp23, cp).
has(d3, right_hand_side, dsp23, [c, all]).

/*CP -> C.DIRECTION*/
isa(d3, domain_syntax_rule, dsp24).
has(d3, domain_syntax_rule, d3, dsp24).
has(d3, left_hand_side, dsp24, cp).
has(d3, right_hand_side, dsp24, [c, direction]).

/*CP -> CP.RP*/
isa(d3, domain_syntax_rule, dsp25).
has(d3, domain_syntax_rule, d3, dsp25).
has(d3, left_hand_side, dsp25, cp).
has(d3, right_hand_side, dsp25, [cp, rp]).

/*CP -> CP.HP*/
isa(d3, domain_syntax_rule, dsp26).
has(d3, domain_syntax_rule, d3, dsp26).
has(d3, left_hand_side, dsp26, cp).
has(d3, right_hand_side, dsp26, [cp, hp]).

/*RP -> RADIUS_NUM*/
isa(d3, domain_syntax_rule, dsp27).
has(d3, domain_syntax_rule, d3, dsp27).
has(d3, left_hand_side, dsp27, rp).
has(d3, right_hand_side, dsp27, [radius_num]).

/*HP -> HEIGHT_NUM*/
isa(d3, domain_syntax_rule, dsp28).
has(d3, domain_syntax_rule, d3, dsp28).
has(d3, left_hand_side, dsp28, hp).
has(d3, right_hand_side, dsp28, [height_num]).

/*CP -> C.ParaP*/
isa(d3, domain_syntax_rule, dsp29).
has(d3, domain_syntax_rule, d3, dsp29).
has(d3, left_hand_side, dsp29, cp).
has(d3, right_hand_side, dsp29, [c, parap]).

/*ParaP -> Para.ID*/
isa(d3, domain_syntax_rule, dsp30).
has(d3, domain_syntax_rule, d3, dsp30).
has(d3, left_hand_side, dsp30, parap).
has(d3, right_hand_side, dsp30, [para, id]).

/*CP -> C.speed.PID.spP*/
isa(d3, domain_syntax_rule, dsp31).
has(d3, domain_syntax_rule, d3, dsp31).
has(d3, left_hand_side, dsp31, cp).
has(d3, right_hand_side, dsp31, [c, speed, pid, spp]).

/*spP -> xv.yv.zv*/
isa(d3, domain_syntax_rule, dsp32).
has(d3, domain_syntax_rule, d3, dsp32).
has(d3, left_hand_side, dsp32, spp).
has(d3, right_hand_side, dsp32, [xv, yv, zv]).

/*CP -> C.PIP*/
isa(d3, domain_syntax_rule, dsp33).
has(d3, domain_syntax_rule, d3, dsp33).
has(d3, left_hand_side, dsp33, cp).
has(d3, right_hand_side, dsp33, [c, pip]).

/*PIP -> Planeids*/
isa(d3, domain_syntax_rule, dsp34).
has(d3, domain_syntax_rule, d3, dsp34).
has(d3, left_hand_side, dsp34, pip).
has(d3, right_hand_side, dsp34, [planeids]).

/*PIP -> PIP.RadiusP*/
isa(d3, domain_syntax_rule, dsp35).
has(d3, domain_syntax_rule, d3, dsp35).
has(d3, left_hand_side, dsp35, pip).
has(d3, right_hand_side, dsp35, [pip, radiusp]).

/*PIP -> PIP.AppP*/
isa(d3, domain_syntax_rule, dsp36).
has(d3, domain_syntax_rule, d3, dsp36).
has(d3, left_hand_side, dsp36, pip).
has(d3, right_hand_side, dsp36, [pip, appp]).

/*PIP -> PIP.StatusP*/
isa(d3, domain_syntax_rule, dsp37).
has(d3, domain_syntax_rule, d3, dsp37).
has(d3, left_hand_side, dsp37, pip).
has(d3, right_hand_side, dsp37, [pip, statusp]).

/*StatusP -> Status*/
isa(d3, domain_syntax_rule, dsp38).
has(d3, domain_syntax_rule, d3, dsp38).
has(d3, left_hand_side, dsp38, statusp).
has(d3, right_hand_side, dsp38, [status]).

/*CP -> C.grammar*/
isa(d3, domain_syntax_rule, dsp39).
has(d3, domain_syntax_rule, d3, dsp39).
has(d3, left_hand_side, dsp39, cp).
has(d3, right_hand_side, dsp39, [c, grammar]).

/*CP -> C.approachids*/
isa(d3, domain_syntax_rule, dsp40).
has(d3, domain_syntax_rule, d3, dsp40).
has(d3, left_hand_side, dsp40, cp).
has(d3, right_hand_side, dsp40, [c, approachids]).

/*CP -> C.spP*/
isa(d3, domain_syntax_rule, dsp41).
has(d3, domain_syntax_rule, d3, dsp41).
has(d3, left_hand_side, dsp41, cp).
has(d3, right_hand_side, dsp41, [c, spp]).

/*spP -> speedz.VelP*/
isa(d3, domain_syntax_rule, dsp42).
has(d3, domain_syntax_rule, d3, dsp42).
has(d3, left_hand_side, dsp42, spp).
has(d3, right_hand_side, dsp42, [speedz, VelP]).

/*VelP -> PID.Vel*/
isa(d3, domain_syntax_rule, dsp43).
has(d3, domain_syntax_rule, d3, dsp43).
has(d3, left_hand_side, dsp43, velp).
has(d3, right_hand_side, dsp43, [pid, vel]).


/*English*/
/*Categories (Parst of Speech, besides N, V, P)*/



/*Phrase Structure Rules*/
/*English phrase structure rules.*/

/*S --> VP*/
isa(c2, cfg_rule, c4).
has(c2, cfg_rule, c2, c4).
has(c2, left_hand_side, c4, s).
has(c2, right_hand_side, c4, [vp]).

/*VP --> V.NP*/
isa(c2, cfg_rule, c5).
has(c2, cfg_rule, c2, c5).
has(c2, left_hand_side, c5, vp).
has(c2, right_hand_side, c5, [v, np]).

/*NP --> N*/
isa(c2, cfg_rule, c6).
has(c2, cfg_rule, c2, c6).
has(c2, left_hand_side, c6, np).
has(c2, right_hand_side, c6, [n]).

/*3DNumP --> Num.Num.Num*/
isa(c2, cfg_rule, c7).
has(c2, cfg_rule, c2, c7).
has(c2, left_hand_side, c7, 3dnump).
has(c2, right_hand_side, c7, [num, num, num]).

/*NP --> NP.PP*/
isa(c2, cfg_rule, c8).
has(c2, cfg_rule, c2, c8).
has(c2, left_hand_side, c8, np).
has(c2, right_hand_side, c8, [np, pp]).

/*PP --> P.NP*/
isa(c2, cfg_rule, c9).
has(c2, cfg_rule, c2, c9).
has(c2, left_hand_side, c9, pp).
has(c2, right_hand_side, c9, [p, np]).

/*NP --> N.PP*/
isa(c2, cfg_rule, c10).
has(c2, cfg_rule, c2, c10).
has(c2, left_hand_side, c10, np).
has(c2, right_hand_side, c10, [n, pp]).

/*VP --> V.NP.PP*/
isa(c2, cfg_rule, c11).
has(c2, cfg_rule, c2, c11).
has(c2, left_hand_side, c11, vp).
has(c2, right_hand_side, c11, [v, np, pp]).

/*NP --> N.Num*/
isa(c2, cfg_rule, c12).
has(c2, cfg_rule, c2, c12).
has(c2, left_hand_side, c12, np).
has(c2, right_hand_side, c12, [n, num]).

/*End copy for insertion into main.al*/

/*Begin copy for insertion into dag_asserter.pl*/


/*End copy for insertion into dag_asserter.pl*/
