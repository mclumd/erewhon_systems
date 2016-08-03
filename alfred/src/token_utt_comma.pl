
token_utt_comma(Utt, Sp, Last_queue, Last_dialog) :-
    Current is 1,
    fill_sentence(Utt, Current, [], Sp, Last_queue, Last_dialog).



fill_sentence(Utt, Current, Z, [X|Y], Last_queue, Last_dialog) :-
    X == 44, /*44 = comma*/
    assert_sentence(Utt, Current, Z, Last_queue, Last_dialog),
    NewCurrent is Current + 1,
    fill_sentence(Utt, NewCurrent, [], Y, Last_queue, Last_dialog).

fill_sentence(Utt, Current, Z, [X|Y], Last_queue, Last_dialog) :-
    X == 46, /*46 = period*/
    assert_sentence(Utt, Current, Z, Last_queue, Last_dialog),
    NewCurrent is Current + 1,
    fill_sentence(Utt, NewCurrent, [], Y, Last_queue, Last_dialog).

fill_sentence(Utt, Current, Z, [], Last_queue, Last_dialog) :-
    assert_sentence(Utt, Current, Z, Last_queue, Last_dialog),
    af(done_token_utt_comma(Utt)).

fill_sentence(Utt, Current, Z, [X|Y], Last_queue, Last_dialog) :-
    append(Z, [X], W),
    fill_sentence(Utt, Current, W, Y, Last_queue, Last_dialog).

assert_sentence(Utt, Current, Z, Last_queue, Last_dialog) :-
    concat(Utt, Current, New_utt),
    df(isa(Utt, new_utterance)),
    af(isa(Utt, utterance, New_utt)),
    af(has(New_utt, ascii_string, New_utt, Z)),
    af(has(dia1, member, alf1, New_utt)),
    df(has(dia1, successor, Last_dialog, alf3)),
    af(has(dia1, successor, Last_dialog, New_utt)),
    af(has(dia1, successor, New_utt, alf3)),
    af(has(dia1, member, alf4, New_utt)),
    df(has(dia1, successor, Last_queue, alf6)),
    af(has(dia1, successor, Last_queue, New_utt)),
    af(has(dia1, successor, New_utt, alf6)).

