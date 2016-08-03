

command_String_ready(s1, 'happy happy joy joy').



fif(and(command_string_ready(Utt, Command_string),
	eval_bound(domain_tag(MySocket),[])),
  conclusion(send_to_domain(Utt, MySocket, Command_string))).

fif(and(send_to_domain(Utt, MySocket, Command_string),
	eval_bound(sending_to_domain(MySocket, Command_string), [MySocket, Command_string])),
  conclusion(sent_command_string(Utt))).



