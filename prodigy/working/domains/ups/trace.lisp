Starting cl ...
Allegro CL 3.1.13.1 [Sun4] (0/0/0)
Copyright (C) 1985-1990, Franz Inc., Berkeley, CA, USA
<cl>  
<cl> (load "/usr/mmv/start-up")
; Loading /usr/mmv/start-up.lisp.

T 
<cl> (load "nolimit/load-nolimit")
; Loading /usr/mmv/nolimit/load-nolimit.lisp.
; Fast loading /usr/mmv/nolimit/parmenides/parmenides.fasl.
Parmenides 1.5, Copyright (c) 1985, 1988 Carnegie Mellon.
Defining class RELATION
; Fast loading /usr/mmv/nolimit/frulekit/build.fasl.
Build initialized
FRulekit Copyright (c) 1985, 1990 Carnegie Mellon.
; Fast loading /usr/mmv/nolimit/frulekit/inter.fasl.
Defining class WME

Interpreter initialized
; Fast loading /usr/mmv/nolimit/new-slot-access.fasl.
; Fast loading /usr/mmv/nolimit/macros.fasl.
; Fast loading /usr/mmv/nolimit/defaults.fasl.
; Fast loading /usr/mmv/nolimit/cleaning.fasl.
; Fast loading /usr/mmv/nolimit/load-hierarchy.fasl.
Defining class TOFU
Defining class RULE
Defining class CONTROL-RULE
Defining class INFERENCE-RULE
Defining class OPERATOR
Defining class CONDITIONAL-EFFECT
Defining class CURRENT-TASK
Defining class META-STATE
Defining class DECISION-STATE
Defining class ASSERTION
Defining class TYPE
Defining class INFINITE-TYPE
Defining class NLPS-TRACE
Defining class SOL-BUCKET
Defining class SOLUTION
Defining class PATH
Defining class TNODE
Defining class GOAL-TNODE
Defining class CHOSEN-OP-TNODE
Defining class APPLIED-OP-TNODE
Defining class *FINISH*
Defining class DUMMY-WME
; Fast loading /usr/mmv/nolimit/load-domain.fasl.
; Fast loading /usr/mmv/nolimit/access-ps-frames.fasl.
; Fast loading /usr/mmv/nolimit/search-engine.fasl.
; Fast loading /usr/mmv/nolimit/backtracking.fasl.
; Fast loading /usr/mmv/nolimit/matcher.fasl.
; Fast loading /usr/mmv/nolimit/apply.fasl.
; Fast loading /usr/mmv/nolimit/print-outs.fasl.
; Fast loading /usr/mmv/nolimit/trace-fire.fasl.
; Fast loading /usr/mmv/nolimit/traverse-past-path.fasl.
; Fast loading /usr/mmv/nolimit/state-goal.fasl.
; Fast loading /usr/mmv/nolimit/convert-inf-rules.fasl.
; Fast loading /usr/mmv/nolimit/convert-sc-rules.fasl.
; Fast loading /usr/mmv/nolimit/load-problem.fasl.
; Fast loading /usr/mmv/nolimit/post-matcher.fasl.
; Fast loading /usr/mmv/nolimit/meta-predicates.fasl.
; Loading /usr/mmv/nolimit/problem-sets.lisp.
Defining class P-FRAME
Defining class IND-P-FRAME

T 
<cl> (load-domain "/usr/mmv/nolimit/domains/ups/domain")
Domain unloaded

Loading domain file: /usr/mmv/nolimit/domains/ups/domain
; Loading /usr/mmv/nolimit/domains/ups/domain.lisp.
Defining class HUB
Defining class PACKAGE
Defining class ROUTE-PACKAGE
Defining class INITIAL-ROUTE-PACKAGE
Loading functions from: /usr/mmv/nolimit/domains/ups/functions
; Fast loading /usr/mmv/nolimit/domains/ups/functions.fasl.
Defining class LINK
Defining class EFFECTIVELY-AT
Defining class SATISFY-DEADLINE
Defining class DUMMY
Defining class DONE

