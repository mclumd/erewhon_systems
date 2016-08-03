#-clisp
(unless (find-package "PRODIGY4")
  (make-package "PRODIGY4" :nicknames '("P4")))

(in-package "PRODIGY4")







;;;
;;; File overload.lisp  is used to create the output in the Appendix of Cox & 
;;; Veloso (ICCBR). The function definitions redefine code from the files 
;;; matcher-interface.lisp and search.lisp.
;;;


;;;
;;; This global holds the current value of a fired prefer control rule. 
;;; Is used to save it on the :why-chosen property of the search node's 
;;; plist and then the variable is set back to nil.
;;;
(defvar *my-crl-name* nil)


;;;
;;; From matcher-interface.lisp Note this is redefined below.
;;;
;(defun fire-prefer (rule pref bindings candidates preferee type)
;  (let ((preferred-things
;	 (delete preferee
;		 (delete-duplicates
;		  (translate-rule-symbols bindings pref candidates type)))))
;    (if preferred-things
;	(output 3 t "~%Firing pref rule ~S for ~S over ~S"
;		(setf ;; Wrapped setf around call of control-rule-name [cox 25feb97]
;		 *my-crl-name* 
;		 (control-rule-name rule)) preferred-things preferee))
;    preferred-things))



(defun refine-node (node)
  (declare (type nexus node))

  ;; Yow! Assertions!
  (assert (> (nexus-abs-level node) 0))

  (setf (elt (problem-space-property :deepest-point)
	     (nexus-abs-level node))
	nil)
  (typecase node
    (goal-node
     ;; This is ugly - doesn't deal with the problem of a parent at
     ;; this abstraction level properly.
     (let ((subnode (make-goal-node
		     :goal (goal-node-goal node)
		     :abs-parent node
		     :abs-level (1- (nexus-abs-level node)))))
       ;;[cox 25jun97]
       (when *my-crl-name*
	     (setf (getf (p4::nexus-plist subnode) :why-chosen)
		   (if (getf (p4::nexus-plist subnode) :why-chosen) 
		       (cons *my-crl-name* (getf (p4::nexus-plist subnode) :why-chosen))
		     *my-crl-name*))
;	     (break)
	     (setf *my-crl-name* nil))
       (if (eq node (problem-space-property :next-thing))
	   (setf (problem-space-property :next-thing)
		 (nexus-winner (nexus-winner (nexus-winner node)))))
       ;; This doesn't sort out who the parent should be. 
       (set-abs-parent subnode nil node)
       subnode))
    (applied-op-node
     (let ((was-winner (nexus-winner node)))
       (cond ((eq was-winner :solution)
	      ;; If we backtrack here, then the attempt to refine the
	      ;; plan failed.
	      (close-node node :not-refineable)
	      (setf (nexus-winner node) nil)
	      (mark-up-solution node nil)
	      :not-refineable)
	     (t (error "Refining an applied op node in the middle of a
solved abstraction level - I can't deal!")))))
    (t (error "The refine stuff is still very skimpy."))))


(defun do-subgoal (node poss-subgoals next-thing)
  (declare (special *always-ignore-bad-goals*))

  (let ((chosen-goal (choose-goal node poss-subgoals)))

    (cond (chosen-goal
	   (let* ((binding-nodes
		   (mapcar #'instantiated-op-binding-node-back-pointer
			   ;;aperez: just add a comment here. This
                           ;;function broke because it may happen that:
			   ;;literal-state-p may be true and
			   ;;literal-neg-goal-p false with
			   ;;literal-goal-p true 
   			   ;; (this happened to me due to a bug
                           ;;somewhere else related with undoing when
                           ;;backtracking and the justifications of
                           ;;the inference rules)
			   (if (literal-state-p chosen-goal)
			       (literal-neg-goal-p chosen-goal)
			       (literal-goal-p chosen-goal))))
		  (goal-node
		   (make-goal-node
		    :parent node
		    :abs-level (nexus-abs-level node)
		    :goal chosen-goal
		    :introducing-operators binding-nodes
		    :goals-left
		    (if (and (eq *running-mode* 'saba)
			     *smart-apply-p*)
			nil
			(remove chosen-goal (a-or-b-node-pending-goals node)))
		    ;; assume the goal is for a good reason!
		    :positive? (not (literal-state-p chosen-goal))))
		  ;; (next-thing (problem-space-property :next-thing))
		  )
	     ;;[cox 25jun97]
	     (when *my-crl-name*
		   (setf (getf (p4::nexus-plist goal-node) :why-chosen)
			 (if (getf (p4::nexus-plist goal-node) :why-chosen) 
			     (cons *my-crl-name* (getf (p4::nexus-plist goal-node) :why-chosen))
			   *my-crl-name*))
;		   (break)
		   (setf *my-crl-name* nil))
	     ;; Test if the code has broken in the way Alicia
	     ;; mentioned above. If it has, cause a continuable error,
	     ;; to warn the user, because now this code will not
	     ;; break, but something else might.
	     (when (and (null binding-nodes)
			(not *always-ignore-bad-goals*))
		 (cerror "Just carry on"
			 "The chosen goal, ~S, is not marked as a goal"
			 chosen-goal)
		 (format t "~%Ignore this error from now on? [no] ")
		 (let ((answer (read-line)))
		   (if (and (> (length answer) 0)
			    (char= (elt answer 0) #\y))
		       (setf *always-ignore-bad-goals* t))))
	     ;; Add the goals to the list of expanded goals on this path.
	     (push chosen-goal
		   (problem-space-expanded-goals *current-problem-space*))
	     (setf (a-or-b-node-goals-left node)
		   (if (and (eq *running-mode* 'saba) *smart-apply-p*)
		       nil
		     (delete chosen-goal (a-or-b-node-goals-left node))))
	     (if (and (or (not *use-protection*)
			  (null (a-or-b-node-protections-left node)))
		      (null (a-or-b-node-goals-left node))
		      (null (a-or-b-node-applicable-ops-left node)))
		 (close-node node :exhausted))
	     ;; Add this node to the goal nodes property of the
	     ;; relevant binding nodes.
	     (dolist (bn binding-nodes)
	       (push goal-node (getf (nexus-plist bn) 'goal-nodes)))
	     (let* ((abs (if (car binding-nodes) ; Yuck!!
			     (nexus-abs-parent (car binding-nodes))))
		    (true-parent	; this can be hard to find!
		     (cond ((and (goal-node-p next-thing)
				 (eq (goal-node-goal next-thing) chosen-goal))
			    next-thing)
			   (abs
			    (find-if #'(lambda (bn)
					 (eq (goal-node-goal bn) chosen-goal))
				     (getf (nexus-plist abs) 'goal-nodes)
				     ;; We want the earliest one (maybe).
				     :from-end t)))))
	       (if true-parent
		   (set-abs-parent goal-node node true-parent)
		   (do-book-keeping goal-node node)))
;;;		 (if (eq true-parent next-thing)
		   ;; Next goal or applicable-op node.
;;;		     (setf (problem-space-property :next-thing)
;;;			   (nexus-winner (nexus-winner
;;;					  (nexus-winner next-thing)))))

	     goal-node))

	  (t :no-goal))))


;;;
;;; From search.lisp
;;;
(defun expand-goal (node)
  "Expand a goal node in the search tree to produce an operator node."

  (let* ((goal (goal-node-goal node))
	 (poss-ops (cache goal-node-ops-left node
			  (generate-operators node goal)))
	 chosen-op op-node)
    
    (cond ((eq poss-ops :big-lose)
	   ;; This goal can never be solved - there are no operators.
	   ;; Mark the goal as unsolvable, close off all the nodes that
	   ;; require it.
	   (setf (getf (literal-plist goal)
		       (if (negated-goal-p goal)
			   :unsolvable-false
			   :unsolvable-true))
		 t)
	   (close-node node :no-op))
	  
	  ;; If it's still empty, close the node. Else proceed.
	  ((null poss-ops) (close-node node :no-op))

	  ;; If there's no chosen operator, we fail at this node,
	  ((null (setf chosen-op (choose-operator node poss-ops)))
	   :no-op)

	  ;; If there's a chosen operator, make the node for it and
	  ;; forward test for goal loops (see below).
	  (t
	   (setf op-node
		 (make-operator-node
		  :operator chosen-op
		  :parent   node
		  :abs-level (nexus-abs-level node)))
	   ;;[cox 25feb97]
	   (when *my-crl-name*
		 (setf (getf (p4::nexus-plist op-node) :why-chosen)
		       (if (getf (p4::nexus-plist op-node) :why-chosen) 
			   (cons *my-crl-name* (getf (p4::nexus-plist op-node) :why-chosen))
			 *my-crl-name*))
;		 (break)
		 (setf *my-crl-name* nil))
	   ;; Delete this choice from the parent of the new node
	   (setf (goal-node-ops-left node)
		 (delete chosen-op (goal-node-ops-left node)))
	   (if (null (goal-node-ops-left node))
	       (close-node node :exhausted))

	   ;; Mark in abstraction parentage if relevant. See the
	   ;; comment in get-all-ops about fudging the operator.
	   (let* ((abs (nexus-abs-parent node))
		  (winner (if abs (nexus-winner abs))))
	     (if (and winner (eq chosen-op
				 (operator-node-operator winner)))
		 (set-abs-parent op-node node winner)
		 (do-book-keeping op-node node)
		 )

	     (when (eq (operator-name chosen-op) '*finish*)
	       (setf (elt (problem-space-property :*finish-binding*)
			  (nexus-abs-level node))
		     op-node)))
		 
	   op-node))))

#|
;;;
;;; From search.lisp and further redefined in Interleave/patches.lisp
;;;
(defun really-expand-operator (node)
  (declare (type operator-node node))

  (let ((poss-bindings
	 (cache operator-node-bindings-left node
		(generate-bindings node
				   (goal-node-goal (operator-node-parent node))
				   (operator-node-operator node))))
	chosen-binding
	(*abslevel* (nexus-abs-level node)))
    (declare (special *abslevel*))
    
    (cond ((null poss-bindings)
	   (close-node node :no-binding-choices))

	  ;; If there is a chosen binding, wallop the node in for the
	  ;; next available disjunct choice.
	  ;; next-disjunct is the function that sets the
	  ;; goal-p or neg-goal-p field of the literals.
	  ((setf chosen-binding (choose-binding node poss-bindings))
	   (let* ((inst-prec (or (instantiated-op-precond chosen-binding)
				 (build-instantiated-precond
				  chosen-binding *abslevel*)))
		  (binding-node
		   (make-binding-node
		    :parent node
		    :abs-level *abslevel*
		    :instantiated-op chosen-binding
		    :instantiated-preconds inst-prec
		    :disjunction-path
		    (next-disjunct node inst-prec chosen-binding))))
	     ;[cox 25feb97]
	     (when *my-crl-name*
		   (setf (getf (p4::nexus-plist binding-node) :why-chosen)
			 (if (getf (p4::nexus-plist binding-node) :why-chosen) 
			     (cons *my-crl-name* (getf (p4::nexus-plist binding-node) :why-chosen))
			   *my-crl-name*))
;		   (break)
		   (setf *my-crl-name* nil))
	     (setf (instantiated-op-binding-node-back-pointer chosen-binding)
		   binding-node)
	     (set-goals chosen-binding)
	     (when *incremental-pending-goals*
	       (get-delta-pending-goals binding-node)
	       (setf (binding-node-pending-goals binding-node)
		     (copy-list (cdr *pending-goals*))))
	     (if (last-disjunct-p (binding-node-disjunction-path binding-node)
				  inst-prec)
		 (setf (operator-node-bindings-left node)
		       (delete chosen-binding
			       (operator-node-bindings-left node))))
	     (if (null (operator-node-bindings-left node))
		 (close-node node :exhausted))
	     (let* ((abs (nexus-abs-parent node))
		    (winner (if abs (nexus-winner abs)))
		    (winner-binding (if winner
					(binding-node-instantiated-op winner))))
	       (if (and winner
			(eq (instantiated-op-op chosen-binding)
			    (instantiated-op-op winner-binding))
			(eq (instantiated-op-values chosen-binding)
			    (instantiated-op-values winner-binding)))
		   (set-abs-parent binding-node node winner)
		   (do-book-keeping binding-node node)
		   ))
	     ;; We have different conspiracy number information for
	     ;; these nodes.
	     (setf (nexus-conspiracy-number binding-node)
		   (instantiated-op-conspiracy chosen-binding))
	     binding-node))

	  (t :no-chosen-binding))))
|#

#|
;;;
;;; From search.lisp and further redefined in Interleave/execute.lisp
;;;
(defun do-apply-op (node applicable-ops next-thing)

  (let ((chosen-op (choose-applicable-op node applicable-ops))
	a-op-node)
    (declare (special a-op-node))	; used in state daemons.

    (cond (chosen-op
	   (setf a-op-node
		 (make-applied-op-node
		  :parent node
		  :abs-level (nexus-abs-level node)
		  :instantiated-op chosen-op))
	   ;;[cox 25feb97]
	   (when *my-crl-name*
		 (setf (getf (p4::nexus-plist a-op-node) :why-chosen)
			 (if (getf (p4::nexus-plist a-op-node) :why-chosen) 
			     (cons *my-crl-name* (getf (p4::nexus-plist a-op-node) :why-chosen))
			   *my-crl-name*))
;		 (break)
		 (setf *my-crl-name* nil))
	   (setf (a-or-b-node-applicable-ops-left node)
		 (delete chosen-op (a-or-b-node-applicable-ops-left node)))
	   (if (and (null (a-or-b-node-applicable-ops-left node))
		    (null (a-or-b-node-goals-left node))
		    (or (not *use-protection*)
			(null (a-or-b-node-protections-left node))))
	       (close-node node :exhausted))
	   (if (and next-thing
		    (applied-op-node-p next-thing)
		    (eq (nexus-abs-parent
			 (instantiated-op-binding-node-back-pointer chosen-op))
			(instantiated-op-binding-node-back-pointer
			 (applied-op-node-instantiated-op next-thing))))
	       (set-abs-parent a-op-node node next-thing)
	       (do-book-keeping a-op-node node))

	   (cond ((apply-and-check a-op-node chosen-op)
		  ;; If finish is applicable we're done.
		  (setf (getf (nexus-plist a-op-node) :termination-reason)
			:achieve)
		  (prod-signal :achieve a-op-node)
		  a-op-node)
		 
		 ;; If there is a state loop, close this new node, retract
		 ;; the state, reset the goals and fail.
	         ((state-loop-p a-op-node)
		  (dolist (application (applied-op-node-applied a-op-node))
		    (do-state application nil)
		    (let ((instop (op-application-instantiated-op application)))
		      (if (instantiated-op-binding-node-back-pointer instop)
			  (set-goals instop))))
		  (close-node a-op-node :state-loop)
		  (compute-expanded-goals node)
		  :state-loop)
		 
	         ;;; Otherwise recalculate the pending goals
		 (*incremental-pending-goals*		  
		  (setf (a-or-b-node-pending-goals a-op-node)
			(copy-list (get-delta-pending-goals a-op-node)))
		  a-op-node)
		 (t
		  (setf (a-or-b-node-pending-goals a-op-node)
			(give-me-all-pending-goals a-op-node))
		  a-op-node)))

	  (t :no-ap-op))))
|#

;;;-------------------------------------------------------------------------
;;; The following code is from matcher-interface.lisp file.



(defun match-select-node (rule)
  (let ((matched (match-lhs (control-rule-if rule) nil))
	(select-expr (fourth (control-rule-then rule))))
    (if matched
	(let ((selected-nodes
	       (mapcar #'(lambda (binding)
			   (if (eq binding t)
			       select-expr
			       (sublis binding select-expr)))
		       matched)))
	  (output 3 t "~%Firing select node rule ~S to get ~S"
		  (control-rule-name 
		   (setf ;; Wrapped setf around rule identifier [cox 24jun97]
		    *my-crl-name* 
		    rule)) selected-nodes)
	  selected-nodes))))

(defun match-reject-nodes (nodes rule)
  (declare (list nodes)
	   (type control-rule rule))
  (let ((reject-expr (fourth (control-rule-then rule)))
	(matched (match-lhs (control-rule-if rule) nil)))
    (when matched
      (output 3 t "~%Firing reject nodes ~S" 
	      (control-rule-name 
	       (setf ;; Wrapped setf around rule identifier [cox 24jun97]
		*my-crl-name* 
		rule)))
      (dolist (binding matched)
	(let ((offender (sublis binding reject-expr)))
	  (output 3 t "~%...deleting ~S" offender)
	  (setq nodes (delete offender nodes)))))
    (values nodes matched)))







;;; match select-operator control-rule; if it fires, return set of operators
;;; specified in the right-hand side of the rule, otherwise, return nil.
(defun match-select-op (node goal rule)
  (declare (ignore goal)
	   (special *current-problem-space*))
  (let ((select-expr (fourth (control-rule-then rule)))
	(matched (match-lhs (control-rule-if rule) node)))
    (when matched
      (let ((selected-ops
	     (delete-duplicates
	      (mapcar #'(lambda (bindings)
			  (rule-name-to-rule
			   (if (eq bindings t)
			       select-expr
			       (sublis bindings select-expr))
			   *current-problem-space*))
		      matched))))
	(output 3 t "~%Firing select op rule ~S to get ~S"
		(control-rule-name 
		 (setf ;; Wrapped setf around rule identifier [cox 24jun97]
		  *my-crl-name* 
		  rule)) selected-ops)
	selected-ops))))

;; match reject-operator control-rule; if it fires, return the operators in ops
;; that are not rejected by the right-hand side of the control-rule, otherwise
;; returns ops.
(defun match-reject-op (node rule ops)

  (let ((reject-expr (fourth (control-rule-then rule)))
	(matched (match-lhs (control-rule-if rule) node)))
    (cond
      ;;aperez (nov. 13, 92) extended to case when the op to reject is
      ;;a variable 
     ((and matched (strong-is-var-p reject-expr))
       ;;see if the op variable (reject-expr) is matched from the lhs.
       ;;If so, fire the rule once for each match. If not, give a
       ;;warning. 
       (dolist (match matched ops)
	 (let ((op (cdr (assoc reject-expr match :test #'equal))))
	   (cond
	     (op ;op is an operator structure
	      (output 3 t "~%Firing reject operator ~S ~S"
		      (control-rule-name 
		       (setf ;; Wrapped setf around rule identifier [cox 24jun97]
			*my-crl-name* 
			rule)) (rule-name op))
	      (setf ops (delete op ops)))
	     (t
	      (format t "Warning: rule ~S matches but the expression ~
                  rejected is an unbound var.~%" 
		  (control-rule-name rule)))))))
      (matched
       (output 3 t "~%Firing reject operator ~S ~S"
	       (control-rule-name 
		(setf ;; Wrapped setf around rule identifier [cox 24jun97]
		 *my-crl-name* 
		 rule)) reject-expr)
       (delete (rule-name-to-rule reject-expr *current-problem-space*)
	       ops))
      (t
       ops))))


(defun match-reject-bindings (node op rule bindings)
  (let ((reject-expr (fourth (control-rule-then rule)))
	(matched (match-lhs (control-rule-if rule) node)))
    (when matched
      (output 3 t "~%Firing reject rule ~S" 
	      (control-rule-name 
	       (setf ;; Wrapped setf around rule identifier [cox 24jun97]
		*my-crl-name* 
		rule)))
      (dolist (rejected-bindings matched)
	(let ((offender (sublis (sublis rejected-bindings reject-expr)
				(cdr (operator-params op)))))
	  (output 3 t "~%..rejecting ~S" offender)
	  (setf bindings
		(delete-if #'(lambda (x) (equal (car x) offender))
			   bindings)))))
    bindings))

	
(defun rete-gen-bindings (op rhs-bindings)
  (let* ((foo (rule-generator op))
	 (data (if foo (funcall foo (change-to-real-pb (car rhs-bindings)))))
	 (all-simple-tests (rule-simple-tests op))
	 (all-unary-tests (rule-unary-tests op))
	 (all-join-tests (rule-join-tests op))
	 (all-neg-simple-tests (rule-neg-simple-tests op))
	 (all-neg-unary-tests (rule-neg-unary-tests op))
	 (all-neg-join-tests (rule-neg-join-tests op))
	 (number-of-rules (- (length all-unary-tests) 2)))

    (if (car all-unary-tests)
	(do* ((n number-of-rules (1- n))
	      (unary-tests all-unary-tests (cdr unary-tests))
	      (join-tests all-join-tests (cdr join-tests))
	      (simple-tests  all-simple-tests  (cdr simple-tests))
	      (precedence (simple-match (car simple-tests))
			  (simple-match (car simple-tests)))
	      (neg (if precedence
		       (neg-simple-match all-neg-simple-tests op))
		   (if precedence
		       (neg-simple-match all-neg-simple-tests op)))
	      (tuple (if neg (match (car unary-tests) 
				    (car join-tests)
				    all-neg-unary-tests
				    all-neg-join-tests
				    (cons neg data)
				    op))
		     (if neg (match (car unary-tests) 
				    (car join-tests) 
				    all-neg-unary-tests
				    all-neg-join-tests
				    (cons neg data)
				    op))))
		     
	     ((or tuple (null  (cdr unary-tests))) 
	      (progn
		(if (>= n 0)
		    (output 3 t "~%Firing select binding rule ~S at node ~S"
			    (control-rule-name
			     (setf ;; Wrapped setf around call of nth [cox 25jun97]
			      *my-crl-name* 
			      (nth n (rule-select-bindings-crs op))))
			    (nexus-name user::*current-node*)))
#|		    (output 3 t "~%Firing select binding rule ~S"
			    (control-rule-name
			     (nth n (rule-select-bindings-crs op)))))
|#
		tuple)))

	;; if the op does not have vars, then there will not be any
	;; binding control rule.  don't worry about firing stuff. 
	(and (simple-match (car all-simple-tests))
	     (neg-simple-match all-neg-simple-tests op)))))




;;; Changed this so it wouldn't alter the order of the candidates, at
;;; least for goals and operators. It's harder to do for bindings, and
;;; I'm not so sure it matters.
(defun fire-prefer (rule pref bindings candidates preferee type)
  (let ((preferred-things
	 (delete preferee
		 (delete-duplicates
		  (translate-rule-symbols bindings pref candidates type)))))
    (if preferred-things
	(output 3 t "~%Firing pref rule ~S for ~S over ~S"
		(control-rule-name 
		 (setf ;; Wrapped setf around rule identifier [cox 24jun97]
		  *my-crl-name* 
		  rule)) preferred-things preferee))
    preferred-things))
			    


;; Match one select goal control rule.  Returns nil if the rule doesn't fire,
;; return the goals specified by the rule if the rule fires.
(defun match-select-goal (node rule)
  (declare (type nexus node)
	   (type control-rule rule))
  (let ((select-expr (fourth (control-rule-then rule)))
	(matched (match-lhs (control-rule-if rule) node)))
    (if matched 
	(let ((selected-goals
	       (delete-duplicates
		(mapcar #'(lambda (bindings)
			    (let ((res (sublis bindings select-expr)))
			      (if (literal-p res)
				  res
				  (instantiate-consed-literal res))))
			matched))))
	  (output 3 t "~%Firing select goals rule ~S to get ~S"
		  (control-rule-name 
		   (setf ;; Wrapped setf around rule identifier [cox 24jun97]
		    *my-crl-name* 
		    rule)) selected-goals)
	  selected-goals))))

	


;; match one reject-goal control rule.  If the rule fires, return the subset
;; of goals that are not rejected by rule; otherwise, return nil.
(defun match-reject-goal (node goals rule)
  (declare (ignore goals))
  (let ((reject-expr (fourth (control-rule-then rule)))
	(matched (match-lhs (control-rule-if rule) node)))
    (if matched 
	(let ((deleted-goals
	       (mapcar #'(lambda (x)
			   (let ((goal (substitute-binding reject-expr x)))
			     (if (listp goal)
				 (instantiate-consed-literal goal)
				 goal)))
		       matched)))
	  (output 3 t "~%Firing delete goals ~S ~S"
		  (control-rule-name 
		   (setf ;; Wrapped setf around rule identifier [cox 24jun97]
		    *my-crl-name* 
		    rule)) deleted-goals)
	  deleted-goals))))

  

(defun match-a-or-s-rule (rule)
  (declare (type control-rule rule))
  (when (match-lhs (control-rule-if rule) nil)
    (let ((decision (second (control-rule-then rule))))
      (output 3 t "~%Firing apply/subgoal ~S deciding ~S"
	      (control-rule-name 
	       (setf ;; Wrapped setf around rule identifier [cox 24jun97]
		*my-crl-name* 
		rule)) decision)
      ;; There are no bindings on the right hand side, so the match
      ;; that is returned is ignored.
      (case decision
	(user::sub-goal :sub-goal)
	(user::protect :protect)
	(user::apply   :apply)))))


(defun match-r-or-e-rule (rule)
  (declare (type control-rule rule))
  (when (match-lhs (control-rule-if rule) nil)
    (let ((decision (second (control-rule-then rule))))
      (output 3 t "~%Firing apply/subgoal ~S deciding ~S"
	      (control-rule-name 
	       (setf ;; Wrapped setf around rule identifier [cox 24jun97]
		*my-crl-name* 
		rule)) decision)
      ;; There are no bindings on the right hand side, so the match
      ;; that is returned is ignored.
      (case decision
	((user::refine :refine) :refine)
	((user::expand :expand)  :expand)))))
  
;; this function should return applied-op structures.
(defun match-select-applied-ops (applied-ops rule)
  (declare (special *current-problem-space*))
  (when *debug-apply-op-ctrl*
    (format t "~%MATCH-SELECT-APPLIED-OPS"))
  (let ((select-expr (fourth (control-rule-then rule)))
	(matched (match-lhs (control-rule-if rule) nil)))
    (when *debug-apply-op-ctrl*
      (format t "~%  Select-expr: ~S" select-expr)
      (format t "~%  Matched    : ~S" matched))
    (cond
     ((and matched (strong-is-var-p select-expr))
      ;; it's the whole applied op

      (let ((selected-ops
	     (mapcar #'(lambda (bindings)
			 (cdr (assoc select-expr bindings)))
		     matched)))
	(output 3 t "~%Firing select applied-op rule ~S to get~%    ~S"
		(control-rule-name 
		 (setf ;; Wrapped setf around rule identifier [cox 24jun97]
		  *my-crl-name* 
		  rule))
		selected-ops)
	selected-ops))
     (matched
      (let ((selected-ops
	     (mapcar #'(lambda (bindings)
			 ;; bindings would only = t if no vars are bound,
			 ;; which should never happen here.
			 ;;
			 ;; we need to find the p4::*potential-applied-ops* which
			 ;; matches these bindings.

			 (find-applied-op-given-bindings p4::*potential-applied-ops*
							 bindings))
			 matched)))
	    (output 3 t "~%Firing select applied-op rule ~S to get~%    ~S"
		    (control-rule-name 
		     (setf ;; Wrapped setf around rule identifier [cox 24jun97]
		      *my-crl-name* 
		      rule))
		    selected-ops)
	    selected-ops))
     (t nil))))


;; this function should return applied-op structures. IT
;; RETURNS THE LIST OF REMAINING OPS
(defun match-reject-applied-op (applied-ops rule)
  (let ((reject-expr (fourth (control-rule-then rule)))
	(matched (match-lhs (control-rule-if rule) nil)))
    (when *debug-apply-op-ctrl*
      (format t "~%  reject-expr: ~S" reject-expr)
      (format t "~%  Matched:     ~S" matched))
    (cond
     ((and matched (strong-is-var-p reject-expr))
      ;; see if something in the LHS matched, then fire rule
      ;; once for each match. otherwise warning.
      (when *debug-apply-op-ctrl*
	(format t "~%MATCH-REJECT-APPLIED-OP var in RHS"))
      (dolist (match matched applied-ops)
	(let ((op (cdr (assoc reject-expr match :test #'equal))))
	  (cond (op (output 3 t "~%Firing reject applied-operator ~S to remove~%    ~S"
			    (control-rule-name 
			     (setf ;; Wrapped setf around rule identifier [cox 24jun97]
			      *my-crl-name* 
			      rule))
			    op
			    )
		    (setf applied-ops (delete op applied-ops)))
		(t (format t "Warning: rule ~S matches but the expression ~
                           rejected unbound var.~S"
			   (control-rule-name rule)))))))
     (matched
      (let ((rejected-ops
	     (mapcar #'(lambda (bindings)
			 (find-applied-op-given-bindings p4::*potential-applied-ops*
							 bindings))
		     matched)))
	(output 3 t "~%Firing reject applied-operator ~S to remove~%     ~S"
		(control-rule-name 
		 (setf ;; Wrapped setf around rule identifier [cox 24jun97]
		  *my-crl-name* 
		  rule))
		rejected-ops)
	(set-difference applied-ops
			rejected-ops)))
     (t
      applied-ops))))
