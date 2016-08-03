
create_predicate(Utt, MeaningID, PhraseID) :-
    concat_atom([lf, PhraseID], NewID),
    concat_atom([var, NewID], TempID),
    concat_atom([TempID, Utt], VarID),
    af(isa(Utt, lf_phrase, NewID)),
    af(isa(Utt, predicate, NewID)),
    af(has(Utt, token, MeaningID, NewID)),
    af(has(Utt, semantic_value, PhraseID, NewID)),
    af(isa(Utt, variable, VarID)),
    af(isa(Utt, VarID, NewID)).

create_constant(Utt, MeaningID, PhraseID) :-
    concat_atom([lf, PhraseID], NewID),
    concat_atom([var1, NewID], VarID),
    af(isa(Utt, lf_phrase, NewID)),
    af(isa(Utt, constant, NewID)),
    af(has(Utt, token, MeaningID, NewID)),
    af(has(Utt, semantic_value, PhraseID, NewID)),
    af(isa(Utt, variable, VarID)),
    af(isa(Utt, VarID, NewID)).

create_relation(Utt, MeaningID, PhraseID) :-
    concat_atom([lf, PhraseID], NewID),
    concat_atom([var1, NewID], Temp1ID),
    concat_atom([Temp1ID, Utt], VarID1),
    concat_atom([var2, NewID], Temp2ID),
    concat_atom([Temp2ID, Utt], VarID2),
    af(isa(Utt, lf_phrase, NewID)),
    af(isa(Utt, relation, NewID)),
    af(has(Utt, token, MeaningID, NewID)),
    af(has(Utt, semantic_value, PhraseID, NewID)),
    af(isa(Utt, variable, VarID1)),
    af(isa(Utt, variable, VarID2)),
    af(has(Utt, inner_argument, NewID, VarID1)),
    af(has(Utt, outer_argument, NewID, VarID2)),
    af(isa(Utt, location, VarID1)),
    af(has(Utt, location, VarID2, VarID1)),
    af(isa(Utt, event, VarID2)).
