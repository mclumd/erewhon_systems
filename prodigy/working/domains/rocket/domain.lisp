;;
;; In the most usual rocket problem, the goal is to transfer two
;; payloads to the same destination with one rocket. Since
;; transferring each payload is viewed as a separate goal, this
;; conjunction is only solvable if we interleave the operators to
;; solve the subgoals, that is, by putting both payloads on board the
;; rocket before it is sent.
;;
;; This domain is a translation of the prodigy 2 "rocket" domain, and
;; the problem is set up in prob1.lisp in this directory.
;;

(create-problem-space 'rocket :current t)

(ptype-of CARGO  :top-type)
(ptype-of PLACE  :top-type)
(ptype-of ROCKET :top-type)

(pinstance-of ROCKET Rocket)
(pinstance-of JOHN-F-KENNEDY LONDON PITTSBURGH Place)

(Operator
 Load-Rocket
 (params <object> <place>)
 (preconds
  ((<object> CARGO)
   (<place> PLACE))
  (and (at <object> <place>)
       (at rocket <place>)))
 (effects
  ()
  ((del (at <object> <place>))
   (add (in-rocket <object>)))))

(Operator
 Unload-Rocket
 (params <object> <place>)
 (preconds
  ((<object> CARGO)
   (<place>  PLACE))
  (and (at rocket <place>)
       (in-rocket <object>)))
 (effects
  ()
  ((del (in-rocket <object>))
   (add (at <object> <place>)))))

(Operator
 Move-Rocket-Fast
 (params)
 (preconds
  ()
  (at rocket London))
 (effects
  ()
  ((del (at rocket London))
   (add (at rocket Pittsburgh)))))

(Operator
 Move-Rocket-Slow
 (params)
 (preconds () (at rocket John-F-Kennedy))
 (effects
  ()
  ((del (at rocket John-F-Kennedy))
   (add (at rocket Pittsburgh)))))


;;; ============
;;; Control Rules
;;; ============

;;; Other useful control information: this domain works well with
;;; the abstraction heuristic
(format t "~%Switching on computing abstraction hierarchies.~%")
(pset :compute-abstractions t)

;;; With no control rules or abstraction, problem prob1.lisp can be
;;; solved in 63 nodes.
#|
#| With just this control rule, we can solve in 48 nodes, but I want
   to do better
(Control-Rule Reject-Rocket-London
	      (If (and (candidate-goal (at rocket london))
		       (true-in-state (at rocket pittsburgh))))
	      (Then Reject goal (at rocket london)))

;;; Using this control rule alone, we can solve in 26 nodes.

(control-rule Reject-At-Rocket-Pittsburgh
	      (if (and (candidate-goal (at rocket pittsburgh))
		       (candidate-goal (in-rocket <cargo>))
		       (true-in-state (at <cargo> london))))
	      (then reject goal (at rocket pittsburgh)))

;;; This rule only shaves off two nodes from the previous total, but
;;; I'm shooting for a search stick so it's worth it.. It also doesn't
;;; slow the time down one bit, presumably because of the cost of
;;; chewing through all the binding lists produced..

(control-rule Always-Load-In-Place
	      (if (and (current-goal (in-rocket <cargo>))
		       (true-in-state (at <cargo> <location>))
		       (current-ops (load-rocket))))
	      (then select bindings
		    ((<object> . <cargo>) (<place> . <location>))))

;;; Finally, this rule along with the two above us indeed give us a
;;; search stick.

(control-rule Move-Rocket-to-move-rocket
	      (if (current-goal (at rocket <x>)))
	      (then select operator move-rocket-fast))

;;; Is this more powerful? No, although it reduces the number of goals
;;; generated, the same ones are explored (I think by good fortune).

(control-rule Reject-everything-else-to-select
	      (if (and (candidate-goal (in-rocket <cargo>))
		       (candidate-goal (at <x> <y>))))
	      (then reject goal (at <x> <y>)))
|#

(control-rule Work-on-rocket-last
	      (IF (and (candidate-goal (at rocket pittsburgh))
		       (candidate-goal <anything-else>)))
	      (THEN prefer goal <anything-else> (at rocket pittsburgh)))

#|
(control-rule prefer-not-at-rocket-pittsburgh
	      (IF (and (candidate-goal (at rocket pittsburgh))
		       (candidate-goal (in-rocket <cargo>))
		       (known (at <cargo> london))))
	      (THEN prefer goal (in-rocket <cargo>) (at rocket pittsburgh)))
|#

(control-rule prefer-to-load-in-place
	      (IF (and (current-goal (in-rocket <cargo>))
		       (known (at <cargo> <location>))
		       (current-ops (load-rocket))))
	      (THEN prefer bindings ((<object> . <cargo>) (<place> . <location>))
		    <anything_else>))

(control-rule prefer-move-rocket-to-move-rocket
	      (IF (current-goal (at rocket <x>)))
	      (THEN prefer operator move-rocket-fast <anything>))

|#

;(load "/usr/mmv/p1/aips96/ui/ask-rules.lisp")
