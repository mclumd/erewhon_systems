/*Scott Fults
   Backwards search testing.

   Conclusions:
       a) don't use eval_bound or alma
       b) works on RHS of fif
       c) works on LHS and RHS of plain if
       d) however, on LHS of plain if, RHS is never asserted

*/

/*set up KB with a bif rule and a fact. rule won't
  fire by itself because it is bif.

bif(p(X),q(X)).

p(test).
*/

/*Start the backwards search using bs.
  Question: can bs be used on LHS and RHS?
            can bs be used in fif or if?
*/

/*For fif, must alma be forced to step one or more times
  before the search is conducted?
   -- initial fact for step 1, then take a step by firing the next rule.

start(false).  
fif(start(false),
    conclusion(start(true))).    
*/

/*There does not need to be an initial step, so just add start
  condition.
*/
start(true).

/*bs on RHS of fif with eval bound:
    --"existence_error(bs(q(test))...)"
       but alma continues to search and makes the right assertion?!?!
fif(start(true),
    conclusion(eval_bound(bs(q(test)),[]))).
*/

/*same as above but with alma not eval bound.
     -- can't get it to work; asserts "alma(bs(q(test))))" in KB.
fif(start(true),
    conclusion(alma(bs(q(test)),[]))).
*/

/*bs on RHS of fif without eval bound or alma.
    -- Works!
    -- Works without inital step.

fif(start(true),
    conclusion(bs(q(test)))).
*/

/*bs on LHS of fif without eval bound or alma,
  and without initial step: nothing.

fif(and(start(true),
        bs(q(test))),
    conclusion(test(works))).
*/

/*bs on LHS of fif without eval bound or alma,
  and with initial step: nothing.

fif(and(start(true),
        bs(q(test))),
    conclusion(test(works))).
*/

/*bs on LHS of fif with eval bound,
  and with initial step: nothing.

fif(and(start(true),
        eval_bound(bs(q(test)),[])),
    conclusion(test(works))).
*/

/*bs on LHS of fif with eval bound,
  and without initial step: nothing.

fif(and(start(true),
        eval_bound(bs(q(test)),[])),
    conclusion(test(works))).
*/

/*bs on LHS of fif with alma,
  and without initial step: nothing.

fif(and(start(true),
        alma(bs(q(test)),[])),
    conclusion(test(works))).
*/

/*bs on LHS of fif with alma,
  and with initial step: nothing.

fif(and(start(true),
        alma(bs(q(test)),[])),
    conclusion(test(works))).
*/

/*bs on LHS without an and: nothing.

fif(bs(q(test)),
    conclusion(test(works))).
*/

/*bs on LHS of plain if, no eval bound or alma, no initial step. Works!
but does not assert 'test(works)', only 'q(test)'.

if(bs(q(test)),test(works)).
*/

/*bs on LHS of plain if, no eval bound or alma, initial step. Works, 
  but does not assert 'test(works)', only 'q(test)'.

if(and(start(true),
       bs(q(test))),
    test(works)).
*/

/*bs on LHS of plain if, no eval bound or alma, no initial step. 
Uses 'alma' on RHS. Works, but  does not assert 'test(works)', 
only 'q(test)'.

if(bs(q(test)),alma(af(test(works)),[])).
*/


/*Set up KB with bif that contains af on LHS.*/

bif(and(p(X),
        alma(af(test(p,q)))),
    q(X)).
bif(and(q(X),
        eval_bound(af(test(q,r)),[])),
    r(X)).

p(true).

/*if(start(true),
   bs(r(true))).
*/

fif(start(true),
   conclusion(bs(r(true)))).


/*
alma(af(test(alm))).

eval_bound(af(test(evalbound)),[]).
*/
