/*Scott*/
/*
Lexeme speller: takes lexeme string and asserts letters
that spell it.
*/

lexeme_speller(LexID, Word) :-
    concat_atom([LexID, sp], LexSpID),
    af(isa(LexID, spelling, LexSpID)),
    af(has(LexID, spelling, LexID, LexSpID)),
    LtrNum is 0,
    concat_atom([LexID, ltr, LtrNum], LexLtrID),
    af(has(LexID, leftwall, LexSpID, LexLtrID)),
    atom_chars(Word, Lexeme_list),
    assertLexemeLetters(LexID, LexSpID,  LexLtrID, LtrNum, Lexeme_list).

assertLexemeLetters(_, _, _, _, []).

assertLexemeLetters(LexID, LexSpID, PrevLexLtrID, PrevLtrNum, [First|Rem]) :-
    LtrNum is PrevLtrNum+1,
    concat_atom([LexID, ltr, LtrNum], LexLtrID),
    af(isa(LexID, letter, LexLtrID)),
    af(has(LexID, letter, LexSpID, LexLtrID)),
    af(has(LexID, successor, PrevLexLtrID, LexLtrID)),
    af(has(LexID, ascii_code, LexLtrID, First)),
    af(ready_to_link_lexeme_letter_to_alpha_or_num(LexID, LexLtrID, First)),
    !,  % adding this may have produced at most a tiny speedup -- m.c.
    assertLexemeLetters(LexID, LexSpID, LexLtrID, LtrNum, Rem).






