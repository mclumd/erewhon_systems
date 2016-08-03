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
                        Y (symbols on right hand side of rule in a list)
*/


/*Begin copy for insertion into main.al*/


/*Build a domain.*/
isa(null, domain, d1).


/*Build a language.*/
isa(d1, language, d2).
has(d1, language, d1, d2).
isa(d2, roverese, d2).

/*Make categories*/
/*category_name_*/
has(d2, d2, cat_type, category).
has(c2, c2, cat_type, part_of_speech).

/*Uses ID#'s d3 - d12*/
/*relay_station_command*/
isa(d2, category, d3).
has(d2, category, d2, d3).
isa(d2, relay_station_command, d3).

/*socket_dispatch_control_command_head*/
isa(d2, category, d4).
has(d2, category, d2, d4).
isa(d2, socket_dispatch_control_command_head, d4).

/*agent_directive_head*/
isa(d2, category, d5).
has(d2, category, d2, d5).
isa(d2, agent_directive_head, d5).

/*acknowledge*/
isa(d2, category, d6).
has(d2, category, d2, d6).
isa(d2, acknowledge, d6).

/*loc*/
isa(d2, category, d7).
has(d2, category, d2, d7).
isa(d2, loc_head, d7).

/*mars_rover_rover_ugpa_controller_command_head*/
isa(d2, category, d8).
has(d2, category, d2, d8).
isa(d2, mars_rover_rover_ugpa_controller_command_head, d8).

/*mars_rover_action_head*/
isa(d2, category, d9).
has(d2, category, d2, d9).
isa(d2, mars_rover_action_head, d9).

/*time_int*/
isa(d2, category, d10).
has(d2, category, d2, d10).
isa(d2, time_int, d10).

/*science point*/
isa(d2, category, d11).
has(d2, category, d2, d11).
isa(d2, science_pt, d11).

/*way point*/
isa(d2, category, d12).
has(d2, category, d2, d12).
isa(d2, way_pt, d12).

/*Lexical Entry*/

/*---- Predicates ----*/

/*recharge - charge*/
do_add_lexeme(lex1, c2, recharge, pos1, meaning1, predicate).
do_add_lexeme(dlex18, d2, 'charge()', d9, meaning1, predicate).

/*charge - charge*/
do_add_lexeme(lex6, c2, 'charge', pos1, meaning1, predicate).

/*move - moveto*/
do_add_lexeme(lex5, c2, move, pos1, meaning5, predicate).
do_add_lexeme(dlex24, d2, moveto, d9, meaning5, predicate).

/*go - moveto*/
do_add_lexeme(lex7, c2, go, pos1, meaning5, predicate).

/*acknowledge - ack*/
do_add_lexeme(lex8, c2, acknowledge, pos1, meaning6, predicate).
do_add_lexeme(dlex13, d2, ack, d9, meaning6, predicate).

/*calibrate - cal*/
do_add_lexeme(lex9, c2, calibrate, pos1, meaning7, predicate).
do_add_lexeme(dlex22, d2, cal, d9, meaning7, predicate).

/*experiment - science*/
do_add_lexeme(lex10, c2, experiment, pos1, meaning8, predicate).
do_add_lexeme(dlex23, d2, science, d9, meaning8, predicate).

/*localize - loc*/
do_add_lexeme(lex11, c2, localize, pos1, meaning16, predicate).
do_add_lexeme(dlex19, d2, 'loc()', d9, meaning16, predicate).

/*send - xmit*/
do_add_lexeme(lex19, c2, send, pos1, meaning17, predicate).
do_add_lexeme(dlex21, d2, 'xmit()', d9, meaning17, predicate).

/*transmit - xmit*/
do_add_lexeme(lex20, c2, transmit, pos1, meaning17, predicate).

/*---- Relations ----*/

/*at - loc*/
do_add_lexeme(lex2, c2, at, pos2, meaning2, relation).
do_add_lexeme(dlex25, d2, loc, d7, meaning2, relation).

/*to - loc*/
do_add_lexeme(lex4, c2, to, pos2, meaning2, relation).


/*---- Constants ----*/

/*zero - 0*/
do_add_lexeme(lex12, c2, zero, pos3, meaning9, constant).
do_add_lexeme(dlex32, d2, '0', d12, meaning9, constant).

