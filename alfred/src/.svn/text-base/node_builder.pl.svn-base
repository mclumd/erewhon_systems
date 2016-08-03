
create_S_node(Utt, State) :-
    af(isa(Utt, phrase, State)),
    af(isa(Utt, s, State)),
    af(isa(Utt, tree_state, State)).

create_first_node(Utt, State, LW_State, Mother_State) :-
    af(isa(Utt, leftwall, LW_State)),
    af(has(Utt, leftwall, Mother_State, LW_State)),
    af(has(Utt, successor, LW_State, State)),
    af(isa(Utt, tree_state, State)).

create_node(Utt, State, Predecessor_State, Mother_State, Value) :-
    af(isa(Utt, phrase, State)),
    af(isa(Utt, Value, State)),
    af(has(Utt, daughter, Mother_State, State)),
    af(has(Utt, successor, Predecessor_State, State)),
    af(isa(Utt, tree_state, State)).

create_terminal_node(Utt, State, LW_State, Mother_State, Value) :-
    af(isa(Utt, leftwall, LW_State)),
    af(has(Utt, leftwall, Mother_State, LW_State)),
    af(has(Utt, successor, LW_State, State)),
    af(isa(Utt, terminal_phrase, State)),
    af(isa(Utt, Value, State)),
    af(has(Utt, daughter, Mother_State, State)).
