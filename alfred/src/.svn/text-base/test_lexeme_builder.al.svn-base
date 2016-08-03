/* Scott Fults */

/*Set initial values.*/
curMaxUniqueID(1).

if(eval_bound(unique_id([ID1]),[]),
    test(ID1)).

needs_lexeme(verb, turn).


fif(and(test(ID1),
	needs_lexeme(PoS, Lex)),
    conclusion(call(ac_lexeme_builder(ID1, PoS, Lex), [ID1, PoS, Lex]))).



