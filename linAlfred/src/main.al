/* Scott Fults */

/*english is a language*/
isa(c2, language, c2).
isa(c2, english, c2).


/*create an alphabet that is related to english (c2)*/
isa(c1, alphabet, c1).
has(c2, alphabet, c2, c1).

/*populate alphabet with the letters t, u, r, n*/
isa(c1, alpha14, letter).
has(c1, member, c1, alpha14).
has(c1, ascii_code, alpha14, 110).

isa(c1, alpha18, letter).
has(c1, member, c1, alpha18).
has(c1, ascii_code, alpha18, 114).

isa(c1, alpha20, letter).
has(c1, member, c1, alpha20).
has(c1, ascii_code, alpha20, 116).

isa(c1, alpha21, letter).
has(c1, member, c1, alpha21).
has(c1, ascii_code, alpha21, 117).

/*If there is a new utterance and there are no current utterances,
make it current and not new.*/

fif(and(isa(Utt,new_utterance),
    eval_bound(\+ pos_int(isa(Utt, current_utterance)), [Utt])),
conclusion(isa(Utt,current_utterance))).

fif(isa(Utt,current_utterance),
  conclusion(eval_bound(df(isa(Utt, new_utterance)), [Utt]))).

/*Tokenize all current utterances into words and letters.*/

fif(and(isa(Utt, current_utterance),
	has(Utt, ascii_string, Sp)),
  conclusion(call(ac_token_utt(Utt, Sp), [Utt,Sp]))).

/*match utterance letters to conceptual alphabet*/

/*This works, notice "c1" is the exact value found above.*/

fif(and(isa(Utt, current_utterance),
	and(isa(Utt, spelling, Sp),
	    and(has(Utt, letter, Sp, Ltr1),
		and(has(Utt, ascii_code, Ltr1, Acode1),
		    and(isa(c1, alphabet, Alphabet),
			and(has(c1, member, Alphabet, Ltr2),
			    and(has(c1, ascii_code, Ltr2, Acode2),
				eval_bound(equal_numbers(Acode1,Acode2),[Acode1,Acode2])))))))),
    conclusion(has(Utt, token, Ltr2, Ltr1))).

/*This one doesn't work, "c1" has been replaced with the variable "C".
This should unify with "c1", but it does not appear to be doing so.*/
/*
fif(and(isa(Utt, current_utterance),
	and(isa(Utt, spelling, Sp),
	    and(has(Utt, letter, Sp, Ltr1),
		and(has(Utt, ascii_code, Ltr1, Acode1),
		    and(isa(C, alphabet, Alphabet),
			and(has(C, member, Alphabet, Ltr2),
			    and(has(C, ascii_code, Ltr2, Acode2),
				eval_bound(equal_numbers(Acode1,Acode2),[Acode1,Acode2])))))))),
    conclusion(has(Utt, token, Ltr2, Ltr1))).
*/


