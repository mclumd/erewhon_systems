
track(grnblt, cp).


track(cp, pgp).
track(pgp, wh).
track(wh, ft).
track(ft, cua).
track(cua, ria).
track(ria, us).
track(us, js).
track(js, gp).


track(ft, usc).
track(usc, gp).

forall(X, forall(Y, forall(Z, bif( 
				and(track(X, Y), track(Y, Z)),
				track(X, Z))))).


bs(track(grnblt, gp)).
