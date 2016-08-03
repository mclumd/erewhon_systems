#|
Peter 7/1/94:  
Option to execute occurs after an a-or-b-node is expanded.
Wen a node is executed, backtracking should not go past it.
Once a node has been executed, try all solutions without loops
before trying to plan to undo an executed operator.  In this way, a 
commitment to execute is a strong commitment.
After everything else has been tried, go to a state or goal loop.  
The beginning of the loop should have been executed, while the end
of it should not have been.

Issues:
  --When do you execute?  Always ask the user?
  --When we execute, should we really close all the nodes previous
      to the executed node, or just relevant ones?  Using SABA, 
      executing a single operator could be commiting to alot of stuff
      (see prob-2-1 in the rocket domain).
      Right now, has-been-executed? sees only relevant nodes as 
      executed.
  --Which loop do you try first?  The most recently noticed one?
  --What's a good domain in which to demo this stuff?
______________________________________________________________________

Peter 12/15/94:
Now you can execute the remainder of a plan when done planning, but
the monitoring of whether or not it succeeds isn't quite working.

The functions change-state-on-execute and change-state-on-apply are 
set up to change the state at the two given points according to 
functions defined by the domain.  By default, the functions are nil.
______________________________________________________________________

Karen 95/2/23:
Created the ability to permit prodigy to decide by itself when to
apply. See automatically-decide-to-execute
|#

(in-package "USER")


(defvar *loaded-execute* t 
  "Flag to signal execution system in place.")

(in-package "PRODIGY4")

;;;[cox]
(defparameter *mike-trace* nil)

;;; [cox]
(defvar *use-deployment-heuristic* t
  "If t, then execute deployment operators at planning time.")

(defvar *prodigy-running* nil)

(defvar *ask* nil)  ;;should I ask about executing?  default, no.
(defvar *ask-each-time* t)
(defvar *automatic* nil) ;; this should allow prodigy to decide
     ;; if/when to execute all by its wee self.
(defvar *ex* t)   ;;should I excise loops?
(defvar *last-to-be-executed* 0)  ;;last node executed
(defvar *already-asked* nil)  ;;last operator to have asked about
(setf *already-asked* nil)

(defvar *execution-queue* nil) ;; the list of ops "already executed"

(defun same-operator? (applied-op-node1 applied-op-node2)
  (let ((op1 (applied-op-node-instantiated-op applied-op-node1))
	(op2 (applied-op-node-instantiated-op applied-op-node2)))
    (and (eq (instantiated-op-op op1) (instantiated-op-op op2))
	 (equal (instantiated-op-values op1) (instantiated-op-values op2)))))

(defun prior-to-last-execution? (node)
  (<= (nexus-name node) *last-to-be-executed*))

(defun last-execution? (node)
  (= (nexus-name node) *last-to-be-executed*))

(defun has-been-executed? (node)
  (getf (nexus-plist node) :executed?))

(defun reset-applicable-ops-and-goals (node next)
  (setf (a-or-b-node-applicable-ops-left node) nil)
  (setf (a-or-b-node-pending-goals node) nil)
  (setf (a-or-b-node-goals-left node) nil))