Domain loaded
NIL 
<cl> (load-problem)
Problems available:
  one-route-exact.lisp
  two-routes-one-ok.lisp
  two-routes-ok.lisp
  one-link-bad-deadline.lisp
  one-link-good-deadline.lisp
  real-times.lisp
  two-pacs.lisp

Load problem: one-route-exact

"/usr/mmv/nolimit/domains/ups/probs/one-route-exact" 
<cl> (nlrun)
; Loading /usr/mmv/nolimit/domains/ups/probs/one-route-exact.lisp.

  *************************** 

 Solving the problem "/usr/mmv/nolimit/domains/ups/probs/one-route-exact":

 Initial state : ((dummy) (effectively-at pac0 hub0 0) (link hub1 hub2 6) (link hub0 hub1 4))

 Goal statement: (satisfy-deadline pac0 hub2 10)

  *************************** 

 1. tn1 (done)

 2. tn2 (*finish*)

 3. tn3 (satisfy-deadline pac0 hub2 10)

 4. tn4 (route-package hub1 hub2 pac0 6 10 4)

 5. tn5 (satisfy-deadline pac0 hub1 4)

 6. tn6 (initial-route-package hub0 hub1 pac0 4 4 0)

 7. TN7 (INITIAL-ROUTE-PACKAGE HUB0 HUB1 PAC0 4 4 0)

 8. TN8 (ROUTE-PACKAGE HUB1 HUB2 PAC0 6 10 4)

 9. TN9 (*FINISH*)

  *************************** 

  This is the solution found:

       (initial-route-package hub0 hub1 pac0 4 4 0)
       (route-package hub1 hub2 pac0 6 10 4)
       (*finish*)


 BYE, BYE!!
