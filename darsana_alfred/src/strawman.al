/* Scott Fults */

fif(and(isa(Utt,new_utterance),
    eval_bound(\+ pos_int(isa(Utt, current_utterance)), [Utt])),
conclusion(isa(Utt,current_utterance))).

fif(isa(Utt,current_utterance),
  conclusion(eval_bound(df(isa(Utt, new_utterance)), [Utt]))).

fif(and(isa(Utt, current_utterance),
	has(Utt,ascii_string,Sp)),
  conclusion(call(ac_token_utt(Utt, Sp), [Utt,Sp]))).