(defun do-execute-op (node executable-op next-thing)
  ;; as with do-apply-op, this function executes the op and then
  ;; returns the action executed, or :execution-failed.
  ;; we don't want recursive behaviour
  (declare (ignore next-thing))
  
  (setf *execution-queue*
	(nconc *execution-queue*
	       (list executable-op)))
  (let* ((result (change-state-on-execute executable-op))
	 ;;tag these four nodes to determine whether goal loops 
	 ;;should be reexamined.  An execution really only takes care
	 ;;of these 4 nodes.
	 (inst-op (applied-op-node-instantiated-op executable-op))
	 (b-node (instantiated-op-binding-node-back-pointer inst-op))
	 (o-node (binding-node-parent b-node))
	 (g-node (operator-node-parent o-node)))
    (setf (getf (applied-op-node-plist executable-op) :executed?) t)
    (setf (getf (binding-node-plist b-node) :executed?) t)
    (setf (getf (operator-node-plist o-node) :executed?) t)
    (setf (getf (goal-node-plist g-node) :executed?) t)
    (setf (getf (instantiated-op-plist inst-op) :executed?) t)

    (if (eq result :execution-failed)
	(progn
	  (reset-applicable-ops-and-goals node (compute-next-thing node))
	  :execution-failed)
      (progn
	(setf *last-to-be-executed* (applied-op-node-name executable-op))
	;; The next 5 I added while commenting out the dolist.
	;; But then I commented out them too. [cox]
;	(close-node executable-op :executed)
;	(close-node b-node :executed)
;	(close-node o-node :executed)
;	(close-node g-node :executed)
;	(do-state executable-op t)
;	(dolist (nd (cdr (path-from-root executable-op 
;					 #'(lambda (x) (not (eq x executable-op))))))
;		(close-node nd :executed))
	node))))

(defun do-execute-op-at-end (node executable-op next-thing)
  (declare (ignore next-thing))

  ;;here
  (setf *execution-queue*
	(nconc *execution-queue*
	       (list executable-op)))
  ;;here
  (if (eq (change-state-on-execute executable-op)
	  :execution-failed)
      (progn
	(reset-applicable-ops-and-goals node (compute-next-thing node))
	:execution-failed)
    (progn 
      (let* ((inst-op (applied-op-node-instantiated-op executable-op))
	     (b-node (instantiated-op-binding-node-back-pointer inst-op))
	     (o-node (binding-node-parent b-node))
	     (g-node (operator-node-parent o-node)))
	;;tag these four nodes to determine whether goal loops 
	;;should be reexamined.  An execution really only takes care
	;;of these 4 nodes.
	(setf (getf (applied-op-node-plist executable-op) :executed?) t)
	(setf (getf (binding-node-plist b-node) :executed?) t)
	(setf (getf (operator-node-plist o-node) :executed?) t)
	(setf (getf (goal-node-plist g-node) :executed?) t)
	;;tag the operator as executed (for printing purposes).
	(setf (getf (instantiated-op-plist inst-op) :executed?) t))
      (setf *last-to-be-executed* (applied-op-node-name executable-op))
      (dolist (nd (cdr (path-from-root executable-op 
				       #'(lambda (x) (not (eq x executable-op))))))
	      (close-node nd :executed)))))


(defun choose-apply-subgoal-or-execute (node app-ops goals exec-op)
  (cond ((and *automatic*
	      exec-op
	      (automatically-decide-to-execute exec-op))

	 ;; since there are application-dependant things which
	 ;; can determine when to apply, we make a call to a
	 ;; user-writeable
	 ;; function. The default behaviour is to ask...

	 :execute)

	(t
	 (choose-apply-or-subgoal node app-ops goals))))


(defun get-executable (node)
  ;; Peter 7/1/94:  First un-executed operator to have been applied.
  (let ((partial-plan (cdr (path-from-root node #'p4::applied-op-node-p))))
    (find-if-not #'prior-to-last-execution? partial-plan)))

;--------------------------------------------------------------------------
;--------------------------------------------------------------------------

(defun expand-binding (node)
  (declare (type binding-node node))
  "Expand a binding node."

  ;; First check whether this node makes a goal loop inevitable, in
  ;; which case forget it. Maybe this should be learnable with a
  ;; control rule, but it's so general I figure not.
  (let ((inst-precs (binding-node-instantiated-preconds node))
	(disj-path  (binding-node-disjunction-path node))
	(values (instantiated-op-values
		 (binding-node-instantiated-op node)))
	loop-top)
    (cond ((needs-unsolvable-goal-p inst-precs disj-path values t)
	   (close-node node :uses-unsolvable-goal))
	  ((and (setf loop-top
		      (binding-node-goal-loop-p node inst-precs disj-path values))
;;Peter 7/11/94: check variable *ex*.  If t, then save pair in :loop-pairs.
		*ex*)
	   (push (cons node (car loop-top)) 
		 (getf (problem-space-plist *current-problem-space*) 
		       :loop-pairs))
	   (close-node node (cons :causes-goal-loop loop-top)))
	  (t
	   ;; Otherwise we're ok to expand, but first check if this is an
	   ;; inference rule which can be applied straight away.
	   (if (and (inference-rule-a-or-b-node-p node)
		    (not (binding-node-applied node))
		    (applicable-op-p node)
		    (apply-and-check node (binding-node-instantiated-op node)))
	       (progn (prod-signal :achieve node) node)
	       (expand-binding-or-applied-op node))))))

(defun expand-operator (node)
  (declare (type operator-node node))
  "Expand a chosen operator node, ie with bindings."

  (let ((goal (goal-node-goal (nexus-parent node)))
	(op (operator-node-operator node))
	regressed loop-top)

    ;; If this is the first time at this node, we check the old goal
    ;; loop thing.
    (cond ((and (eq (operator-node-bindings-left node) :not-computed)
		;; Calculate the regressed goal expressions - made by
		;; unifying the goal with the relevant effects of the
		;; operator. There may be more than one relevant effect.
		;; This is the first step to passing not-fully-instantiated
		;; goals around, and allows one obvious optimisation -
		;; checking for goal loops before doing the bindings in
		;; full. So we go for it.
		(null (setf (getf (nexus-plist node) :regressed-preconds)
			    (setf regressed (regress-preconds op goal))))
		(not (zerop (length (literal-arguments goal)))))
	   (close-node node :no-good-bindings))

	  ;; Well ok, we wait and check there are decent choices first.
	  ((and (eq (operator-node-bindings-left node) :not-computed)
		(setf loop-top
		      (operator-causes-goal-loop regressed node))
;;Peter 7/11/94: check variable *ex*.  If t, then save pair in :loop-pairs.
		*ex*)
	   (push (cons node (car loop-top))
		 (getf (problem-space-plist *current-problem-space*) 
		       :loop-pairs))
	   (close-node node (cons :causes-goal-loop loop-top)))

	  ;; This is to keep me sane.
	  (t 
	   (really-expand-operator node)))))


(defun expand-binding-or-applied-op (node)
  ;; Peter 7/1/94  Changed to include option to :execute
  "Expand a binding node"
  (declare (type a-or-b-node node))

  (let* ((next (compute-next-thing node))
	 (applicables (cache a-or-b-node-applicable-ops-left node
			     (abs-generate-applicable-ops node next)))
	 (subgoals (cache a-or-b-node-goals-left node
			  (setf (a-or-b-node-pending-goals node)
				(if *incremental-pending-goals*
				    (abs-generate-goals node next)
				  (delete-if #'(lambda (goal)
						 (goal-loop-p node goal))
					     (abs-generate-goals node next))))))
	 (executable (get-executable node)))
#|
;;Peter 1/5/94:  to try to regenerate apps for saba
	 (applicables (abs-generate-applicable-ops node next))
	 (subgoals (setf (a-or-b-node-pending-goals node)
			 (if *incremental-pending-goals*
			     (abs-generate-goals node next)
			   (delete-if #'(lambda (goal)
					  (goal-loop-p node goal))
				      (abs-generate-goals node next)))))
	 (executable (get-executable node)))

;;testing if this helps
    (cache a-or-b-node-applicable-ops-left node applicables)
    (cache a-or-b-node-goals-left node subgoals)
|#
    (if (and (null applicables) (null subgoals)) ;surely don't execute!!
	(close-node node :no-choices)
	(let ((what-next (choose-apply-subgoal-or-execute node applicables subgoals executable)))
	  (case what-next
	    (:execute
	     (let ((result (do-execute-op node executable next))
		   )
	       (if (eq result :execution-failed)
		   (progn
		     (close-node node :execution-failed)
		     (close-node (p4::nexus-parent node) :execution-failed)
		     :execution-failed)
		 ;;find what next node to use
		 (expand-binding-or-applied-op node))
	     ))
	    (:apply
	     (if applicables
		 (do-apply-op node applicables next *ex*)
		 (close-node node :no-choices)))
	    (:sub-goal
	     (if subgoals
		 (do-subgoal node subgoals next)
		 (close-node node :no-choices)))
	    (otherwise what-next))))))

;--------------------------------------------------------------------------



(defun do-apply-op (node applicable-ops next-thing excise-state-loops?)
  ;;This function actually applies the op, then returns either the node applied
  ;;or :no-ap-op.

  ;;next-thing is just here for bookkeeping
  
  ;;Peter 7/8/94:  Changed to include new argument that determines whether
  ;;or not loops should be discarded from the search space.  In general
  ;;they should be, but on occasion, the variable *ex* is set to nil to allow
  ;;a state loop to be expanded.

  (let ((chosen-op (choose-applicable-op node applicable-ops))
	a-op-node)
    (declare (special a-op-node))	; used in state daemons.

    (cond (chosen-op
	   (setf a-op-node
		 (make-applied-op-node
		  :parent node
		  :abs-level (nexus-abs-level node)
		  :instantiated-op chosen-op))
	   ;; This was change from overload.lisp [cox 25feb97]
	   (when (and (boundp user::*load-patches*)
		      user::*load-patches*
		      *my-crl-name*)
		 (setf (getf (p4::nexus-plist a-op-node) :why-chosen)
			 (if (getf (p4::nexus-plist a-op-node) :why-chosen) 
			     (cons *my-crl-name* (getf (p4::nexus-plist a-op-node) :why-chosen))
			   *my-crl-name*))
;		 (break)
		 (setf *my-crl-name* nil))
	   (setf (a-or-b-node-applicable-ops-left node)
		 (delete chosen-op (a-or-b-node-applicable-ops-left node)))
	   (if (null (a-or-b-node-applicable-ops-left node))
	       (if (null (a-or-b-node-goals-left node))
		   (close-node node :exhausted)))
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
		  ;; feb 13 96, need to do an execution step here 
		  (let ((exec-op (get-executable a-op-node)))
		    (when (and *automatic*
			       exec-op
			       (automatically-decide-to-execute exec-op))
			  ;; Moved format statement into when form. [17oct97 cox]
			  (format t "~%EXECUTE ~S HERE" a-op-node )
			  (do-execute-op a-op-node exec-op :ignored)
			  (format t "~%CHECK THAT ~S WORKED HERE" a-op-node )
			  ))

		  (setf (getf (nexus-plist a-op-node) :termination-reason)
			:achieve)
		  (prod-signal :achieve a-op-node)
		  a-op-node)
		 
		 ;; If there is a state loop, close this new node, retract
		 ;; the state, reset the goals and fail.
		 ;;Peter 7/8/94:  only if excise-state-loops? is t.
	         ((and excise-state-loops? 
		       (state-loop-p a-op-node))
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


;Only one change in this function.  It really belongs in
;another file, since it involves changing the state
;on application, not execution

(defun apply-op (node inst-op &optional (justn nil))
  (declare (type a-or-b-node node)
	   (type instantiated-op inst-op))
  "Change the state and record the actual changes in the delta-assertions slot"

  (let* ((op (instantiated-op-op inst-op))
	 (application (make-op-application :instantiated-op inst-op))
	 (vars (rule-vars op))
	 (values (instantiated-op-values inst-op))
	 (justification
	  (if (inference-rule-p op)
	      (or justn
		  (preconds-to-list
		   (instantiated-op-binding-node-back-pointer inst-op)))))
	 (precond-bindings
	  (precond-bindings vars values)))

    ;; The application structure will record this application at this node.
    (push application (a-or-b-node-applied node))

    ;; Iterate over the del-list and add-list of the operator. For each
    ;; one, find the associated literal in the state and do the dirty.
    ;; We have to work out what literals to fire first, in case there
    ;; are bindings, and firing off one lot alters the bindings of the
    ;; other. If that is the case, it matters what order the adds and
    ;; dels are in, but we don't preserve that order. I do the del's
    ;; first so that if a literal is in both lists, it stays around.
    (let ((adds-and-deletes (compute-effects op precond-bindings node)))
      (dolist (dellit (first adds-and-deletes))
	(apply-for-one-literal dellit justification application nil node))
      (dolist (addlit (second adds-and-deletes))
	(apply-for-one-literal addlit justification application t node)))
    
    ;;Peter 12/14/94.  Put in to call the change-state function.
    (change-state-on-apply node application)

    ;; Not sure this is the right thing to do..
    (unless justn (delete-instantiated-op-from-literals inst-op))))


;--------------------------------------------------------------------------

(defun brief-print-inst-op (inst-op)
  ;; Peter 7/1/94:  Indicates if the operator's been executed.
  (declare (type instantiated-op inst-op))

  (let* ((op (instantiated-op-op inst-op))
	 (vars (rule-vars op))
	 (values (instantiated-op-values inst-op)))
    (princ "<")
    (princ (operator-name op))
    (dolist (argument (cdr (rule-params op)))
      (let ((position (position argument vars)))
	(if (>= position (length values))
	    (error "Trying to print a parameter that is not in the
bindings for operator ~S - perhaps some of the parameters are not in
the preconditions?" op))
	(let ((value (elt values position)))
	  (princ #\Space)
	  (if (listp value) (princ argument)
	      (print-literal-arg value)))))
      (princ ">")
      (when (getf (instantiated-op-plist inst-op) :executed?) 
	    (princ "  -  executed."))))

(in-package "USER")

(defun pp-result (result stream z)
  (declare (ignore z))

  ;;Peter  7/8/94:  Print the operators that have been executed even
  ;;if no solution was found
  (unless (prodigy-result-solutionp result)
	  (p4::print-executed-ops
	   (find-node (prodigy-result-nodes result)))
	  (terpri)
	  (terpri))

  (format stream "#<PRODIGY result: ~a, ~d secs, ~d nodes, ~d sol>"
	  (prodigy-result-solutionp result)
	  (prodigy-result-time result)
	  (prodigy-result-nodes result)
	  (prodigy-result-number-solutions result)))

(in-package "PRODIGY4")

(defun print-executed-ops (last-node)
  ;;Peter 7/8/94:  Print only the executed operators.
  (dolist (a-node (cdr (path-from-root last-node #'applied-op-node-p)))
	  (let ((inst-op (applied-op-node-instantiated-op a-node)))
	    (when (getf (instantiated-op-plist inst-op) :executed?)
		  (format t "~%  ")
		  (brief-print-inst-op inst-op)))))
		 
;-----------------------------------------------------------------------------

(defun generate-nodes (node-or-failure-message)
  "Uses select and reject control rules to generate a set of candidate
nodes to expand next in the search."
  (declare (special *current-problem-space*)
	   (ignore node-or-failure-message))
  ;; First, see if any rules fire.
  (let ((user::*candidate-nodes* nil)
	(select-firedp nil)
	(reject-firedp nil)
	(rules-result nil)
	(final-result nil))
    (declare (special user::*candidate-nodes*))

    (multiple-value-setq (user::*candidate-nodes* select-firedp)
      (scr-select-nodes
       (problem-space-select-nodes *current-problem-space*)))
    (multiple-value-setq (rules-result reject-firedp)
      (scr-reject-nodes
       user::*candidate-nodes*
       (problem-space-reject-nodes *current-problem-space*)
       nil))

    (if (or select-firedp reject-firedp)
	rules-result
	(let* ((method (getf (problem-space-plist *current-problem-space*)
			    :search-default))
	       (final-result
		(case method
		      (:breadth-first
		       ;; (print 'breadth-first)
		       (list (return-next *current-problem-space*)))
		      (:depth-first
		       ;; (print 'depth-first)
		       (list (return-previous *current-problem-space*)))
		      (t rules-result))))
	  
	  ;;so subsequent loops are excised.
	  (setf *ex* t)

	  ;;Peter 7/8/94:  Eliminate candidates that are before the last
	  ;;executed node.
	  ;; Commented out to allow backtracking over executed ops [10oct97 cox]
;	  (setf final-result
;		(remove-if #'(lambda(nd) (when nd 
;			      (and (prior-to-last-execution? nd)
;				   (not (last-execution? nd)))))
;			   final-result))

	  ;;Peter 7/8/94:  If there is nothing being returned, look to the 
	  ;;deleted loops.
	  (cond ((car final-result)
		 final-result)
		(t 
		 (check-aborted-loops)))))))

(defun check-aborted-loops ()
  ;;Peter 7/8/94:  so the loop is not immediately excised.
  (setf *ex* nil)

  (let ((restart-node (find-aborted-loop)))
    ;;If restart-node is an applied-op node, then it was a state-loop
    ;;otherwise, it was a goal-loop.
    (cond ((applied-op-node-p restart-node)
	   (let* ((inst-op (applied-op-node-instantiated-op restart-node))
		  (b-node (instantiated-op-binding-node-back-pointer inst-op)))
	     (if (prior-to-last-execution? b-node)
		 ;;Peter 7/10/94:  look for a different loop.
		 (check-aborted-loops)
	       ;;Peter 7/8/94:  Put the choice back.
	       (push inst-op (binding-node-applicable-ops-left b-node)))
	     (list b-node)))
	  ((binding-node-p restart-node)
	   (let ((inst-op (binding-node-instantiated-op restart-node))
		 (o-node (binding-node-parent restart-node)))
	     (if (prior-to-last-execution? o-node)
		 ;;Peter 7/10/94:  look for a different loop.
		 (check-aborted-loops)
	       ;;Peter 7/8/94:  Put the choice back.
	       (push inst-op (operator-node-bindings-left o-node)))
	     (list o-node)))
	  ((operator-node-p restart-node) 
	   ;;Take out the cerror and test it.
v;	   (cerror "don't continue" 
;	     "Check if this part of the function works in check-aborted-loops in execute.lisp")
	   ;;this part could be wrong...it hasn't been tested yet
	   (let ((op (operator-node-operator restart-node))
		 (g-node (operator-node-parent restart-node)))
	     (if (prior-to-last-execution? g-node)
		 ;;Peter 7/10/94:  look for a different loop.
		 (check-aborted-loops)
	       ;;Peter 7/8/94:  Put the choice back.
	       (push op (goal-node-ops-left g-node)))
	     (list g-node))))))


(defun find-aborted-loop ()
  ;;Want this to return a loop with a node that's been executed.
  ;;The node that caused the loop must not have been executed.
  ;;most recent or first to occur?  both options?
  ;;return nil if no loops left to try.
  (let ((pair 
	 (find-if #'(lambda(x) (has-been-executed? (cdr x)))
		  (getf (problem-space-plist *current-problem-space*) 
			:loop-pairs))))
    (when pair
	  (setf 
	   (getf (problem-space-plist *current-problem-space*) 
		 :loop-pairs) 
	   (remove pair 
		   (getf (problem-space-plist *current-problem-space*) 
			 :loop-pairs)))
	  (car pair))))

;-----------------------------------------------------------------------------


(defun state-loop-p (node)
  ;;Peter 7/8/94:  Changed the two state-loop functions so that the 
  ;;nodes that cause the state loop can be stored.
  (declare (type applied-op-node node))
  "Check if there is a state loop going on"
  (let ((result
	 (unzip-states-loop-p
	  (a-or-b-node-parent node)
	  (reduce #'union
		  (mapcar #'op-application-delta-adds (a-or-b-node-applied node)))
	  (reduce #'union
		  (mapcar #'op-application-delta-dels (a-or-b-node-applied node))))))

    (when result

	  ;;Peter 7/8/94:  Here save nodes that cause state loop
	  (push (cons node result) 
		(getf (problem-space-plist *current-problem-space*) 
		      :loop-pairs))
	  t)))


(defun unzip-states-loop-p (node adds dels)
  (declare (type (or nexus null) node)
	   (list adds dels))
  "Recursively unzip the state, checking to see if we loop"

  (cond ((null node) nil)
	;;Peter 7/8/94:  Following line changed to return the node that
	;;               causes the loop.
	((and (null adds) (null dels)) (find-node (1+ (nexus-name node))))
	((typep node 'a-or-b-node)
	 (let ((all-adds (reduce #'union
				 (cons adds
				       (mapcar #'op-application-delta-adds
					       (a-or-b-node-applied node)))))
	       (all-dels (reduce #'union
				 (cons dels
				       (mapcar #'op-application-delta-dels
					       (a-or-b-node-applied node))))))
	   (unzip-states-loop-p (nexus-parent node)
				(set-difference all-adds all-dels)
				(set-difference all-dels all-adds))))
	(t
	 (unzip-states-loop-p (nexus-parent node) adds dels))))

;-----------------------------------------------------------------------------

;Just changed to reset :loop-pairs between runs.

(defun run
  (&key (current-problem (current-problem))
	search-default
	depth-bound
	max-nodes
	time-bound
	output-level
	(permute-application-order :not-set)
	abstraction-level
	(compute-abstractions
	 (problem-space-property :compute-abstractions))
	(shortest (problem-space-property :shortest))
	(multiple-sols (problem-space-property :multiple-sols))
	same-objects)
  "This function solves the problem! (Yeah, right.)
It initialises for problem solving and then calls main-search, which
manages everything."
  (declare (special *current-problem-space* *last-result-obtained* ))

  ;; 95/10/4 Karen: in event-driven lisp, I need to know if
  ;; prodigy is actually running.
  (setf *prodigy-running* t)

  (setf *dont-ask-and-find-all* nil);;alicia

  (setf *last-result-obtained* nil) ; RDS 93/12/11

  (setf *incrementally-create-objects* same-objects)

  ;; First check that load-domain has been called, and a problem loaded.
  (unless (problem-space-property :domain-loaded)
    (cerror "Optionally call load-domain and continue"
	    "It doesn't seem as though you called load-domain")
    (setf same-objects nil)
    (if (y-or-n-p "Call load-domain? ")
	(load-domain)
      (format t "If this breaks call (load-domain) and start again")))
  (unless current-problem
    (setf same-objects nil)
    (cerror "Load a problem and continue" "There is no specified problem.")
    (format t "Specify a file to load: (complete path please) ~%")
    (load (read-line)))

  ;; Set the value for the output level for this run.
  (if (or (and (integerp output-level)
	       (>= output-level 0)
	       (<= output-level 3))
	  (and (null (problem-space-property :*output-level*))
	       (or output-level (setf output-level 2))))
      (setf (problem-space-property :*output-level*) output-level))

  ;; Ok, we carried on, so load the new problem
  ;; (also resetting the problem space)
  (if same-objects
      (load-problem-same-objects current-problem (not compute-abstractions))
    (load-problem current-problem (not compute-abstractions)))

  ;; Now we annotate preconditions with their abstraction levels
  ;; so as to make planning at different levels faster.
  (add-abstraction-levels-to-operators *current-problem-space*)
  (cond ((numberp abstraction-level))
	((numberp (abs-level))
	 (setf abstraction-level (abs-level)))
	(t;; otherwise set to highest interesting level
	 (setf abstraction-level
	       (max-abs
		(getf (rule-plist
		       (rule-name-to-rule '*finish* *current-problem-space*))
		      :annotated-preconds)))))

  (let ((done-goal (instantiate-consed-literal (list 'done))))
    
    ;; Make "done" be the top level goal
    (setf (literal-goal-p done-goal) (list :top-level-goal))

    ;; We'll set the goal node by hand (see function top-nodes).
    (setf (problem-space-expanded-goals *current-problem-space*)
	  (list done-goal)))

  ;; If there are no control rules for nodes, or if a search-method
  ;; has been explicitly requested, set up here to miss out the usual
  ;; search control and go for a (hopefully) faster version.
  (if (and (null search-default)
	   (null (problem-space-select-nodes *current-problem-space*))
	   (null (problem-space-reject-nodes *current-problem-space*))
	   (null (problem-space-prefer-nodes *current-problem-space*)))
      (setf search-default :depth-first))
  (setf (problem-space-property :search-default) search-default)

  ;; Daniel. It was not set before
  (setf (problem-space-property :multiple-sols) multiple-sols)

  ;; Jim. Changed to only set the flag if this key is used in the call.
  (unless (eq permute-application-order :not-set)
    (setf (problem-space-property :permute-application-order)
	  permute-application-order))

  ;; Use the depth-bound installed in the problem space, or default to
  ;; 100 if none. Changed to 100 from 30 [cox]
  (if (null depth-bound)
      (setf depth-bound
	    (or (problem-space-property :depth-bound) 100)))
  
  (setf *all-solutions* nil);;it may have some from previous runs

  ;;Peter 7/9/94:  Reset the loop-data from previous runs
  (setf	(getf (problem-space-plist *current-problem-space*) :loop-pairs)
	nil)
  (setf *last-to-be-executed* 0)
   
  ;;Do not automatically ask the user [cox]
;  (setf *ask* t)
  (setf *execution-queue* nil)
  (setf *ex* t)
  (setf *always-ignore-bad-goals* t)
  ;; end peter
  
  ;; Compute the static part of the information for eager inference
  ;; rules. Has to be computed after function top-nodes is called,
  ;; because it may need the predicates added/deleted by static-eager
  ;; inference rules. 
  ;; This should be called before (top-nodes abstraction-level) is
  ;; called. 
  (dolist (rule (problem-space-eager-inference-rules *current-problem-space*))
    (unless (static-inference-rule-p rule)
      (setf (getf (rule-plist rule) :possible-bindings)
	    (get-possible-bindings rule))))

  ;; Install the first two nodes in the path, which are the operator
  ;; and null bindings for *finish*. Then run the recursive search
  ;; the binding node as the most recently selected for attention.
  (let* ((*node-counter* 0)
	 (start-node (top-nodes abstraction-level))
	 (initial-time (get-internal-run-time)))
    (declare (special *node-counter* *prodigy-handlers*)
	     (type nexus start-node))

    (add-handlers max-nodes depth-bound time-bound)
    ;; (setf (problem-space-property :next-thing) nil)

    ;; initialise the pending goals list
    (setf *pending-goals* (list :pending-goals-head))

    ;; This signal provides a way for users to add code that gets
    ;; called at the start of any run. No data passed as yet.
    (prod-signal :start-run)
    
    ;; Ok, go for it.
    (let* ((intermediate
	    (cond ((and shortest multiple-sols)
		   ;; RDS 93/08/18.  User wants to search for shortest plan.
		   (run-shortest-multiple start-node depth-bound))
		  (shortest
		   (run-shortest start-node depth-bound))
		  (multiple-sols
		   (run-multiple-sols start-node depth-bound))
		  (t
		   (let* ((result (main-search
				   start-node start-node 2 depth-bound))
			  (plan (prepare-plan result)))
		     ;; Print the plan nicely
		     (if plan (announce-plan plan))
		     (or plan result)))))
	   (time (float (/ (- (get-internal-run-time) initial-time)
			   internal-time-units-per-second)))
	   (solutionp (solutionp intermediate *all-solutions*))
	   (solutions (if solutionp
			  (get-solutions intermediate *all-solutions*)))
	   (number-solutions (length solutions)))

      ;; Set the fields of the result structure
      (setf (user::prodigy-result-problem *prodigy-result*) current-problem)
      (setf (user::prodigy-result-time *prodigy-result*) time)
      (setf (user::prodigy-result-nodes *prodigy-result*) *node-counter*)
      (setf (user::prodigy-result-solutionp *prodigy-result*) solutionp)
      (setf (user::prodigy-result-solution *prodigy-result*)
	    (car (last solutions)))

      ;; They are reversed so that they are stored in the order in which
      ;; they were achieved
      (setf (user::prodigy-result-solutions *prodigy-result*)
	    (reverse solutions))
      (setf (user::prodigy-result-number-solutions *prodigy-result*)
	    number-solutions)
      (setf (user::prodigy-result-interrupt *prodigy-result*)
	    (car intermediate))
      (setf (user::prodigy-result-whole-tree-expanded-p *prodigy-result*)

					; Changed the following so that it works with :shortest as well.
					; RDS 93/12/11
	    ;;            (cond ((problem-space-property :multiple-sols)
	    ;;                   (not *user-aborted-search*))
	    ;;                  ((problem-space-property :shortest))))
	    (whole-tree-expanded-p
             (if shortest *last-result-obtained* intermediate)))

      ;; Cumulative data
      (incf (user::prodigy-result-acc-runs *prodigy-result*))
      (incf (user::prodigy-result-acc-time *prodigy-result*) time)
      (incf (user::prodigy-result-acc-nodes *prodigy-result*) *node-counter*)
      (incf (user::prodigy-result-acc-solutions *prodigy-result*)
	    number-solutions)
      ;; For now we do not execute the remaining part of the plan. There is a
      ;; bug in how it maintains the state. [10oct97 cox]
;      (execute-rest (user::find-node *node-counter*))
      (setf *prodigy-running* nil)
      *prodigy-result*)))


(defun execute-rest (final-node)
  ;;This is the function that executes the rest
  ;;of a plan when planning is done.

					;  (format t "Execute the rest of the plan (y/n)?  ")
					;  (when (string= (read) 'y)    ... )
  (let ((fail nil))
    (setf *ask* nil)
    (setf *always-ignore-bad-goals* t)
    (terpri)
      
    (do* ((exec-op (get-executable final-node) (get-executable final-node))
	  ;;to test whether they're true at the execution time
	  (inst-op (when exec-op
			 (p4::applied-op-node-instantiated-op exec-op))
		   (when exec-op
			 (p4::applied-op-node-instantiated-op exec-op)))
	  ;; changed this so that the "forall" and "exists" get dealt with
	  ;; process-all-precond-list eliminates "and"s but none of the "or"s

	  ;; we don't want to do this if nothing executable!
	  (exec-preconds (when exec-op
			       (user::process-all-precond-list
				(binding-node-instantiated-preconds 
				 (instantiated-op-binding-node-back-pointer
				  inst-op))
				inst-op))
			 (when exec-op
			       (user::process-all-precond-list
				(binding-node-instantiated-preconds 
				 (instantiated-op-binding-node-back-pointer
				  inst-op))
				inst-op)))
	  (done nil))
	 ((or done (null exec-op)) nil)

	 ;;This seems to acurately get to the state right before
	 ;;exec-op was applied, including state changes that have
	 ;;happened on later execution.
	 ;; Commented out [10oct97 cox]
;	 (state-at-nodete-at-node (find-node (1- (nexus-name exec-op))))
	
	 (unless
	  (preconds-true-in-state exec-preconds)
	  (setf done t)			     
	  (setf fail t)
	  (format t "~%***FAILURE!!!***~%Due to a change in state, ")
	  ;; Changed to print exec-op [10oct97 cox]
	  (format t "the next step in the plan (~s) is not executable." exec-op)
	  (terpri))
	
	 ;;don't really need to do eveything done
	 ;;by do-execute, which calls other functions.
	 ;;but it does the trick.
	 (unless done
		 (do-execute-op-at-end final-node exec-op nil)
		 (change-state-on-execute exec-op)
		 (format t "~%")
		 (format t "   ")      
		 (brief-print-inst-op 
		  (applied-op-node-instantiated-op exec-op))
		 (terpri)))

    ;;out of do loop
    (let ((final-finish (car (p4::nexus-children (find-node 3))))
	  )
      ;; Commented out [10oct97 cox]
;      (state-at-node final-node)
      (unless
       (or fail
	   (preconds-true-in-state
	    (user::process-all-precond-list
	     (binding-node-instantiated-preconds final-finish)
	     (p4::applied-op-node-instantiated-op final-node))))
       (format t "~%***FAILURE!!!***~%Due to a change in state, ")
       (format t "the plan does not succeed.")
       (terpri))))
  )

;; this function returns "T" if all the preconds are true in the state
;; it works for most precond expressions. Caveats on forall and exists.

(defun preconds-true-in-state (preconds)
  (let ((state-mirror (cons 'and
			    (user::create-state-p-mirror
			       preconds
			       (give-me-nice-state)))))
  (eval state-mirror)))

(defun change-state-on-apply (node &optional (appl nil))
    (if *mike-trace* 
      (break "~%In FN change-state-on-apply~%NODE: ~S~%" node))
  nil)

;;; Changed [cox]
(defun change-state-on-execute (node &optional (appl nil))
  (if *mike-trace* 
      (break "~%In FN change-state-on-execute~%NODE: ~S~%" node))
;  (state-at-node (find-node (1- (nexus-name node))))
  (format t "~%EXECUTING operator ~s~%" (applied-op-node-instantiated-op node))
  )

;;; Added [9oct97 cox]
(defparameter *do-execute* t
  "If t, then allow step execution.")

(defun automatically-decide-to-execute (exec-op &optional (do-execute *do-execute*))
  ;; let's make it default to ask.
  ;; the user can overwrite this function in the same way as change-state...

;;;;******Here ask about applicable ops too.  If there's a choice, ask
;;;;******about all of them.  If one's selected, apply AND execute it. (how?)
;;;;******only make this change if *smart-apply-p* is true.
  (if do-execute
      (let ((already-asked (member exec-op *already-asked* :test #'same-operator?)))
	(cond ((and *ask*
		    (or *ask-each-time*
			(not already-asked)))

	       (push exec-op *already-asked*)
    
	       (format t "~% Should I execute ")
	       (brief-print-inst-op (applied-op-node-instantiated-op exec-op))
	       (format t " at node ~D (y/n/no-more)?  " (applied-op-node-name exec-op))
	       (setf ans (read))
	       (cond ((string= ans 'y)
		      t)
		     (t
		      (when (string= ans 'no-more)
			    (setf *ask* nil))
		      nil)))
	      (;; Execute if the operator is a deployment operator. [cox 2oct97]
	       (and
		*use-deployment-heuristic*
		(deployment-op-p exec-op))))))
  )



(defun deployment-op-p (node)
  (case (type-of node)
	    ((applied-op-node)
	     (if (member (operator-name 
			  (instantiated-op-op 
			   (applied-op-node-instantiated-op node)))
			 user::*deployment-operators*)
		 t))
	    ((instantiated-op)
	     (if (member (operator-name 
			  (instantiated-op-op 
			   node))
			 user::*deployment-operators*)
		 t)))
  )





;;=======
;; push into queue rather than stack

(defun q-push (elt l)
  (nconc l (list elt)))