/*one - 1*/
do_add_lexeme(lex13, c2, one, pos3, meaning10, constant).
do_add_lexeme(dlex33, d2, '1', d12, meaning10, constant).

/*two - 2*/
do_add_lexeme(lex14, c2, two, pos3, meaning11, constant).
do_add_lexeme(dlex34, d2, '2', d12, meaning11, constant).

/*three - 3*/
do_add_lexeme(lex15, c2, three, pos3, meaning12, constant).
do_add_lexeme(dlex35, d2, '3', d12, meaning12, constant).

/*four - 4*/
do_add_lexeme(lex16, c2, four, pos3, meaning13, constant).
do_add_lexeme(dlex36, d2, '4', d12, meaning13, constant).

/*five - 5*/
do_add_lexeme(lex17, c2, five, pos3, meaning14, constant).
do_add_lexeme(dlex37, d2, '5', d12, meaning14, constant).

/*six - 6*/
do_add_lexeme(lex3, c2, six, pos3, meaning3, constant).
do_add_lexeme(dlex38, d2, '6', d12, meaning3, constant).

/*seven - 7*/
do_add_lexeme(lex18, c2, seven, pos3, meaning15, constant).
do_add_lexeme(dlex39, d2, '7', d12, meaning15, constant).

/*---- Other ----*/

do_add_lexeme(dlex7, d2, send, d4, meandlex7, event).
do_add_lexeme(dlex16, d2, goal, d8, meandlex16, event).
do_add_lexeme(dlex15, d2, action, d8, meandlex15, event).

do_add_lexeme(dlex8, d2, rover1, d5, meandlex8, entity).
do_add_lexeme(dlex9, d2, rover2, d5, meandlex9, entity).

/*Phrase structure rules.  Each rule is associated with
  a DAG found further down below.*/
/*Uses ID's d20-d35*/

/*S -> basic_dispatch_agent_command*/
isa(d2, domain_syntax_rule, dps20).
has(d2, domain_syntax_rule, d2, dps20).
has(d2, left_hand_side, dps20, s).
has(d2, right_hand_side, dps20, [basic_dispatch_agent_command]).

/*basic_dispatch_agent_command -> socket_dispatch_control_command*/
isa(d2, domain_syntax_rule, dps21).
has(d2, domain_syntax_rule, d2, dps21).
has(d2, left_hand_side, dps21, basic_dispatch_agent_command).
has(d2, right_hand_side, dps21, [socket_dispatch_control_command]).

/*socket_dispatch_control_command -> socket_dispatch_control_command_head*/
isa(d2, domain_syntax_rule, dps22).
has(d2, domain_syntax_rule, d2, dps22).
has(d2, left_hand_side, dps22, socket_dispatch_control_command).
has(d2, right_hand_side, dps22, [socket_dispatch_control_command_head]).
 
/*socket_dispatch_control_command -> socket_dispatch_control_command_head agent_directive*/
isa(d2, domain_syntax_rule, dps23).
has(d2, domain_syntax_rule, d2, dps23).
has(d2, left_hand_side, dps23, socket_dispatch_control_command).
has(d2, right_hand_side, dps23, [socket_dispatch_control_command_head, agent_directive]).

/*agent_directive -> agent_directive_head mars_rover_command*/
isa(d2, domain_syntax_rule, dps24).
has(d2, domain_syntax_rule, d2, dps24).
has(d2, left_hand_side, dps24, agent_directive).
has(d2, right_hand_side, dps24, [agent_directive_head, mars_rover_command]).

/*agent_directive -> agent_directive_head relay_station_command*/
isa(d2, domain_syntax_rule, dps25).
has(d2, domain_syntax_rule, d2, dps25).
has(d2, left_hand_side, dps25, agent_directive).
has(d2, right_hand_side, dps25, [agent_directive_head, relay_station_command]).

/*mars_rover_command -> mars_rover_rover_ugpa_controller_command*/
isa(d2, domain_syntax_rule, dps26).
has(d2, domain_syntax_rule, d2, dps26).
has(d2, left_hand_side, dps26, mars_rover_command).
has(d2, right_hand_side, dps26, [mars_rover_rover_ugpa_controller_command]).

/*mars_rover_command -> acknowledge*/
isa(d2, domain_syntax_rule, dps27).
has(d2, domain_syntax_rule, d2, dps27).
has(d2, left_hand_side, dps27, mars_rover_command).
has(d2, right_hand_side, dps27, [acknowledge]).

