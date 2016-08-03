/* Scott Fults */

curMaxUniqueID(1).

go(next).

go(true).

fif(and(go(X),
        eval_bound(unique_id([ID1, ID2]),[])),
  conclusion(test(X, ID1, ID2))).



/*
fif(and(go(next),
        eval_bound(unique_id([ID1, ID2]),[])),
  conclusion(test1(ID1, ID2))).

fif(and(go(true),
        eval_bound(append([]), [])),
  conclusion(test2(ID1, ID2))).
*/


/*
fif(and(go(true),
        eval_bound(unique_id([ID1, ID2]), [])),
  conclusion(test2(ID1, ID2))).
*/

/*
fif(and(test1(X, Y),
        eval_bound(unique_id([ID1, ID2]), [])),
  conclusion(test2(ID1, ID2))).
*/
