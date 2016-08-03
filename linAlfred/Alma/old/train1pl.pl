track(X, Z, XZ) :- track(X, Y, XY), track(Y, Z, YZ),
    append(XY, YZ, XZ).


track(cp, pgp, [cp, pgp]).
track(js, gp, [js, gp]).
track(us, js, [us, js]).
track(pgp, wh, [pgp, wh]).
track(wh, ft, [wh, ft]).
track(grnblt, cp, [grnblt, cp]).
track(ft, cua, [ft, cua]).
track(cua, ria, [cua, ria]).
track(ria, us, [ria, us]).
track(ft, usc, [ft, usc]).
track(usc, gp, [usc, gp]).


