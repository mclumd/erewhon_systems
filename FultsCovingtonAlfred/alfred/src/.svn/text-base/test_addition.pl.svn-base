/*Scott Fults
  Tests the 'add' routine, defined in routines.pl.
  This progresses indefinitely until stopped, adding
  1 (Y) to the previous number (X).*/

x(1).
y(1).

fif(and(x(X),
        and(y(Y),
            eval_bound(add(X, Y, Z),[X,Y]))),
    conclusion(test_add(X, Y, Z))).

fif(test_add(X,Y,Z),
    conclusion(x(Z))).

