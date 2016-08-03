list([a, b, c]).
list([]).
fif(and(list(L),
	eval_bound(is_empty(L),[L])),
conclusion(list_is_empty(L))).

fif(and(list(L),
	eval_bound(is_not_empty(L),[L])),
conclusion(list_is_NOT_empty(L))).
