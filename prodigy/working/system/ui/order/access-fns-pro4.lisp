
(in-package 'prodigy4)
(export 'prepare-plan-for-partial-order)
(export 'get-initial-state)

;;; ***********************************************
;;;
;;;    Define your own access functions
;;;
;;;    aperez May 9, 1992
;;;
;;; ************************************************************
;;; In 4.0 the plan is (cdr (run)) and it is a list of elements of
;;; type p4::instantiated-op.

;;; The (real) adds and dels of an instantiated operator are stored in
;;; the "op-application" structure and we can access this only from the
;;; applied-op nodes (not from the instantiated-op). That's why the
;;; code below creates a plan structure from the solution path.

;;;result = what (run) returns
;;; To create the partial order call
;;;   (build-partial
;;;     (prepare-plan-for-partial-order result)
;;;     (get-initial-state))
;;; this returns a matrix.

;;; I have also code to create the partial order for a plan expressed
;;; as a list of instantiated-ops, by replaying the plan first (ask me
;;; if you need it).

;;; Change log
;;; aperez April 14 1993
;;; Modified prepare-plan-for-partial-order so the last plan-step
;;; corresponds to the *finish* operator.
;;;
;;; aperez May 17 1993
;;; Modified the generation of the plan-step preconditions. It broke
;;; because  when there are conditional effects the
;;; instantiated-op-precond had the form
;;; (and cond-eff-precond (and regular-precond+))
;;;
;;; aperez May 20 1993
;;; Changed create-plan-step: the operator applied at a node
;;; corresponds to the LAST element in a-or-b-node-applied (previously
;;; I was using the first). The rest are inference rules.
;;;
;;; aperez Dec 7 1993
;;; Modified prepare-plan-for-partial-order to use prodigy-result structure.
;;;
;;; *****************************************************************

(defstruct plan-step name preconds add-list del-list)

(defun prepare-plan-for-partial-order ()
  ;;returns a list of plan-steps
  (append
   (mapcar #'create-plan-step
	   (cdr (path-from-root
		 (cdr (user::prodigy-result-interrupt user::*prodigy-result*))
		 #'applied-op-node-p)))
   (list (create-finish-step))))

;;note that with this code ONLY OPERATORS have plan-steps created.
;;Lazy inference rules are applied at binding nodes, and eager
;;inference rules at applied-op nodes (both are stored in the 
;;a-or-b-node-applied field of the node)


(defun create-plan-step (node)
  (declare (type applied-op-node node))
  ;; an a-or-b-node node may have several application structures
  ;; corresponding to inference rules. Assume that in an applied-op
  ;; node the one we want is the last one (check this with Jim)
  (let* ((application (car (last (a-or-b-node-applied node))))
	 (op (op-application-instantiated-op application)))
    (make-plan-step
     :name (create-op-list op)
     :preconds (build-plan-step-preconds op)
     :add-list (mapcar #'create-goal-list
		       (op-application-delta-adds application))
     :del-list (mapcar #'create-goal-list
		       (op-application-delta-dels application)))))

(defun create-finish-step ()
  ;;op is an instantiation of *finish*
  (let ((op (a-or-b-node-instantiated-op (find-node 4))))
    (make-plan-step
     :name (create-op-list op)
     :preconds (build-plan-step-preconds op)
     :add-list nil
     :del-list nil)))


;; Returns the list of preconds of a step

(defun build-plan-step-preconds (op)
  ;;precond may be a conjunction (and lit lit ...) or just a single
  ;;literal. Also extended for foralls
  (declare (type instantiated-op op))
  (mapcar #'(lambda (x)
	      (if (literal-p x) (create-goal-list x)
		  ;;assume is a negation
		  (list 'user::~ (create-goal-list (second x)))))
	  (build-step-precond-rec
	   (if (listp (instantiated-op-precond op))
	       (copy-tree (instantiated-op-precond op))
	       (list (instantiated-op-precond op)))
	   op)))

(defun build-step-precond-rec (precond op)
  ;;return a list of preconditions (such that the op precondition is
  ;;the conjunction of them)
  ;;precond is a copy (so we can do mapcan) of instantiated-op-precond
  (declare (type instantiated-op op))
  ;;Mei:
  ;;my feeling is that when the precond is a forall or an exists, it is
  ;;uninstantiated (even the variables that are not quantified). I
  ;;have checked this on an actual run.
  ;;Therefore here I will deal with those cases separately. 
  (cond
    ((literal-p precond) (list precond))
    ((eq (car precond) 'user::~)
     (if (literal-p (second precond))
	 (list precond)
	 (error "Case not considered: ~~ of an exp in precond: ~A.~%"
		precond)))     
    ((eq (car precond) 'user::forall)
     (build-step-forall-preconds precond op))
    ((eq (car precond) 'user::and)
     (mapcan #'(lambda (p) (build-step-precond-rec p op))
	     (cdr precond)))
    ((member (car precond) '(user::exists user::or))
     (error "Case not considered: ~A in precond: ~A.~%"
	    (car precond)  precond))
    ;;a list
    ((listp precond)
     (mapcan #'(lambda (p) (build-step-precond-rec p op))
	     precond))
    (t (error "Case not considered: precond: ~A.~%" precond))))


(defun build-step-forall-preconds (precond op)
  ;;precond is a list that start with a forall. I believe it is all
  ;;uninstantiated, even the vars that are not quantified
  ;;returns a list of instantiated literals 
  (let ((vars (append (rule-vars (instantiated-op-op op))
		      (mapcar #'car (second precond))))
	(all-possible-bindings
	 ;;generate all possible bindings
	 (do* ((gen 
		(cdr (assoc
		      (second precond)
		      (getf (rule-plist (instantiated-op-op op))
			    :quantifier-generators))))
	       (data (if gen (funcall gen nil)))
	       (choice (make-list (length data) :initial-element 0)
		       (increment-choice choice data))
	       (forall-bindings (choice-bindings precond data choice)
				(choice-bindings precond data choice))
	       result)
	     ((null choice) result)
	   (push (mapcar #'cdr forall-bindings) result))))
    (setf all-possible-bindings
	  (mapcar #'(lambda (quant-var-bds)
		      (append (instantiated-op-values op)
			      quant-var-bds))
		  all-possible-bindings))
    ;;assume that the forall body can only be and, or, ~, or a sigle literal
    ;;(no nested connectives)
    (mapcan #'(lambda (binding)
		(instantiate-forall-lits (third precond) binding vars))
	    all-possible-bindings)))

(defun instantiate-forall-lits (expr values vars)
  ;;returns a list of instantiated literals 
  (cond
   ((equal (car expr) 'user::and)
    (mapcan #'(lambda (lit)
		;;one literal
		(instantiate-forall-lits lit values vars))
	    (cdr expr)))
   ((equal (car expr) 'user::or)
    ;;here I would have to choose the disjunct that is true in the
    ;;state and that made the operator applicable.
    (error "Case not considered.~%"))
   ((member (car expr) '(user::forall user::exists))
    (error "Case not considered.~%"))
   ((equal (car expr) 'user::~)
    (list
     (list 'user::~
	   (car (instantiate-forall-lits (second expr) values vars)))))
   (t ;;I guess it is a literal
    (list (try-to-instantiate expr values vars)))))
		  
(defun get-initial-state ()
  ;;this slot has the form (state (and assertions))
  (cdr (second  (problem-state (current-problem)))))

;;; ***********************************************


;; Returns the list of preconds of a step

(defun get-op-preconds (op)
  (plan-step-preconds op))

;; Returns the list of adds of a step

(defun get-op-adds (op)
  (plan-step-add-list op))

;; Returns the list of dels of a step

(defun get-op-dels (op)
  (plan-step-del-list op))

;; Optional - only needed if *talkp* is set.
;; Returns some identification of the step

(defun get-plan-step-name (op)  
  (plan-step-name op))

;;; ***********************************************
;;; Other functions

(defun create-goal-list (literal)
  (declare (type literal literal))
  (cons (literal-name literal)
	(map 'list  #'(lambda (val)
			(if (or (numberp val)(symbolp val))
			    val 
			    (p4::prodigy-object-name val)))
	     (literal-arguments literal))))

(defun create-op-list (instantiated-op)
  (declare (type instantiated-op instantiated-op))
  (cons (operator-name (instantiated-op-op instantiated-op))
	(mapcar #'(lambda (val)
		    (if (or (numberp val)(symbolp val))
			val 
			(p4::prodigy-object-name val)))
		(instantiated-op-values instantiated-op))))

#|
;;; ***********************************************
;;;                 EXAMPLES
;;; 

;;; The 2objs ROCKET problem.

(setf plan
      (list
       (make-plan-step :name '(LOAD rocket obj1 locA)
		       :preconds '((at obj1 locA) (at rocket locA))
		       :add-list '((inside obj1 rocket))
		       :del-list '((at obj1 locA)))
       (make-plan-step :name '(LOAD rocket obj2 locA)
		       :preconds '((at obj2 locA) (at rocket locA))
		       :add-list '((inside obj2 rocket))
		       :del-list '((at obj2 locA)))
       (make-plan-step :name '(MOVE rocket)
		       :preconds '((at rocket locA))
		       :add-list '((at rocket locB))
		       :del-list '((at rocket locA)))
       (make-plan-step :name '(UNLOAD rocket obj2 locB)
		       :preconds '((inside obj2 rocket) (at rocket locB))
		       :add-list '((at obj2 locB))
		       :del-list '((inside obj2 rocket)))
       (make-plan-step :name '(UNLOAD rocket obj1 locB)
		       :preconds '((inside obj1 rocket) (at rocket locB))
		       :add-list '((at obj1 locB))
		       :del-list '((inside obj1 rocket)))
       (make-plan-step :name '(*FINISH*)
		       :preconds '((at obj1 locB) (at obj2 locB))
		       :add-list '((done))
		       :del-list nil)))

(setf state '((at obj1 locA) (at obj2 locA) (at rocket locA)))

;;; ***********************************************


|#