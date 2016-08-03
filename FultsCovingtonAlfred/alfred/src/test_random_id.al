/*Scott Fults: produces a randome number.*/

start(true).

fif(and(start(true),
        eval_bound(randomID(X),[])),
    conclusion(test(X))).
