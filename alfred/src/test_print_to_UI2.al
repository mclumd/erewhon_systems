/* Scott Fults */

/*prints to carne screen*/
fif(and(isa(Utt, new_utterance),
	has(Utt, ascii_string, String)),
    conclusion(call(ac_print_to_screen(String),[String]))).


