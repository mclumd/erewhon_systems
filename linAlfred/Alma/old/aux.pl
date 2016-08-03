% gile aux.pl
% has auxiliary stuff. user programs and such

next(X, Y):-
    name(Y, NY),
    append(NY, NY, NNY),
    name(N, NNY),
    FF =.. [X, N],
    af(FF).


then(X):-
    df(now(X)),
    Y is X + 1,
    af(now(Y)).


    