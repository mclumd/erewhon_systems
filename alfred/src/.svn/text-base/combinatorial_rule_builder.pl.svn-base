


rule3(Utt, PhraseNum, Daughter1_ID, Daughter2_ID, EventID, LocationID, ConstantID) :-
    concat_atom([state, PhraseNum], Temp1_ID),
    concat_atom([Temp1_ID, Utt], NewID),
    concat_atom([var, NewID], Temp2_ID),
    concat_atom([Temp2_ID, Utt], VarID),
    af(has(Utt, semantic_value, PhraseNum, NewID)),
    af(isa(Utt, lf_phrase, NewID)),
    af(has(Utt, daughter, NewID, Daughter1_ID)),
    af(has(Utt, daughter, NewID, Daughter2_ID)),
    af(isa(Utt, predicate, NewID)),
    af(isa(Utt, VarID, variable)),
    af(isa(Utt, VarID, NewID)),
    af(equals(Utt, VarID, EventID)),
    af(equals(Utt, LocationID, ConstantID)).


rule2(Utt, PhraseNum, Daughter1_ID, Daughter2_ID, EventID, PredVarID) :-
    concat_atom([state, PhraseNum], Temp1_ID),
    concat_atom([Temp1_ID, Utt], NewID),
    concat_atom([var1, NewID], Temp2_ID),
    concat_atom([Temp2_ID, Utt], Var1_ID),
    concat_atom([var2, NewID], Temp3_ID),
    concat_atom([Temp3_ID, Utt], Var2_ID),
    af(has(Utt, semantic_value, PhraseNum, NewID)),
    af(isa(Utt, lf_phrase, NewID)),
    af(has(Utt, daughter, NewID, Daughter1_ID)),
    af(has(Utt, daughter, NewID, Daughter2_ID)),
    af(isa(Utt, predicate, NewID)),
    af(isa(Utt, connector, NewID)),
    af(has(Utt, token, Var2_ID, NewID)),
    af(isa(Utt, Var1_ID, variable)),
    af(isa(Utt, Var1_ID, NewID)),
    af(equals(Utt, Var1_ID, EventID)),
    af(equals(Utt, Var1_ID, PredVarID)),
    af(isa(Utt, meaning, Var2_ID)),
    af(isa(Utt, connector, Var2_ID)).

