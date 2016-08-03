
/*If generating lexeme IDs is automated, this is all we need to add:

add_lexeme(c2, recharge, pos1, meaning1, predicate).
add_lexeme(d2, charge, d9, meaning1, predicate).
*/

/*Roverese words have categories, and English words have parts of speech */
has(d2, d2, cat_type, category).
has(c2, c2, cat_type, part_of_speech).

/*Generate new lexeme ID and start the lexeme adding process*/
/*
fif(and(add_lexeme(Domain, String_Value, Cat, MeaningID, MeaningID_Type),
	get_new_ID(newID)), 
    conclusion(do_add_lexeme(LexID, Domain, String_Value, Cat, MeaningID, MeaningID_Type))).
*/

/*If we manually add lexeme IDs, we can start the process with do_add_lexeme() 
e.g. do_add_lexeme(lex1, c2, recharge, pos1, meaning1, predicate). */

/*Add meaning - these may get added twice - once with English, once with Roverese*/
fif(do_add_lexeme(LexID, Domain, String_Value, Cat, MeaningID, MeaningID_Type),
    conclusion(isa(MeaningID, meaning, MeaningID))).

fif(do_add_lexeme(LexID, Domain, String_Value, Cat, MeaningID, MeaningID_Type),
    conclusion(has(MeaningID, type, meaning, MeaningID_Type))).

/*Add lexeme*/
fif(do_add_lexeme(LexID, Domain, String_Value, Cat, MeaningID, MeaningID_Type),
    conclusion(isa(LexID, lexeme, LexID))).

fif(do_add_lexeme(LexID, Domain, String_Value, Cat, MeaningID, MeaningID_Type),
    conclusion(has(LexID, lexeme, Domain, LexID))).

/*Add category for Roverese words and part_of_speech for English words*/
fif(and(do_add_lexeme(LexID, Domain, String_Value, Cat, MeaningID, MeaningID_Type),
	has(Domain, Domain, cat_type, Cat_Type)), 
    conclusion(has(LexID, Cat_Type, LexID, Cat))).

fif(and(do_add_lexeme(LexID, Domain, String_Value, Cat, MeaningID, MeaningID_Type),
	eval_bound(cappend_string('str', LexID, LexIDStr), [LexID])),
    conclusion(isa(LexID, string, LexIDStr))).

fif(and(do_add_lexeme(LexID, Domain, String_Value, Cat, MeaningID, MeaningID_Type),
	isa(LexID, string, LexIDStr)),
    conclusion(has(LexID, string, LexID, LexIDStr))).

fif(and(do_add_lexeme(LexID, Domain, String_Value, Cat, MeaningID, MeaningID_Type),
	isa(LexID, string, LexIDStr)),
    conclusion(has(LexID, string_value, LexIDStr, String_Value))).

fif(do_add_lexeme(LexID, Domain, String_Value, Cat, MeaningID, MeaningID_Type),
    conclusion(has(LexID, content, LexID, MeaningID))).


/*
has(LexID, dag_list, String_Value, Dag).
*/
/*Associate DAGs with lexemes*/
/*
fif(and(do_add_lexeme(LexID, Domain, String_Value, Cat, MeaningID, MeaningID_Type),
	has(LexID, dag_list, String_Value, Dag)),
    conclusion(has(LexID, dag, LexID, Dag))).
*/

/* do_add_lexeme(LexID, Domain, String_Value, Cat, MeaningID, MeaningID_Type). */

/*---- Predicates ----*/

/*recharge - charge*/
do_add_lexeme(lex1, c2, recharge, pos1, meaning1, predicate).
do_add_lexeme(dlex18, d2, charge, d9, meaning1, predicate).

/*charge - charge*/
do_add_lexeme(c2, charge, pos1, meaning1, predicate).

/*move - moveto*/
do_add_lexeme(lex5, c2, move, pos1, meaning5, predicate).
do_add_lexeme(dlex24, d2, moveto, d9, meaning5, predicate).

/*go - moveto*/
do_add_lexeme(c2, go, pos1, meaning5, predicate).

/*acknowledge - ack*/
do_add_lexeme(c2, acknowledge, pos1, meaning6, predicate).
do_add_lexeme(d2, ack, d9, meaning6, predicate).

/*calibrate - cal*/
do_add_lexeme(c2, calibrate, pos1, meaning7, predicate).
do_add_lexeme(d2, cal, d9, meaning7, predicate).

/*experiment - science*/
do_add_lexeme(c2, experiment, pos1, meaning8, predicate).
do_add_lexeme(d2, science, d9, meaning8, predicate).

/*---- Relations ----*/

/*at - loc*/
do_add_lexeme(lex2, c2, at, pos2, meaning2, relation).
do_add_lexeme(dlex25, d2, loc, d7, meaning2, relation).

/*to - loc*/
do_add_lexeme(lex4, c2, to, pos2, meaning2, relation).

/*localize - loc ??? localize seems like a predicate*/
do_add_lexeme(c2, localize, pos2, meaning2, relation).

/*---- Constants ----*/

/*zero - 0*/
do_add_lexeme(c2, zero, pos3, meaning9, constant).
do_add_lexeme(d2, 0, d12, meaning9, constant).

/*one - 1*/
do_add_lexeme(c2, one, pos3, meaning10, constant).
do_add_lexeme(d2, 1, d12, meaning10, constant).

/*two - 2*/
do_add_lexeme(c2, two, pos3, meaning11, constant).
do_add_lexeme(d2, 2, d12, meaning11, constant).

/*three - 3*/
do_add_lexeme(c2, three, pos3, meaning12, constant).
do_add_lexeme(d2, 3, d12, meaning12, constant).

/*four - 4*/
do_add_lexeme(c2, four, pos3, meaning13, constant).
do_add_lexeme(d2, 4, d12, meaning13, constant).

/*five - 5*/
do_add_lexeme(c2, five, pos3, meaning14, constant).
do_add_lexeme(d2, 5, d12, meaning14, constant).

/*six - 6*/
do_add_lexeme(lex3, c2, six, pos3, meaning3, constant).
do_add_lexeme(dlex38, d2, 6, d12, meaning3, constant).

/*seven - 7*/
do_add_lexeme(c2, seven, pos3, meaning15, constant).
do_add_lexeme(d2, 7, d12, meaning15, constant).
