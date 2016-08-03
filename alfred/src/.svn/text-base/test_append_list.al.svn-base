/*Scott Fults: test append list routine for when
  one of the lists is empty.*/

test_lists([], [a], [a,b],[a,b,c]).

fif(and(test_lists(First, Second, Third, Fourth),
    eval_bound(append(First, Second, Test1),[First, Second])),
conclusion(finished1(Test1))).

fif(and(test_lists(First, Second, Third, Fourth),
    eval_bound(append(Second, Third, Test2),[Second, Third])),
conclusion(finished2(Test2))).

fif(and(test_lists(First, Second, Third, Fourth),
    eval_bound(append(Third, Fourth, Test3),[Third, Fourth])),
conclusion(finished3(Test3))).