/*mars_rover_rover_ugpa_controller_command -> mars_rover_rover_ugpa_controller_command_head*/
isa(d2, domain_syntax_rule, dps28).
has(d2, domain_syntax_rule, d2, dps28).
has(d2, left_hand_side, dps28, mars_rover_rover_ugpa_controller_command).
has(d2, right_hand_side, dps28, [mars_rover_rover_ugpa_controller_command_head]).

/*mars_rover_rover_ugpa_controller_command -> mars_rover_rover_ugpa_controller_command_head mars_rover_action*/
isa(d2, domain_syntax_rule, dps29).
has(d2, domain_syntax_rule, d2, dps29).
has(d2, left_hand_side, dps29, mars_rover_rover_ugpa_controller_command).
has(d2, right_hand_side, dps29, [mars_rover_rover_ugpa_controller_command_head, mars_rover_action]).

/*mars_rover_rover_ugpa_controller_command -> mars_rover_rover_ugpa_controller_command loc*/
isa(d2, domain_syntax_rule, dps30).
has(d2, domain_syntax_rule, d2, dps30).
has(d2, left_hand_side, dps30, mars_rover_rover_ugpa_controller_command).
has(d2, right_hand_side, dps30, [mars_rover_rover_ugpa_controller_command, loc]).

/*mars_rover_rover_ugpa_controller_command -> mars_rover_rover_ugpa_controller_command time*/
isa(d2, domain_syntax_rule, dps31).
has(d2, domain_syntax_rule, d2, dps31).
has(d2, left_hand_side, dps31, mars_rover_rover_ugpa_controller_command).
has(d2, right_hand_side, dps31, [mars_rover_rover_ugpa_controller_command, time]).

/*time -> time_head time_int*/
isa(d2, domain_syntax_rule, dps32).
has(d2, domain_syntax_rule, d2, dps32).
has(d2, left_hand_side, dps32, time).
has(d2, right_hand_side, dps32, [time_head, time_int]).

/*loc -> loc_head way_pt*/
isa(d2, domain_syntax_rule, dps33).
has(d2, domain_syntax_rule, d2, dps33).
has(d2, left_hand_side, dps33, loc).
has(d2, right_hand_side, dps33, [loc_head, way_pt]).

/* loc -> loc_head sci_pt*/
isa(d2, domain_syntax_rule, dps34).
has(d2, domain_syntax_rule, d2, dps34).
has(d2, left_hand_side, dps34, loc).
has(d2, right_hand_side, dps34, [loc_head, sci_pt]).

/* mars_rover_action -> Mars_rover_action_head*/
isa(d2, domain_syntax_rule, dps35).
has(d2, domain_syntax_rule, d2, dps35).
has(d2, left_hand_side, dps35, mars_rover_action).
has(d2, right_hand_side, dps35, [mars_rover_action_head]).

/* mars_rover_action -> Mars_rover_action_head loc*/
isa(d2, domain_syntax_rule, dps36).
has(d2, domain_syntax_rule, d2, dps36).
has(d2, left_hand_side, dps36, mars_rover_action).
has(d2, right_hand_side, dps36, [mars_rover_action_head, loc]).

/*Context Free Grammar rules*/
/*S --> VP*/
isa(c2, cfg_rule, c4).
has(c2, cfg_rule, c2, c4).
has(c2, left_hand_side, c4, s).
has(c2, right_hand_side, c4, [vp]).

/*VP --> V*/
isa(c2, cfg_rule, c5).
has(c2, cfg_rule, c2, c5).
has(c2, left_hand_side, c5, vp).
has(c2, right_hand_side, c5, [v]).

/*VP --> VP PP*/
isa(c2, cfg_rule, c6).
has(c2, cfg_rule, c2, c6).
has(c2, left_hand_side, c6, vp).
has(c2, right_hand_side, c6, [vp, pp]).

/*PP --> P NP*/
isa(c2, cfg_rule, c7).
has(c2, cfg_rule, c2, c7).
has(c2, left_hand_side, c7, pp).
has(c2, right_hand_side, c7, [p, np]).

/*NP --> N*/
isa(c2, cfg_rule, c8).
has(c2, cfg_rule, c2, c8).
has(c2, left_hand_side, c8, np).
has(c2, right_hand_side, c8, [n]).

/*End copy for insertion into main.al*/