nil 
<cl> (show-route 'pac0)
 Effective route for package pac0:
       At hub0 at time 0.
       At hub1 at time 4.
       At hub2 at time 10.
nil 
<cl> (load-problem)
Problems available:
  one-route-exact.lisp
  two-routes-one-ok.lisp
  two-routes-ok.lisp
  one-link-bad-deadline.lisp
  one-link-good-deadline.lisp
  real-times.lisp
  two-pacs.lisp

Load problem: one-link-good-deadline

"/usr/mmv/nolimit/domains/ups/probs/one-link-good-deadline" 
<cl> (nlrun)
; Loading /usr/mmv/nolimit/domains/ups/probs/one-link-good-deadline.lisp.

  *************************** 

 Solving the problem "/usr/mmv/nolimit/domains/ups/probs/one-link-good-deadline":

 Initial state : ((dummy) (effectively-at pac0 hub0 0) (link hub1 hub2 4) (link hub0 hub1 3))

 Goal statement: (satisfy-deadline pac0 hub2 10)

  *************************** 

 1. tn1 (done)

 2. tn2 (*finish*)

 3. tn3 (satisfy-deadline pac0 hub2 10)

 4. tn4 (route-package hub1 hub2 pac0 4 10 6)

 5. tn5 (satisfy-deadline pac0 hub1 6)

 6. tn6 (initial-route-package hub0 hub1 pac0 3 6 0)

 7. TN7 (INITIAL-ROUTE-PACKAGE HUB0 HUB1 PAC0 3 6 0)

 8. TN8 (ROUTE-PACKAGE HUB1 HUB2 PAC0 4 10 6)

 9. TN9 (*FINISH*)

  *************************** 

  This is the solution found:

       (initial-route-package hub0 hub1 pac0 3 6 0)
       (route-package hub1 hub2 pac0 4 10 6)
       (*finish*)


 BYE, BYE!!
nil 
<cl>  (show-route 'pac0)
 Effective route for package pac0:
       At hub0 at time 0.
       At hub1 at time 3.
       At hub2 at time 7.
nil 
<cl> (nlrun)
; Loading /usr/mmv/nolimit/domains/ups/probs/one-link-good-deadline.lisp.

  *************************** 

 Solving the problem "/usr/mmv/nolimit/domains/ups/probs/one-link-good-deadline":

 Initial state : ((dummy) (effectively-at pac0 hub0 0) (link hub1 hub2 4) (link hub0 hub1 3))

 Goal statement: (satisfy-deadline pac0 hub2 10)

  *************************** 

 1. tn1 (done)

 2. tn2 (*finish*)

 3. tn3 (satisfy-deadline pac0 hub2 10)

 4. tn4 (route-package hub1 hub2 pac0 4 10 6)

 5. tn5 (satisfy-deadline pac0 hub1 6)

 6. tn6 (initial-route-package hub0 hub1 pac0 3 6 0)

 7. TN7 (INITIAL-ROUTE-PACKAGE HUB0 HUB1 PAC0 3 6 0)

 8. TN8 (ROUTE-PACKAGE HUB1 HUB2 PAC0 4 10 6)

 9. TN9 (*FINISH*)

  *************************** 

  This is the solution found:

       (initial-route-package hub0 hub1 pac0 3 6 0)
       (route-package hub1 hub2 pac0 4 10 6)
       (*finish*)


 BYE, BYE!!
nil 
<cl>  (show-route 'pac0)
 Effective route for package pac0:
       At hub0 at time 0.
       At hub1 at time 3.
       At hub2 at time 7.
nil 
<cl> (load-problem)
Problems available:
  one-route-exact.lisp
  two-routes-one-ok.lisp
  two-routes-ok.lisp
  one-link-bad-deadline.lisp
  one-link-good-deadline.lisp
  real-times.lisp
  two-pacs.lisp

Load problem: one-link-bad-deadline

"/usr/mmv/nolimit/domains/ups/probs/one-link-bad-deadline" 
<cl> (nlrun)
; Loading /usr/mmv/nolimit/domains/ups/probs/one-link-bad-deadline.lisp.

  *************************** 

 Solving the problem "/usr/mmv/nolimit/domains/ups/probs/one-link-bad-deadline":

 Initial state : ((dummy) (effectively-at pac0 hub0 0) (link hub1 hub2 4) (link hub0 hub1 25))

 Goal statement: (satisfy-deadline pac0 hub2 10)

  *************************** 

 1. tn1 (done)

 2. tn2 (*finish*)

 3. tn3 (satisfy-deadline pac0 hub2 10)

 4. tn4 (route-package hub1 hub2 pac0 4 10 6)

 5. tn5 (satisfy-deadline pac0 hub1 6)


No relevant operators for (satisfy-deadline pac0 hub1 6)
  *************************** 

 No more solutions after exhaustive search
nil 
<cl>  (show-route 'pac0)
 Effective route for package pac0:
       At hub0 at time 0.
nil 
<cl> (load-problem)
Problems available:
  one-route-exact.lisp
  two-routes-one-ok.lisp
  two-routes-ok.lisp
  one-link-bad-deadline.lisp
  one-link-good-deadline.lisp
  real-times.lisp
  two-pacs.lisp

Load problem: two-routes-ok

"/usr/mmv/nolimit/domains/ups/probs/two-routes-ok" 
<cl> (nlrun)
; Loading /usr/mmv/nolimit/domains/ups/probs/two-routes-ok.lisp.

  *************************** 

 Solving the problem "/usr/mmv/nolimit/domains/ups/probs/two-routes-ok":

 Initial state : ((dummy) (effectively-at pac0 hub0 0) (link hub2 hub3 5) (link hub0 hub2 3) (link hub1 hub3 4) (link hub0 hub1 3))

 Goal statement: (satisfy-deadline pac0 hub3 10)

  *************************** 

 1. tn1 (done)

 2. tn2 (*finish*)

 3. tn3 (satisfy-deadline pac0 hub3 10)

 4. tn4 (route-package hub2 hub3 pac0 5 10 5)
     ops-left: ((route-package hub1 hub3 pac0 4 10 6))

 5. tn5 (satisfy-deadline pac0 hub2 5)

 6. tn6 (initial-route-package hub0 hub2 pac0 3 5 0)

 7. TN7 (INITIAL-ROUTE-PACKAGE HUB0 HUB2 PAC0 3 5 0)

 8. TN8 (ROUTE-PACKAGE HUB2 HUB3 PAC0 5 10 5)

 9. TN9 (*FINISH*)

  *************************** 

  This is the solution found:

       (initial-route-package hub0 hub2 pac0 3 5 0)
       (route-package hub2 hub3 pac0 5 10 5)
       (*finish*)


 BYE, BYE!!
nil 
<cl>  (show-route 'pac0)
 Effective route for package pac0:
       At hub0 at time 0.
       At hub2 at time 3.
       At hub3 at time 8.
nil 
<cl> (load-problem)
Problems available:
  one-route-exact.lisp
  two-routes-one-ok.lisp
  two-routes-ok.lisp
  one-link-bad-deadline.lisp
  one-link-good-deadline.lisp
  real-times.lisp
  two-pacs.lisp

Load problem: two-routes-one-ok

"/usr/mmv/nolimit/domains/ups/probs/two-routes-one-ok" 
<cl> (nlrun)
; Loading /usr/mmv/nolimit/domains/ups/probs/two-routes-one-ok.lisp.

  *************************** 

 Solving the problem "/usr/mmv/nolimit/domains/ups/probs/two-routes-one-ok":

 Initial state : ((dummy) (effectively-at pac0 hub0 0) (link hub2 hub3 5) (link hub0 hub2 20) (link hub1 hub3 4) (link hub0 hub1 3))

 Goal statement: (satisfy-deadline pac0 hub3 10)

  *************************** 

 1. tn1 (done)

 2. tn2 (*finish*)

 3. tn3 (satisfy-deadline pac0 hub3 10)

 4. tn4 (route-package hub2 hub3 pac0 5 10 5)
     ops-left: ((route-package hub1 hub3 pac0 4 10 6))

 5. tn5 (satisfy-deadline pac0 hub2 5)


No relevant operators for (satisfy-deadline pac0 hub2 5)
  *************************** 

 Starting a new path
 1. tn1 (done)
 2. tn2 (*finish*)
 3. tn3 (satisfy-deadline pac0 hub3 10)
 4. tn6 (route-package hub1 hub3 pac0 4 10 6)

 *** 
 5. tn7 (satisfy-deadline pac0 hub1 6)

 6. tn8 (initial-route-package hub0 hub1 pac0 3 6 0)

 7. TN9 (INITIAL-ROUTE-PACKAGE HUB0 HUB1 PAC0 3 6 0)

 8. TN10 (ROUTE-PACKAGE HUB1 HUB3 PAC0 4 10 6)

 9. TN11 (*FINISH*)

  *************************** 

  This is the solution found:

       (initial-route-package hub0 hub1 pac0 3 6 0)
       (route-package hub1 hub3 pac0 4 10 6)
       (*finish*)


 BYE, BYE!!
nil 
<cl>  (show-route 'pac0)
 Effective route for package pac0:
       At hub0 at time 0.
       At hub1 at time 3.
       At hub3 at time 7.
nil 
<cl> (load-problem)
Problems available:
  one-route-exact.lisp
  two-routes-one-ok.lisp
  two-routes-ok.lisp
  one-link-bad-deadline.lisp
  one-link-good-deadline.lisp
  real-times.lisp
  two-pacs.lisp

Load problem: two-pacs

"/usr/mmv/nolimit/domains/ups/probs/two-pacs" 
<cl> (nlrun)
; Loading /usr/mmv/nolimit/domains/ups/probs/two-pacs.lisp.

  *************************** 

 Solving the problem "/usr/mmv/nolimit/domains/ups/probs/two-pacs":

 Initial state : ((dummy) (effectively-at pac1 hub0 0) (effectively-at pac0 hub0 0) (link hub3 hub4 15) (link hub0 hub3 5) (link hub2 hub4 5) (link hub0 hub2 20) (link hub1 hub4 4) (link hub0 hub1 3))

 Goal statement: (and (satisfy-deadline pac0 hub4 10) (satisfy-deadline pac1 hub4 40))

  *************************** 

 1. tn1 (done)

 2. tn2 (*finish*)

 3. tn3 (satisfy-deadline pac0 hub4 10)
     goal-choices-left: ((satisfy-deadline pac1 hub4 40))

 4. tn4 (route-package hub2 hub4 pac0 5 10 5)
     ops-left: ((route-package hub1 hub4 pac0 4 10 6))

 5. tn5 (satisfy-deadline pac1 hub4 40)
     goal-choices-left: ((satisfy-deadline pac0 hub2 5))

 6. tn6 (route-package hub3 hub4 pac1 15 40 25)
     ops-left: ((route-package hub2 hub4 pac1 5 40 35) (route-package hub1 hub4 pac1 4 40 36))

 7. tn7 (satisfy-deadline pac0 hub2 5)
     goal-choices-left: ((satisfy-deadline pac1 hub3 25))


No relevant operators for (satisfy-deadline pac0 hub2 5)
  *************************** 

 Starting a new path
 1. tn1 (done)
 2. tn2 (*finish*)
 3. tn3 (satisfy-deadline pac0 hub4 10)
     goal-choices-left: ((satisfy-deadline pac1 hub4 40))
 4. tn8 (route-package hub1 hub4 pac0 4 10 6)

 *** 
 5. tn9 (satisfy-deadline pac1 hub4 40)
     goal-choices-left: ((satisfy-deadline pac0 hub1 6))

 6. tn10 (route-package hub3 hub4 pac1 15 40 25)
     ops-left: ((route-package hub2 hub4 pac1 5 40 35) (route-package hub1 hub4 pac1 4 40 36))

 7. tn11 (satisfy-deadline pac0 hub1 6)
     goal-choices-left: ((satisfy-deadline pac1 hub3 25))

 8. tn12 (initial-route-package hub0 hub1 pac0 3 6 0)

 9. TN13 (INITIAL-ROUTE-PACKAGE HUB0 HUB1 PAC0 3 6 0)

 10. TN14 (ROUTE-PACKAGE HUB1 HUB4 PAC0 4 10 6)

 11. tn15 (satisfy-deadline pac1 hub3 25)

 12. tn16 (initial-route-package hub0 hub3 pac1 5 25 0)

 13. TN17 (INITIAL-ROUTE-PACKAGE HUB0 HUB3 PAC1 5 25 0)

 14. TN18 (ROUTE-PACKAGE HUB3 HUB4 PAC1 15 40 25)

 15. TN19 (*FINISH*)

  *************************** 

  This is the solution found:

       (initial-route-package hub0 hub1 pac0 3 6 0)
       (route-package hub1 hub4 pac0 4 10 6)
       (initial-route-package hub0 hub3 pac1 5 25 0)
       (route-package hub3 hub4 pac1 15 40 25)
       (*finish*)


 BYE, BYE!!
nil 
<cl>  (show-route 'pac0)
 Effective route for package pac0:
       At hub0 at time 0.
       At hub1 at time 3.
       At hub4 at time 7.
nil 
<cl>  (show-route 'pac1)
 Effective route for package pac1:
       At hub0 at time 0.
       At hub3 at time 5.
       At hub4 at time 20.
nil 
<cl> (load-problem)
Problems available:
  one-route-exact.lisp
  two-routes-one-ok.lisp
  two-routes-ok.lisp
  one-link-bad-deadline.lisp
  one-link-good-deadline.lisp
  real-times.lisp
  two-pacs.lisp

Load problem:   real-times


"/usr/mmv/nolimit/domains/ups/probs/real-times" 
<cl> (nlrun)
; Loading /usr/mmv/nolimit/domains/ups/probs/real-times.lisp.

  *************************** 

 Solving the problem "/usr/mmv/nolimit/domains/ups/probs/real-times.lisp":

 Initial state : ((dummy) (effectively-at pac1 hub0 0) (effectively-at pac0 hub0 0) (link hub3 hub4 15) (link hub0 hub3 5.7) (link hub2 hub4 5) (link hub0 hub2 20.76) (link hub1 hub4 4.5) (link hub0 hub1 3.3))

 Goal statement: (and (satisfy-deadline pac0 hub4 10.5) (satisfy-deadline pac1 hub4 40))

  *************************** 

 1. tn1 (done)

 2. tn2 (*finish*)

 3. tn3 (satisfy-deadline pac0 hub4 10.5)
     goal-choices-left: ((satisfy-deadline pac1 hub4 40))

 4. tn4 (route-package hub2 hub4 pac0 5 10.5 5.5)
     ops-left: ((route-package hub1 hub4 pac0 4.5 10.5 6.0))

 5. tn5 (satisfy-deadline pac1 hub4 40)
     goal-choices-left: ((satisfy-deadline pac0 hub2 5.5))

 6. tn6 (route-package hub3 hub4 pac1 15 40 25)
     ops-left: ((route-package hub2 hub4 pac1 5 40 35) (route-package hub1 hub4 pac1 4.5 40 35.5))

 7. tn7 (satisfy-deadline pac0 hub2 5.5)
     goal-choices-left: ((satisfy-deadline pac1 hub3 25))


No relevant operators for (satisfy-deadline pac0 hub2 5.5)
  *************************** 

 Starting a new path
 1. tn1 (done)
 2. tn2 (*finish*)
 3. tn3 (satisfy-deadline pac0 hub4 10.5)
     goal-choices-left: ((satisfy-deadline pac1 hub4 40))
 4. tn8 (route-package hub1 hub4 pac0 4.5 10.5 6.0)

 *** 
 5. tn9 (satisfy-deadline pac1 hub4 40)
     goal-choices-left: ((satisfy-deadline pac0 hub1 6.0))

 6. tn10 (route-package hub3 hub4 pac1 15 40 25)
     ops-left: ((route-package hub2 hub4 pac1 5 40 35) (route-package hub1 hub4 pac1 4.5 40 35.5))

 7. tn11 (satisfy-deadline pac0 hub1 6.0)
     goal-choices-left: ((satisfy-deadline pac1 hub3 25))

 8. tn12 (initial-route-package hub0 hub1 pac0 3.3 6.0 0)

 9. TN13 (INITIAL-ROUTE-PACKAGE HUB0 HUB1 PAC0 3.3 6.0 0)

 10. TN14 (ROUTE-PACKAGE HUB1 HUB4 PAC0 4.5 10.5 6.0)

 11. tn15 (satisfy-deadline pac1 hub3 25)

 12. tn16 (initial-route-package hub0 hub3 pac1 5.7 25 0)

 13. TN17 (INITIAL-ROUTE-PACKAGE HUB0 HUB3 PAC1 5.7 25 0)

 14. TN18 (ROUTE-PACKAGE HUB3 HUB4 PAC1 15 40 25)

 15. TN19 (*FINISH*)

  *************************** 

  This is the solution found:

       (initial-route-package hub0 hub1 pac0 3.3 6.0 0)
       (route-package hub1 hub4 pac0 4.5 10.5 6.0)
       (initial-route-package hub0 hub3 pac1 5.7 25 0)
       (route-package hub3 hub4 pac1 15 40 25)
       (*finish*)


 BYE, BYE!!
nil 
<cl>  (show-route 'pac0)
 Effective route for package pac0:
       At hub0 at time 0.
       At hub1 at time 3.3.
       At hub4 at time 7.8.
nil 
<cl>  (show-route 'pac1)
 Effective route for package pac1:
       At hub0 at time 0.
       At hub3 at time 5.7.
       At hub4 at time 20.7.
nil 
<cl> 