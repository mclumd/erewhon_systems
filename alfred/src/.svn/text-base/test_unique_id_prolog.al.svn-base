/*Scott Fults: tests unique_id, which can be
  used in the SAME step to create a unique number.*/

/*NOT useful; calls can only occur in the consequent of
  rules.*/


a(test_a).
b(test_b).


/*Test to see if it can be called once.  YES.*/
/*fif(and(a(X),
        eval_bound(unique_id([ID]),[])),
conclusion(a(X,ID))).
*/

/*test to see if it can be called one after another,
  with a step between.  Yes.*/
/*
/*fif(and(a(X, Y),
        eval_bound(unique_id([ID]),[])),
conclusion(a(X, Y, ID))).
*/


/*test to see if it can be called twice in same
  step.  YES.*/
fif(and(b(X),
        eval_bound(unique_id([ID]),[])),
conclusion(b(X,ID))).


/*Tests to see if call unique_id can create more than
  one ID on the same call.*/


fif(and(b(X),
        eval_bound(unique_id([ID1, ID2, ID3]),[])),
conclusion(a(X,ID1, ID2, ID3))).

fif(and(a(X),
        eval_bound(unique_id([ID]),[])),
conclusion(a(X,ID))).
