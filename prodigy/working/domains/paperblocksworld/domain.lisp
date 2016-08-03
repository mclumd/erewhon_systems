;;; This is another version of the blocksworld domain.
;;; Unlike the version in "blocksworld", it doesn't have arm-empty in
;;; the effects list of any operator, only in the inference rule
;;; "infer-armempty". The problems directory here is just a symbolic
;;; link to the one in "blocksworld".
;;; - Jim


(create-problem-space 'paper-blocksworld :current t)

(ptype-of OBJECT :top-type)
(pinstance-of blocka object)
(pinstance-of blockb object)
(pinstance-of blockc object)

(OPERATOR 
  PICK-UP
  (params <ob1>)
  (preconds 
   ((<ob1> OBJECT))
   (and (clear <ob1>)
	(on-table <ob1>)
	(arm-empty)))
  (effects 
      () ; no vars need genenerated in effects list
      ((del (on-table <ob1>))
       (del (clear <ob1>))
       (add (holding <ob1>)))))

(OPERATOR
  PUT-DOWN
  (params <ob>)
  (preconds 
   ((<ob> OBJECT))
    (holding <ob>))
  (effects 
        ()
	((del (holding <ob>))
	 (add (clear <ob>))
	 (add (on-table <ob>)))))

(defun diff (x y) (not (eq x y)))

(OPERATOR
 STACK
 (params <ob> <underob>)
 (preconds 
   ((<ob> Object)
    (<underob> (and OBJECT (diff <ob> <underob>))))
    (and (clear <underob>)
	 (holding <ob>)))
 (effects 
      ()
      ((del (holding <ob>))
       (del (clear <underob>))
       (add (clear <ob> ))
       (add (on <ob> <underob>)))))

(OPERATOR
 UNSTACK
 (params <ob> <underob>)
 (preconds
  ((<ob> Object)
   (<underob> Object))
  (and (on <ob> <underob>)
       (clear <ob>)
       (arm-empty)))
 (effects 
        ()
	((del (on <ob> <underob>))
	 (del (clear <ob>))
	 (add (holding <ob>))
	 (add (clear <underob>)))))

(Inference-Rule
 Infer-ArmEmpty
 (params)
 (preconds () (~ (exists ((<ob> Object)) (holding <ob>))))
 (effects () ((add (arm-empty)))))

;;; The following control rules are there just to make Sussman's
;;; anomaly nice and short for the "nutshell" part of the user guide.

(Control-Rule avoid-apply-for-wrong-goal
	      (IF (and (on-goal-stack (on <x> <y>))
		       (candidate-goal (on <y> <z>))
		       (applicable-operator (pick-up <x>))))
	      (THEN sub-goal))

;;; This one is added to make some backtracking take place in that domain.
#|
(control-rule incorrectly-prefer-unstack-to-pickup
	      (IF (current-goal (holding <x>)
	      (THEN prefer operator unstack pick-up))
		  |#

;;; calling meta-predicate involves instantiate literals, 
;;; thus changes the assertion hash table. 
;;; Adding control rules can cause "give-me-all-pending-goals"
;;; return different order of pending goals, thus PRODIGY may
;;; end up returning different choosen-goal than when we are
;;; not calling control rules.  This randomness may give
;;; difficulty to debugging. It might be a good idea to have
;;; some kind of sorting in the literals, e.g.  by a time stamp,
;;; or the node number in which the literals are created.

#|
;;; These control rules are designed to model the arbitrary decisions
;;; that Prodigy2.0 takes in the paper, so we can see if the 580 nodes
;;; that 4.0 takes on the paper problem is just bad luck...
(control-rule prefer-pick-up-to-unstack
	      (IF (and))
	      (THEN prefer operator pick-up unstack))

(control-rule prefer-put-down-unstack
	      (if (and))
	      (then prefer operator put-down unstack))

(control-rule prefer-stack-putdown
	      (if (and))
	      (then prefer operator stack put-down))
|#

#|
This rule doesn't change the default behaviour at all, which is to do
depth-first search without control rules.
(control-rule DEPTH-FIRST-SEARCH
	      (IF (newest-candidate-node <node>))
	      (THEN select node <node>))
|#

#|
;;; I bet this one really sucks! It's for me to test out preference
;;; rules for nodes.
(control-rule depth-first-search
	      (IF (and (candidate-node <x>)
		       (candidate-node <y>)
		       (newer-node <x> <y>)))
	      (THEN prefer node <x> <y>))

(defun newer-node (node1 node2)
  "Return t if node1 is newer than node2. Both should be bound."
  (unless (and (typep node1 'p4::nexus) (typep node2 'p4::nexus))
    (error "Both arguments should be nodes: ~S ~S~%" node1 node2))
  (> (p4::nexus-name node1) (p4::nexus-name node2)))
|#


;;; current-ops is a meta-predicate that cannot be renamed
;;; because in load-domain time, it is used to decide in which
;;; operators this select binding control will be put in.

(CONTROL-RULE SELECT-BINDINGS-UNSTACK-CLEAR
	      (IF (and (current-goal (clear <y>))
		       (current-ops (UNSTACK))
		       (true-in-state (on <x> <y>))))
	      (THEN select bindings ((<ob> . <x>) (<underob> . <y>))))

#|
(control-rule prefer-bindings-unstack-clear
	      (IF (and (current-goal (clear <y>))
		       (current-ops (unstack))
		       (true-in-state (on <x> <y>))))
	      (THEN prefer bindings
		    ((<ob> . <x>) (<underob> . <y>))
		    ((<ob> . <anything>) (<underob> . <anything_else>))))
|#

;;; Note that all clear blocks will be selected by this rule.

(Control-Rule Select-Bindings-Stack-Armempty
	      (IF (and (current-goal (arm-empty))
		       (current-ops (stack))
		       (true-in-state (holding <x>))
		       (true-in-state (clear <y>))))
	      (THEN select bindings ((<ob> . <x>) (<underob> . <y>))))

#|
(control-rule prefer-bindings-stack-armempty
	      (IF (and (current-goal (arm-empty))
		       (current-ops (stack))
		       (known (holding <x>))
		       (known (clear <y>))))
	      (THEN prefer bindings ((<ob> . <x>) (<underob> . <y>))
		    ((<ob> . <a>) (<underob> . <b>))))
|#

(CONTROL-RULE SELECT-BINDINGS-UNSTACK-HOLDING
	      (IF (and (current-goal (holding <x>))
		       (current-ops (UNSTACK))
		       (true-in-state (on <x> <y>))))
	      (THEN select bindings ((<ob> . <x>) (<underob> . <y>))))

#|
(control-rule prefer-bindings-unstack-holding
	      (IF (and (current-goal (holding <x>))
		       (current-ops (UNSTACK))
		       (known (on <x> <y>))))
	      (THEN prefer bindings ((<ob> . <x>) (<underob> . <y>))
		    <anything>))
|#


(CONTROL-RULE SELECT-OP-UNSTACK-FOR-HOLDING
	      (IF (and (current-goal (holding <x>))
		       (true-in-state (on <x> <y>))))
	      (THEN select operator UNSTACK))

#|
(control-rule prefer-op-unstack-for-holding
	      (IF (And (current-goal (holding <x>))
		       (known (on <x> <y>))))
	      (THEN prefer operator unstack <anything>))
|#

(CONTROL-RULE SELECT-OP-UNSTACK-FOR-CLEAR
	      (IF (and (current-goal (clear <x>))
		       (true-in-state (on <y> <x>))))
	      (THEN select operator UNSTACK))

#|
(CONTROL-RULE prefer-OP-UNSTACK-FOR-CLEAR
	      (IF (and (current-goal (clear <x>))
		       (true-in-state (on <y> <x>))))
	      (THEN prefer operator UNSTACK <anything>))
|#

#| commented out to ensure some backtracking in the example.
(CONTROL-RULE SELECT-PICKUP-FOR-HOLDING-IF-ON-TABLE
	      (IF (and (current-goal (holding <ob>))
		       (true-in-state (on-table <ob>))))
	      (THEN select operator PICK-UP))
|#

#|
(CONTROL-RULE prefer-PICKUP-FOR-HOLDING-IF-ON-TABLE
	      (IF (and (current-goal (holding <ob>))
		       (true-in-state (on-table <ob>))))
	      (THEN prefer operator PICK-UP <anything>))
|#

(CONTROL-RULE PUTDOWN-CLEAR-IF-HOLDING
	      (IF (and (current-goal (clear <ob>))
		       (true-in-state (holding <other-ob>))))
	      (THEN select operator PUT-DOWN))

#|
(CONTROL-RULE prefer-CLEAR-IF-HOLDING
	      (IF (and (current-goal (clear <ob>))
		       (true-in-state (holding <other-ob>))))
	      (THEN prefer operator PUT-DOWN <anything>))
|#

(CONTROL-RULE SELECT-BINDINGS-PUTDOWN-ARMEMPTY
	      (IF (and (current-goal (arm-empty))
		       (current-ops (PUT-DOWN))
		       (true-in-state (holding <x>))))
	      (THEN select bindings ((<OB> . <x>))))

#|
(CONTROL-RULE prefer-BINDINGS-PUTDOWN-ARMEMPTY
	      (IF (and (current-goal (arm-empty))
		       (current-ops (PUT-DOWN))
		       (true-in-state (holding <x>))))
	      (THEN prefer bindings ((<OB> . <x>)) <anything>))
|#
#|
(CONTROL-RULE REJECT-WRONG-GOAL
	      (IF (and (candidate-goal (on <x> <y>))
		       (candidate-goal (on <y> <z>))
		       (true-in-state (clear <x>))))
	      (THEN reject goal (on <x> <y>)))
|#

(Control-rule Prefer-right-goal
	      (IF (and (candidate-goal (on <x> <y>))
		       (candidate-goal (on <y> <z>))
		       (true-in-state (clear <x>))))
	      (THEN prefer goal (on <y> <z>) (on <x> <y>)))


(Control-Rule avoid-apply-for-wrong-goal
	      (IF (and (on-goal-stack (on <x> <y>))
		       (candidate-goal (on <y> <z>))
		       (applicable-operator (pick-up <x>))))
	      (THEN sub-goal))


(defun diff (x y)
  (not (eq x y)))



