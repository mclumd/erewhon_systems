/* Alma Code to simulate a lamp that goes on and off when the power goes on/off during particular times of a day - Version 1*/

% Last updated: Darsana Purushothaman  - Oct 04 2000


fif(and(now(T),
    and(or(eval_bound((4 < T, T < 8), [T]),
	   eval_bound((20 < T, T < 24), [T])),
	power(on))),
conclusion(lamp(on))).

fif(lamp(on),
conclusion(read(possible))).

fif(not(lamp(on)),
conclusion(not(read(possible)))).

fif(and(now(T),
        eval_bound((T >= 8, 20 >= T), [T])),
conclusion(not(lamp(on)))).

fif(and(contra(X,Y,Z),
    and(eval_bound(name_to_time(X,T1), [X]),
    and(eval_bound(name_to_time(Y,T2), [Y]),
        eval_bound(( T2 > T1 -> ReForm = X; ReForm=Y), [T1,T2,X,Y])))),
conclusion(reinstate(ReForm))).

power(on).

fif(not(power(on)),
conclusion(not(lamp(on)))).

