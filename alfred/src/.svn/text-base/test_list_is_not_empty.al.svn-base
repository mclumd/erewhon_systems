/*Scott and Wikum: tests the routine is_not_empty(A), where A is a list.
  Returns true if A is a non-empty list.*/

test_list1([a, b, c]).
test_list2([]).

fif(and(test_list1(List),
        eval_bound(is_not_empty(List),[List])),
conclusion(not_empty(List))).

fif(and(test_list2(List),
        eval_bound(is_not_empty(List),[List])),
conclusion(not_empty(List))).








