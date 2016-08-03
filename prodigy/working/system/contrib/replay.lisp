;;; Purpose: 
;;; Code to replay a plan, given as a list of instantiated operators.
;;; Inference rules may be omitted.

;;; *****************************************************************
;;; Author: Alicia Perez
;;; Send bugs and suggestions to aperez@cs.cmu.edu
;;; Change Log: none yet

;;; ***************************************************************** 
;;; Documentation:

;;; The plan only needs to contain operators, as this code was
;;; created to replay an expert-given solution.

;;; This code will find and fire the relevant inference rules. The
;;; eager rules fire eagerly (i.e. all the eager rules fire when the
;;; state changes). The lazy rules fire on demand: if an operator
;;; precond is not true in the state, we try to achieve it by applying
;;; rules (possibly recursively). 

;;; - when I use this the same objects persist through problem runs so
;;; this code may use Mei's matcher.
;;; In the first approach to write this code I kept a list of literals in
;;; the state, instead of using Prodigy state keeping mechanism (in
;;; hash tables) and kind of wrote a new maching code. However this is
;;; very inefficient and I wanted to take advantage of Mei's matcher!
;;; (note that although you create two objects with the same name,
;;; they don't match). See the comments before function replay-op.

;;; Then I made additions to the code so the objects from the last run
;;; are not  deleted but reused when the initial state is reset.
;;; Still the all state keeping is around and the
;;; check is duplicated (for both state representations) in kind of a
;;; testing phase (that is what function trick-to-test does). I will
;;; remove the state keeping in the future.  

;;; As side effects:
;;; -- *expert-plan-steps* contains operators and lazy inference rules
;;; obtained by executing the plan. It is a list of plan-step
;;; structures that may be used directly by the partial order
;;; generator: to get the partial order call (in P4 package):
;;;
;;;   (build-partial *expert-plan-steps* (get-initial-state))
;;;
;;; If you are not loading the partial order code, you should comment
;;; those lines  (where create-expert-plan-step is called)

;;; -- *expert-sol*: ops and lazy inference rules obtained by
;;; executiong the ops in *expert-sol-ops*. It is a list of
;;; instantiated-ops. Note that the initial
;;; plan did not have to contain inference rules but only operators.

(in-package "PRODIGY4")

(defvar *expert-sol* nil
  "list of instantiated operators corresponding to operators and lazy
inference rules, obtained by executiong the ops in *expert-sol-ops*")

(defvar *expert-plan-steps* nil
  "list of structures of type plan steps in order to build the partial
order of the expert's solution")


;;; *********************************************************
;;; Set the initial state
;;; (current-problem) returns the "problem" structure with fields name,
;;; goal state objects plist

(defun set-initial-state-and-goal ()
  ;;see why this is needed in run-same-objects.lisp
  (delete-literals-from-state)

  ;;here I have to load the state, but the state macro calls
  ;;clear-assertion-hash and deletes the literals. I don't want this
  ;;because then the lits in the expert sol, that remain for different
  ;;runs, will not match.
  (eval (cons 'state-keep-lits
	      (cdr (problem-state (user::current-problem)))))
  
  ;;I am not sure if the goal is needed when the rules are fired
  (prog1
      ;;if I eval the goal, I get the *finish* operator (but it does
      ;;not have the generator for quantified vars yet)
      (if (eq (length  (problem-goal (user::current-problem))) 2)
	  (second (problem-goal (user::current-problem)))
	;;it means an exists
	(list 'user::exists
	      (second (problem-goal (user::current-problem)))
	      (third  (problem-goal (user::current-problem)))))
    (fire-static-eager-inference-rules)))

;;create my own macro so it will not clear-assertion-hash

(defmacro state-keep-lits (consed-literals)
  `(prog nil
;    (clear-assertion-hash *current-problem-space*)
    ,(cond ((eq (car consed-literals) 'user::and)
	    `(mapcar #'instantiate-consed-exp ',(cdr consed-literals)))
	   ((consp (car consed-literals))
	    `(mapcar #'instantiate-consed-exp ',consed-literals))
	   ((symbolp (car consed-literals))
	    `(instantiate-consed-exp ',consed-literals))
	   (t
	    (error "~&Bad state in ~S.~%" consed-literals)))))

;;; *********************************************************
;;; Args: solution: list of instantiated-ops (for example (cdr (run)))
;;;       verbose: if T, prints info about op applications

(defun test-plan (solution &key verbose)
  (declare (list solution)
	   (special *expert-sol*))
  ;;solution is a list of instantiated-ops
  (let ((*verbose-replay* verbose))
    (declare (special *verbose-replay*))
    (setf *expert-plan-steps* nil)
    (setf *expert-sol* nil)
    ;;this will set *expert-plan-steps* and *expert-sol* as side
    ;;effect 
    (format t "~%Testing the expert solution...~%~%")
    (cond
      ((true-goal-p
	;;this returns the goal
	(set-initial-state-and-goal)
	;;and this returns the final state
	(execute-plan
	 solution (replay-eager-inference-rules (give-me-nice-state))))
       (format t " The plan given is a solution to the current problem.~%")
       t)
      (t nil))))


;; applies the plan while it can, i.e. while the preconditions
;; of the steps of the plan are true at the time of execution
;; of that step.
;; Plan is a list of instantiated-ops.

(defun execute-plan (plan state)
  ;;returns the state after applying as many ops as possible
  (declare (list plan state)
	   (special *verbose-replay*))
  ;;plan is a list of instantiated-ops: (cdr (run))
  (cond
   ((null plan) state)
   ((and (or (null *verbose-replay*)
	     (null (format t "~%Checking step ~S." (car plan))))
	 (not (replay-applicable-p (car plan) state))
	 ;;try to make it applicable. If succeeds, update state with
	 ;;rule application, and return nil to execute next branch of
	 ;;cond and apply the operator
	 (let ((new-state 
		(lazy-to-make-op-applicable-p (car plan) state)))
	   (if new-state
	      (progn (setf state new-state) nil)
	      t)))
    (format t "~% Step ~S was not applicable.~%" (car plan)))
   (t (let ((new-state (replay-op (car plan) state)))
	(if *verbose-replay* (format t "   Step ~S executed.~%~%" (car plan)))
	(setf new-state (replay-eager-inference-rules new-state))
	(execute-plan (cdr plan) new-state)))))

(defun true-goal-p (goal state)
  (cond
   ((null state) nil)
   ((equal (car goal) 'user::exists)
    ;;first find all the possible bindings
    (let ((data
	   (mapcar
	    #'(lambda (var-spec)
		(mapcan #'get-values-from-types
			(make-type-list (second var-spec))))
	    (second goal))))
      ;;this is copied from replay-check-exists-precond
      (do* ((choice (make-list (length data) :initial-element 0)
		    (increment-choice choice data))
	    (exists-bindings (choice-bindings goal data choice)
			     (choice-bindings goal data choice)))
	   ((null choice) nil)
	(if (replay-check-applicable-r
	     (third goal) state (mapcar #'cdr exists-bindings)
	     nil nil exists-bindings)
	    (return t)))))
   (t (replay-check-applicable-r goal state nil nil nil nil))))


;;; *******************************************************
;;; Code to replay an operator. Similar to "apply-op".
;;; The reason why I have copied and adapted so many functions is that
;;; the literals that are used in ops in the expert solution do not
;;; "equal" the ones in the state (state is created by loading the
;;; problem and new instances are defined). Therefore it is not
;;; enough to test the literal-state-p slot or the hash tables to
;;; find out if a literal is true in the state.

;;; I keep the state in a list of literals, and to test membership I
;;; use the prodigy-names of the objects. This is very inefficient
;;; but... 

;;; Keep the plan steps in *expert-plan-steps* to obtain a partial
;;; order

(defun replay-op (inst-op state)
  (declare (type instantiated-op inst-op)
	   (list state) ;list of literals as returned by
			 ;give-me-nice-state
	   (special *expert-sol*))
  (let* ((op (instantiated-op-op inst-op))
	 (vars (rule-vars op))
	 (values (instantiated-op-values inst-op))
	 (precond-bindings
	  (precond-bindings vars values)))

    ;; Iterate over the del-list and add-list of the operator. For each
    ;; one, find the associated literal in the state and do the dirty.
    ;; We have to work out what literals to fire first, in case there
    ;; are bindings, and firing off one lot alters the bindings of the
    ;; other. If that is the case, it matters what order the adds and
    ;; dels are in, but we don't preserve that order. I do the del's
    ;; first so that if a literal is in both lists, it stays around.

    ;;This updates inst-op adding values for vars still unbound
    (let ((deletees
	   (replay-process-list op (operator-del-list op) inst-op nil
				precond-bindings state))
	  (addees
	   (replay-process-list op (operator-add-list op) inst-op t
				precond-bindings state))
	  delta-dels delta-adds)
      (dolist (dellit deletees)
	;;check first if value actually changes
	(let ((lit-in-state (literal-in-replay-state-p dellit state)))
	  (when lit-in-state
;	    (format t "Deleting ~A from the state.~%" lit-in-state)
	    (setf state (set-replay-state-p lit-in-state state nil))
	    (push dellit delta-dels))))
      (dolist (addlit addees)
	;;check first if value actually changes
	(let ((lit-in-state (literal-in-replay-state-p addlit state)))
	  (when (not lit-in-state)
;	    (format t "Adding ~A to the state.~%" addlit)
	    (setf state (set-replay-state-p addlit state t))
	    (push addlit delta-adds))))
      (when (or (not (inference-rule-p op))
		(equal (getf (operator-plist op) :mode) :lazy))
	;;store it only if it is an operator or a lazy inference rule
	(push inst-op *expert-sol*)
	;;uncomment the next two lines (and the code at the end of
	;;this file) if you will want to build the partial order of
	;;the tested solution 
	;;(push (create-expert-plan-step inst-op delta-adds delta-dels)
	;;      *expert-plan-steps*)
	)
      state)))

;;; modified from apply.lisp	

;************************************************************
; The following describes how effects are executed when applying an operator.
;
; for each effect in the effects list, 
; if it is a conditional effect,
; then:  the bindings for variables in the effect come from both the
; bindings generated by function (generate-bindings ...) and matching
; the conditional against the state;
; else: it just comes from the original bindings.
; If there are still unbound variables, generate bindings for each
; variable and form the cross product of these variables.
; (form-all-bindings ...)
; for each binding, push the result of instantiating the effect into res.
; ************************************************************

(defun replay-process-list (op effects instop addingp orig-binds state) 
  (declare (list effects)
	   (ignore addingp)
	   (special *current-problem-space*))
  ;;effects is a list of effects grouped (listed) by conditional.
  ;;state is needed to check the preconds of the conditional effects.
  (let ((res nil))
    (dolist (conditional-group effects)
      (let* ((conditional (effect-cond-conditional (car conditional-group)))
	     (bindings (if conditional 
			   ;;check if precond of cond effect is true
			   ;;in the state, and return the bindings
;			   (descend-match (second conditional) node orig-binds)
			   (check-cond-effect-precond
			    (second conditional) state orig-binds)
			 (list orig-binds))))
	(when bindings
	    (dolist (effect-cond conditional-group)
	      
	      (let* ((orig-consed-lit (effect-cond-effect effect-cond))
		     (pred-head (car orig-consed-lit))
		     (pred-body
		      (mapcar #'(lambda (x)
				  (if (strong-is-var-p x) x
				      (object-name-to-object
				       x *current-problem-space*)))
			      (cdr orig-consed-lit)))
		     (bound-vars (mapcar #'(lambda (x) (car x))
					   (first bindings)))
		     (used-vars (mapcan #'(lambda (x)
					    (if (strong-is-var-p x)
						(list x)))
					pred-body))
		     (relevant-vars (if used-vars
					(get-depending-vars used-vars op)))
		     (augmented-bindings 
		      (form-all-bindings
		       bound-vars relevant-vars op bindings)))

		(dolist (final-binding augmented-bindings)
		  (push (instantiate-literal
			 pred-head (sublis final-binding pred-body))
			res)
		  ))))))
    res))


(defun literal-in-replay-state-p (literal state)
  (declare (type literal literal))
  ;;return corresponding literal in state if found
  ;;expensive but safe way!
  ;;adapted from my-literal-in-state-p
  (find literal state :test #'same-literal-p))

(defun same-literal-p (literal entry-lit)
  (and (eq (literal-name literal)
	   (literal-name entry-lit))
       (every #'(lambda (arg1 arg2)
		  ;each arg is either a number (inf type) or a
		  ;prodigy-object 
		  (or (eq arg1 arg2)
		      (and (not (or (numberp arg1)(numberp arg2)))
			   (eq (prodigy-object-name arg1)
			       (prodigy-object-name arg2)))))
	      (literal-arguments entry-lit)
	      (literal-arguments literal))))

(defun lit-equals-list-p (list state-lit)
  (declare (list list)
	   (type literal state-lit))
  (and (eq (car list) (literal-name state-lit))
       (every #'(lambda (arg1 arg2)
		  (if (symbolp arg1)
		      (eq arg1 (prodigy-object-name arg2))
		    (equal arg1 arg2)))
	      (cdr list)(literal-arguments state-lit))))

(defun set-replay-state-p (literal state addingp)
  ;return state
  (declare (special *verbose-replay*))
  (if *verbose-replay*
      (format t "~A ~A ~A the state.~%"
	      (if addingp "Adding" "Deleting") literal
	      (if addingp "to" "from")))
  ;;updating Mei's state
  (set-state-p literal addingp)
  ;;updating state as a list
  (if addingp (cons literal state)
    (remove literal state :test #'same-literal-p :count 1)))

;;; *******************************************************
;;; Functions to check op applicability
;;; (adapted from find-asking2.lisp) 

(defun replay-applicable-p (instop state)
  (declare (type instantiated-op instop)
	   (list state))
  "checks if instop is applicable in the current state"
  (let* ((expr (instantiated-op-precond instop))
	 (values (instantiated-op-values instop))
	 (op (instantiated-op-op instop)))
    (or (null expr)
	(replay-check-applicable-r
	 expr state values op t
	 (mapcar #'(lambda (varspec val)
		     (cons (first varspec) val))
		 (second (rule-precond-exp op)) values)))))

;;;From my-check-applicable-r


(defun replay-check-applicable-r  (expr state values op parity bindings)
  (declare (special *verbose-replay*))
  (cond ((typep expr 'literal)
	 (trick-to-test expr state)
	 (or (literal-in-replay-state-p expr state)
	     ;;don't print message if it corresponds to a negated precond
	     (if (and parity (not (inference-rule-p op)) *verbose-replay*)
		 (format t "~%~%Precondition ~A is false in state.~%" expr))))
	((eq (car expr) 'user::~)
	 (not (replay-check-applicable-r
	       (second expr) state values op (not parity) bindings)))
	((eq (car expr) 'user::and)
	 (every #'(lambda (piece)
		    (replay-check-applicable-r
		     piece state values op parity bindings))
		(cdr expr)))
	((eq (car expr) 'user::or)
	 (some #'(lambda (piece)
		   (replay-check-applicable-r
		    piece state values op parity bindings))
	       (cdr expr)))
	((eq (car expr) 'user::forall)
	 (replay-check-forall-precond
	  expr state values op parity bindings))
	((eq (car expr) 'user::exists)
	 (replay-check-exists-precond
	  expr state values op parity bindings))	     
	;;literal but expressed as a list fully instantiated
	((and (typep expr 'list)
	      (member (car expr)
		      (problem-space-all-preds  *current-problem-space*))
	      (not (some #'is-variable-p (cdr expr))))
	 
;this only to test	 
	 (trick-to-test (instantiate-consed-literal expr) state)
	 
	 (or (find expr state :test #'lit-equals-list-p)
	     (if (and parity (not (inference-rule-p op)) *verbose-replay*)
		 (format t "~%~%Precondition ~A is false in state:" expr))))
	;;literal but expressed as a list and not fully instantiated
	((and (typep expr 'list)
	      (member (car expr)
		      (problem-space-all-preds  *current-problem-space*)))
	 ;;first instantiate all variables
	 (setf expr (substitute-binding expr bindings))
	 
;this only to test	 
	 (trick-to-test (instantiate-consed-literal expr) state)
	 
	 ;;then do the same as in previous case
	 (or (find expr state :test #'lit-equals-list-p)
	     (if (and parity (not (inference-rule-p op)) *verbose-replay*)
		 (format t "~%~%Precondition ~A is false in state:" expr))))	      
	(T (error "Op preconds are too complicated"))))

(defun replay-check-forall-precond
  (expr state values op parity bindings)
  ;;checks the body with all possible bindings for the quantified variables.
  ;;assoc finds quantifier generator for this forall (there may be
  ;;several foralls in the operator) and then funcall gets all
  ;;the possible bindings for each the vars
  (do* ((gen (cdr (assoc (second expr)
			 (getf (rule-plist op) :quantifier-generators))))
	(data (if gen (funcall gen nil)))
	(choice (make-list (length data) :initial-element 0)
		(increment-choice choice data))
	(forall-bindings (choice-bindings expr data choice)
			 (choice-bindings expr data choice)))
      ((null choice) t)
    (or (replay-check-applicable-r
	 (third expr) state
	 (append values (mapcar #'cdr forall-bindings))
	 op parity 
	 (append bindings forall-bindings))
	(return nil))))

(defun replay-check-exists-precond
  (expr state values op parity bindings)
  ;;checks the body with all possible bindings for the quantified variables.
  ;;assoc finds quantifier generator for this exists (there may be
  ;;several exists in the operator) and then funcall gets all
  ;;the possible bindings for each the vars
  (do* ((gen (cdr (assoc (second expr)
			 (getf (rule-plist op) :quantifier-generators))))
	(data (if gen (funcall gen nil)))
	(choice (make-list (length data) :initial-element 0)
		(increment-choice choice data))
	(exists-bindings (choice-bindings expr data choice)
			 (choice-bindings expr data choice)))
      ((null choice) nil)
    (if (replay-check-applicable-r
	 (third expr) state
	 (append values (mapcar #'cdr exists-bindings))
	 op parity 
	 (append bindings exists-bindings))
	(return t))))

;;; *********************************************************
;;; Functions to apply the eager inference rules

;;; functions adapted from apply.lisp
;;; Note that:
;;; - the rules may chain
;;; - the state is a list of literals (I don't use hash tables)

;;; I think each rule may be applied with (replay-op rule state)

(defun replay-eager-inference-rules (state)
  "fires all the applicable  eager inference rules and returns
the resulting state"
  ;;does not consider that rules may chain
  (dolist
      (rule
	(problem-space-eager-inference-rules *current-problem-space*)
	state)
    (if (not (static-inference-rule-p rule))
	(setf state (replay-eager-inference-rule rule state)))))

(defun replay-eager-inference-rule (rule state)
  (declare (special *current-problem-space* *verbose-replay*))
  (if *verbose-replay*
      (format t "Testing eager rule ~A." (rule-name rule)))
  ;;The possible bindings are stored in the eager inference rules
  ;;(but not in the lazy ones)
  (dolist (values (getf (rule-plist rule) :possible-bindings)
	   (progn (if *verbose-replay* (terpri)) state))
      ;; Check if each binding works
      (cond
       (;; this does not consider foralls, etc (see apply.lisp)
	 ; (check-binding values rule)
	(replay-check-applicable-r
	 (third (rule-precond-exp rule))
	 state values rule t
	 (mapcar #'(lambda (varspec val)
		     (cons (first varspec) val))
		 (second (rule-precond-exp rule)) values))
	(if *verbose-replay*
	    (format t ".. Fired.")) ;eager rule ~A.~% (rule-name rule)
	(setf state
	      (replay-op (make-instantiated-op :op rule :values values)
			 state)))
       (t nil))));;if the rule does not fire, preserve the state


;;; *********************************************************
;;;for testing only

(defun trick-to-test (literal state)
  (declare (type literal literal)
	   (list state))
  (let ((val-in-list-state (literal-in-replay-state-p literal state))
	(val-in-Mei-state (literal-state-p literal)))
    (cond
      ((and val-in-list-state val-in-Mei-state)
;       (format t "Good pos values for ~A!~%" literal)
       )
      ((and (not val-in-list-state)(not val-in-Mei-state))
;       (format t "Good neg values for ~A!~%" literal)
       )
      (val-in-list-state
       (format t "Match failed for ~A! True in list state only~%" literal)
       (break))
      (t (format t "Match failed for ~A! True in Mei state only~%" literal)
	 (break)))))

;;; *********************************************************
;;; Functions to apply selectively the lazy inference rules

;;; We'll try to apply only the lazy rules that are relevant for the
;;; current operator, but without worrying too much if non-relevant
;;; rules get fired. To select rules do backchain on the op preconds
;;; that are not true in the current state


(defun lazy-to-make-op-applicable-p (instop state)
  ;;try to make it applicable. If succeeds, return the updated state
  (declare (type instantiated-op instop)
	   (list state))
  (let* ((expr (instantiated-op-precond instop))
	 (values (instantiated-op-values instop))
	 (op (instantiated-op-op instop))
	 (bindings
	  (mapcar #'(lambda (varspec val)
		      (cons (first varspec) val))
		  (second (rule-precond-exp op)) values)))
;    (format t "~A" (rule-name (instantiated-op-op instop)))
    ;;expr is either a single literal or a conjunction of literals. It
    ;;may also be a conjunction wher some conjunct is also a
    ;;conjunction (if the cond effect preconds make it to the precond
    ;;expr in the instop)
    (if (not (listp expr))(setf expr (list expr))) ; single literal
    (lazy-to-add-precs-p expr state values op bindings)))

(defun lazy-to-add-precs-p (expr state values op bindings)
  ;;If this succeeds on making the preconditions true, return the
  ;;updated state.
  ;;this assumes that if a rule fires it will not undo other
  ;;previously achieved preconditions
  
;for testing only
  (cond ((typep (car expr) 'literal)
	 (trick-to-test (car expr) state))
	((and (listp (car expr))
	      (eq (caar expr) 'user::~) ;negated literal
	      (typep (second (car expr)) 'literal))
	 (trick-to-test (second (car expr)) state))
	(t nil))
  
  (cond
    ((null expr) state)
    ((eq (car expr) 'user::and)
     (lazy-to-add-precs-p (cdr expr) state values op bindings))
    ;;if precondition is true
    ((and (typep (car expr) 'literal)
	  (literal-in-replay-state-p (car expr) state))
     (lazy-to-add-precs-p (cdr expr) state values op bindings))
    ;;if (negated) precondition is true
    ((and (listp (car expr))
	  (eq (caar expr) 'user::~) ;negated literal
	  (typep (second (car expr)) 'literal)
	  (not (literal-in-replay-state-p (second (car expr)) state)))
     (lazy-to-add-precs-p (cdr expr) state values op bindings))
    ;;if the first precond is a list of literals (maybe with and)
    ((listp (car expr))
     (let ((new-state
	    (lazy-to-add-precs-p (car expr) state values op bindings)))
       (cond
	 (new-state (setf state new-state)
		    (lazy-to-add-precs-p (cdr expr) state values op bindings))
	 (t nil)))) ;we failed in making the first part of exp true.
    ;;precondition is false
    ((let ((new-state
	    (lazy-to-add-prec-p (car expr) state)))
     ;; we succeeded in making precond true; update state
       (if new-state  (setf state new-state)))
     ;;and continue with the other preconds
     (lazy-to-add-precs-p (cdr expr) state values op bindings))
    (t nil)));we failed in making precondition true

(defun lazy-to-add-prec-p (prec state)
  ;;If this succeeds on making the precondition true, return the
  ;;updated state.
  (let* ((negatedp (and (listp prec)(eq (car prec) 'user::~)))
	 (rel-rules
	  ;;find relevant operators and retain only lazy inference
	  ;;rules
	  (copy-list ;as done in get-all-ops
	   (remove-if-not
	    #'(lambda (op-or-rule)
		(and (inference-rule-p op-or-rule)
		     (equal (getf (operator-plist op-or-rule)  :mode)
			    :lazy)))
	    (relevant-operators
	     (literal-name (if negatedp (second prec) prec))
	     *current-problem-space* (if negatedp :del :add)))))
	 (bindings
	  (instantiate-lazy-inf-rules
	   rel-rules (if negatedp (second prec) prec) negatedp state)))
    (dolist (rule bindings)
    ;;now try to apply the rule (assume no backchaining) and if
    ;;succeds, return the new state without trying more rules. 
      (let ((new-state (replay-lazy-inference-rule rule state)))
	(if new-state ;;the rule fired
	    (return new-state))))))

(defun instantiate-lazy-inf-rules (rules prec negatedp state)
  (declare (type literal prec))
  ;;find bindings for the rule to match the prec.
  ;;this returns something similar to what generate-bindings returns
  ;;(a list of instantiated inference rules)
  (let (inst-rules
	(*STATE* state))
    (declare (special *STATE*))
    (dolist (rule rules inst-rules)
      (setf
       inst-rules
       (append
	inst-rules
	(convert-to-instantiated-ops
	 rule
	 ;;from generate-bindings 
	 (get-all-lazy-rule-bindings
	  prec rule (if negatedp (operator-del-list rule)
			(operator-add-list rule)))))))))

(defun get-all-lazy-rule-bindings (goal rule effects)
  (declare (type operator rule)
	   (type literal goal)
	   (list effects))
  (if effects
      (let ((rhs-bindings (find-rhs-bindings (caar effects) goal))
	    (other-bindings
	     (get-all-lazy-rule-bindings
	      goal rule (if (null (cdar effects))
			    (cdr effects)
			    (cons (cdar effects) (cdr effects))))))
	(if (null rhs-bindings) other-bindings
	    (let ((binding1 ;;return all the tuples that satisfy rhs-bindings
		   (all-lazy-rule-bindings rule rhs-bindings)))
	      (cond ((eq (car binding1) t)
		     (or other-bindings binding1))
		    (binding1
		     (append binding1 other-bindings))
		    (t
		     other-bindings)))))))


(defun all-lazy-rule-bindings (rule rhs-bindings)
  ;;return all the tuples that satisfy rhs-bindings
  (scr-select-bindings rule rhs-bindings))

(defun replay-lazy-inference-rule (inst-rule state)
  (declare (special *current-problem-space* *verbose-replay*)
	   (type instantiated-op inst-rule)
	   (list state))
  (let ((values (instantiated-op-values inst-rule))
	(rule (instantiated-op-op inst-rule)))
    (if *verbose-replay*
	(format t "Testing lazy rule ~A... " (operator-name rule)))
    ;; Check if binding works
    (cond
      (;; this does not consider foralls, etc (see apply.lisp)
       ;; (check-binding values rule)
       (replay-check-applicable-r
	(third (operator-precond-exp rule))
	state values rule t
	(mapcar #'(lambda (varspec val)
		    (cons (first varspec) val))
		(second (operator-precond-exp rule)) values))
       (if *verbose-replay* (format t "Fired.~%"))
       (setf state (replay-op inst-rule state)))
      (t (if *verbose-replay* (format t "Not applicable.~%"))))))


;;; ******************************************************************
;;; Functions to check applicability of conditional effects

;;; cannot use replay-check-applicable-r because some vars may be
;;; unbound, and I have to return all the possible bindings.
;;;cannot use descend-match because the state is stored differently. 
;;;I have to do something similar.

;;;The code for my-descend-match will disappear when I clean up the
;;;parts related to keeping the state as a list.

(defun check-cond-effect-precond (ce-precond state orig-binds)
  ;;return a list of binding-lists, with all the possible bindings
  ;;(consider the vars that appear in the cond effect)
  ;;- Orig-bindings is a binding list.
  ;;- ce-precond is not instantiated yet.
;  (break "in check-cond-effect-precond")
  (my-descend-match ce-precond state orig-binds))
#|  (replay-check-applicable-r
   ;;expr has to have the vars replaced
   (second conditional) state (mapcar #'cdr orig-binds)
   nil nil orig-binds))
|#

(defun my-descend-match (expr state bindings)
  ;;returns a list of binding lists
  (cond ((eq expr t) (list bindings))
	((eq (car expr) 'user::and)
	 (my-and-match (cdr expr) state bindings))
	((eq (car expr) 'user::or)
	 (my-or-match (cdr expr) state bindings))
	((member (car expr) '(user::exist user::forall))
	 (error "Sorry, cannot do forall or exists matching yet. ~%"))
	((eq (car expr) 'user::~)
	 (my-negation-match (cadr expr) state bindings))
	(t (let ((vals (my-gen-values expr bindings state)))
	     (cond ((null vals) nil)
		   ((eq vals t) (list bindings))
		   ((mapcar #'(lambda (b)
				(if (listp b)
				    (nconc b bindings)
				    b))
			    vals)))))))


(defun my-gen-values (expr bindings state)
  ;;expr is a list corresponding to one assertion
  ;;check if expr is in the state. If it contains variables, return a
  ;;list of binding lists with all the possible matchings
  (setf expr (sublis bindings expr))
  (if (find-if #'strong-is-var-p expr)
      (break "case not considered"))
  (if (find expr state :test #'lit-equals-list-p) t))


(defun my-and-match (exprs state bindings)
  (cond ((null exprs) (list bindings))
	((null (cdr exprs))
	 (my-descend-match (car exprs) state bindings))
	(t (let ((new-bls 
		  (my-descend-match (car exprs) state bindings)))
	     (and new-bls
		  (mapcan #'(lambda (new-b)
			      (my-and-match (cdr exprs) state new-b))
			  new-bls))))))


(defun my-or-match (expr state bindings)
  (do* ((exp expr (cdr exp))
	(ex (car exp) (car exp))
	(arguments (substitute-binding (cdr ex) bindings))
	(notbound (has-unbound-vars arguments)
		  (has-unbound-vars arguments))
	(result (unless (or notbound (endp exp))
		  (my-descend-match ex state bindings))
		(unless (or notbound (endp exp))
		  (my-descend-match ex state bindings))))
       ((or notbound result (endp exp))
	(if notbound
	    (error "~%MY-OR-MATCH: has unbound vars in expr ~A" expr)
	    (if result (list bindings) nil)))
    ))

;;; negation-match is not used as generator for variables in control rules.
;;; it only returns T or F.

(defun my-negation-match (expr state bindings)
  (cond ((eq expr t) nil)
;	((eq (car expr) 'user::exist)
;	 (my-negated-exists-match expr state bindings))
	((atom (car expr))
	 (my-negated-pred-match expr state bindings))
	(t (error "~% NEGATION-MATCH: bad expression ~A" expr))))


;;; for negation match, after substituting variables in EXP with
;;; BINDINGS, there should NOT be any variables left in EXPR.  

(defun my-negated-pred-match (expr state bindings)
  (let ((arguments (substitute-binding (cdr expr) bindings)))
    (if (has-unbound-vars arguments)
	(error "~% NEGATED-PRED-MATCH: there are unbound vars in expr "
	       "~A " expr)
	(if (not (my-descend-match expr state bindings))
	    (list bindings)
	    nil))))


;;; **********************************************************
;;; Utilities

;;from run-same-objects.lisp

;; this is needed because although we clear the assertion hash, the
;; literals remain as objects to which one can only access by the
;; literal itself. Then testing literal-state-p may return t,
;; depending on the final state of the last run. This is not a problem
;; in Prodigy because the objects (and therefore the literals) are
;; different 

(defun delete-literals-from-state ()
  ;;loop over all the literals in the state (from previous run) and
  ;;set the state flag to nil 
  (dolist (lit (give-me-nice-state))
    (setf (literal-state-p lit) nil)))

;;this now in comforts.lisp, but in the user package.
;;function to get the state at each point

(defun give-me-nice-state (&optional (literals nil))
  (let* (temp lit-hash-tables)
    (setf
     lit-hash-tables
     (cond
      (literals
       (mapcar
	#'(lambda (lit)
	    (gethash
	     lit
	     (problem-space-assertion-hash *current-problem-space*)))
	literals))
      (t (maphash
	  #'(lambda (key val)
	      (push
	       (gethash
		key
		(problem-space-assertion-hash *current-problem-space*))
	       temp))
	  (problem-space-assertion-hash *current-problem-space*))
	 temp)))
    (apply #'append
	   (mapcar
	    #'(lambda (hash-table)
		(setf temp nil)
		(maphash #'(lambda (key val)
			     (if (literal-state-p val)
				 (push val temp)))
			 hash-table)
		temp)
	    lit-hash-tables))))


(defun create-op-list (instantiated-op)
  (declare (type instantiated-op instantiated-op))
  (cons (operator-name (instantiated-op-op instantiated-op))
	(mapcar #'(lambda (val)
		    (if (or (numberp val)(symbolp val))
			val 
			(p4::prodigy-object-name val)))
		(instantiated-op-values instantiated-op))))



#|
;uncomment this part if you will want to build the partial order of
;the tested solution
;;; *****************************************************************
;;; Functions to generate a partial order from the expert solution as
;;; we replay it (because the functions in order/access-fns-pro4.lisp
;;; use the search tree to get the application structures).

;;from order/access-fns-pro4: functions to create the plan steps 

(load "/afs/cs/project/prodigy-aperez/order/access-fns-pro4")
 
(defun create-expert-plan-step (inst-op delta-adds delta-dels)
   (declare (type instantiated-op inst-op)
 	   (list delta-dels delta-adds))
   ;;similar to create-plan-step but without getting the application
   ;;from the applied-nodes
   (make-plan-step
    :name (create-op-list inst-op)
    ;;see code in access-fns-pro4 to ask Mei about instantiated preconds
    :preconds (build-plan-step-preconds inst-op)
    :add-list (mapcar #'create-goal-list delta-adds)
    :del-list (mapcar #'create-goal-list delta-dels)))
 
|#
