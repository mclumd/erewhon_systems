;;; $Revision: 1.5 $
;;; $Date: 1995/04/20 20:11:01 $
;;; $Author: khaigh $
;;;
;;; REVISION HISTORY
;;;
;;;  $Log: load-problem.lisp,v $
;;; Revision 1.5  1995/04/20  20:11:01  khaigh
;;; Added code to allow objects to stay the same between runs.
;;; Based on Alicia's run-same-objects2
;;;
;;; Revision 1.4  1995/04/05  16:39:28  jblythe
;;; Included some layers of changes to dealing with forall and exists
;;; goals that had been languishing in a separate file. Also added code to
;;; allow arbitrary slots of operators, that are added to the property
;;; list, and fixed a problem with optionally compiling the matching
;;; functions.
;;;
;;; Revision 1.3  1994/05/30  20:56:04  jblythe
;;; Added Tony Maida's patches to have Prodigy run with CMU Lisp 16 and 17.
;;;
;;; Revision 1.2  1994/05/30  20:30:15  jblythe
;;; Added CVS headers so the revision history and descriptions are included in
;;; each changed file.
;;;


(in-package "PRODIGY4")

(export '(state goal igoal create-problem current-problem))

;; It is best to have a canonical description for problems, however,
;; we originally did not have this and so problems were just loaded
;; a-la-nolimit with STATE, GOAL, and INSTANTIATION macros in a file.
;; This makes deleting an old problem tricky and makes manipulating
;; the internals of a problem an exercise in reading and writing
;; files.  Some of the old macros are left around and used via calls
;; to EVAL, this is not pretty but it is there.  I would suggest
;; always using the canonical form.

;; LOAD-PROBLEM does the following consistancy checks:

;; No two objects may be given the same name (a symbol).  This is checked.

(defun instantiate-consed-exp (exp)
  (if (eq (car exp) 'user::~)
      (let ((literal (instantiate-consed-literal (second exp))))
	(setf (literal-state-p literal) nil))
      (let ((literal (instantiate-consed-literal exp)))
	(setf (literal-state-p literal) t))))

;; The STATE macro state loads the state into the system.  The state
;; may be a literal, a list of literals or a list of literals whose
;; car is AND.  Anything else will generate an error.

(defmacro state (consed-literals)
  `(prog nil
    (clear-assertion-hash *current-problem-space*)
    ,(cond ((eq (car consed-literals) 'user::and)
	    `(mapcar #'instantiate-consed-exp ',(cdr consed-literals)))
	   ((consp (car consed-literals))
	    `(mapcar #'instantiate-consed-exp ',consed-literals))
	   ((symbolp (car consed-literals))
	    `(instantiate-consed-exp ',consed-literals))
	   (t
	    (error "~&Bad state in ~S.~%" consed-literals)))))

;; Because a prodigy GOAL is used to create a ficticious operator with
;; the goal of the problem goal and the effect of adding the predicate
;; DONE we must allow for the construction of an operator from our
;; goal.  This is to be done by allowing a binding generator to be
;; part of the description of the goal state.

;; This fictious operator is called *FINISH* to maintain consistancy
;; with the rest of the prodigy system.

;; This way goal works whether preconds is  instantantiated literals
;; or it has variables. 
;; for example, we can say (goal (and (on A B) (on B C))), we can also
;; do (goal ((<x> Object) (<y> Object)) (on <x> <y>))
(defmacro goal (&rest preconds)
  (cond ((= 1 (length preconds))
	 `(vgoal nil ,(first preconds)))
	((= 2 (length preconds))
	 `(vgoal ,(first preconds) ,(second preconds)))
	(t
	 (error "Wrong number of subfields in the goal specification
(should be 2 or 3)~%"))))


(defmacro vgoal (binding-generator preconds)
  `(foperator '*FINISH*
    '(user::params ,.(mapcar #'car binding-generator))
    '(user::preconds ,binding-generator ,preconds)
    '(user::effects ();; No variables need defined.
      ((user::add (done))))))

;; IGOAL is a macro that permits instantiated goals.  The more general
;; goal macro is useful when you have a uninstantiated variable in the
;; goal, for example you might want (on A <x>) which puts A on top of
;; some other object, but it doesn't matter which one.  Generally the
;; entire goal is instantiated and so it is more convenient to use the
;; igoal macro.

;;; This has been made obsolete, by allowing "goal" to take both kinds
;;; of syntax by checking the number of its arguments.
(defmacro Igoal (preconds)
  `(goal nil ,preconds))

;; A Prodigy problem should be represented in the below structure.
;; The macro create-problem can be used to build this structure.  To
;; run an experiment over lists of operators you should use this
;; method.  The problem space has the idea of a current-problem (what
;; you solve by typing (run).

(defstruct (problem (:print-function print-problem))
    (name 'no-name)
    (objects nil)
    (goal nil)
    (state nil)
    (plist nil))

(defun print-problem (prob stream z)
  (declare (type problem prob)
	   (stream stream)
	   (ignore z))

  (let ((*standard-output* stream))
    (princ "#<PROB: ")
    (princ (problem-name prob))
    (princ ">")))

(defmacro current-problem ()
  "Returns the current problem and (using setf) sets the problem to a
particular value."
  (declare (special *current-problem-space*))
  '(getf (problem-space-plist *current-problem-space*) :current-problem))

(defmacro create-problem (&rest args)
  "This macro creates a Prodigy PROBLEM lisp object."
    `(make-problem :name ',(second (assoc 'user::name args))
                   :objects ',(cdr (assoc 'user::objects args))
                   :goal ',(assure-goal args)
                   :state ',(assoc 'user::state args)
                   :plist ',(mapcan #'(lambda (x)
					(unless (member (car x)
							'(user::name
							  user::objects
							  user::goal
							  user::state))
					  (copy-list x)))
			     args)))

(defun assure-goal (a-list)
   (cond ((and (assoc 'user::igoal a-list)
	       (assoc 'user::goal a-list))
	  (error "~&Problem ~S has both goal and igoal.~%"))
	 ((assoc 'igoal a-list))
	 (t (assoc 'goal a-list))))

(defun create-finish-generators (compile)
  ;; Must also create generators for the *finish* operator, in case it
  ;; has any.
  (let ((finish-op
	 (rule-name-to-rule '*finish* *current-problem-space*))
	(*compile-tests* compile))
    (declare (special *compile-tests*))
    (create-tests-for-operator finish-op)
    (create-generator-for-operator finish-op)))

(defun set-abstraction-heirarchy (no-new-abstractions)
  ;; Set up the abstraction hierarchy for this problem.
  (unless no-new-abstractions ; read my lisp - no new abstractions
    (setf (problem-space-property :abs-hier)
	  (create-hierarchy *current-problem-space* (current-problem)))
    (setf (problem-space-property :control-rule-abstraction-levels)
	  (compute-control-abstraction-levels *current-problem-space*))))

;; This loads the problem into lisp so it can be solved by the
;; planner.  It should only be called by the run routine.
(defun load-problem (problem
		     &optional no-new-abstractions compile)
  ;; NOTE: check whether any changes in this function
  ;;       are needed in load-problem-same-objects
  
  (declare (type problem problem)
	   (special *current-problem-space*))

  (reset-problem-space *current-problem-space*)
  
  (dolist (ob (problem-objects problem))
    (cond ((eq (car ob) 'object-is)
	   (output 2 t "Creating object ~S of type ~S~%"
		   (second ob) (third ob))
	   (eval ob))
	  ((eq (car ob) 'objects-are)
	   (output 2 t "Creating objects ~S of type ~S~%"
		   (butlast (cdr ob)) (car (last ob)))
	   (eval ob))
	  ((= (length ob) 2)
	   (output 2 t "Creating object ~S of type ~S~%"
		   (first ob) (second ob))
	   (eval (cons 'object-is ob)))
	  (t
	   (output 2 t "Creating objects ~S of type ~S~%"
		   (butlast ob) (car (last ob)))
	   (eval (cons 'objects-are ob)))))

  (eval (problem-state problem))
  (eval (problem-goal problem))

  (create-finish-generators compile)
  (set-abstraction-heirarchy no-new-abstractions))

;;; ************************************************************
;;; We want this fn not to create new objects but use the existing
;;; ones.

(defun load-problem-same-objects (problem &optional no-new-abstractions compile)
  ;; NOTE: check whether any changes in this function
  ;;       are needed in load-problem
  (declare (type problem problem)
	   (special *current-problem-space*))

  (delete-literals-from-state)
  (clean-literal-goal-p-slots)
;  (reset-problem-space *current-problem-space*) replaced by:
;  (clear-assertion-hash *current-problem-space*)
  ;;alicia
  ;(since I have set all literals to nil in the state, and we have the
  ;closed world assumption, I won't remove the lits from the assertion
  ;hash, but will reuse them). The reason for this is that in odrer to
  ;be able to use the matcher, the literals should be the same as the
  ;ones in the expert solution instantiated operators, and these stay
  ;between runs.

  (eval (cons 'state-keep-lits (cdr (problem-state problem))))
  (eval (problem-goal problem))

  (create-finish-generators compile)
  (set-abstraction-heirarchy no-new-abstractions))

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


;;; *****************************************************************
;;; Reset the values of literal-goal-p and literal-neg-goal-p for all
;;; the literals.

;;; When maintain-state-and-goals is called >> calls
;;; set-goals >> calls push-goal which doesn't check for duplicates
;;; (id for push-neg-goal) and therefore literal-goal-p may contain
;;; duplicates (whose number increases everytime that I call
;;; maintain-state-and-goals) >> control rule fires several times for
;;; same bindings.
;;; This was giving me a lot of problems when I call
;;; maintain-state-and-goals from match-pref-rule-at-learning-time (in
;;; learn-rule-fired.lisp).

(defun clean-literal-goal-p-slots ()
  ;;loop over all the literals ans set their goal-p and negated-goal-p
  ;;slots to nil. Code is similar to give-me-nice-state.
  (let ((a-hash (p4::problem-space-assertion-hash *current-problem-space*))
	lit-hash-tables)
    (maphash #'(lambda (key val)
		 (declare (ignore val))
		 (push (gethash key a-hash) lit-hash-tables))
	     a-hash)
    (dolist (hash-table lit-hash-tables)
      (maphash #'(lambda (key val)
		      (declare (ignore key))
		      (setf (literal-goal-p val) nil)
		      (setf (literal-neg-goal-p val) nil))
	       hash-table))))




(defun compute-control-abstraction-levels (pspace)
  (declare (type problem-space pspace))
  ;; Yuck!
  (let ((res nil))
    (declare (special res))
    (dolist (slot '(problem-space-select-nodes
		    problem-space-select-goals
		    problem-space-select-operators
		    problem-space-select-bindings
		    problem-space-reject-nodes
		    problem-space-reject-goals
		    problem-space-reject-operators
		    problem-space-reject-bindings
		    problem-space-prefer-nodes
		    problem-space-prefer-goals
		    problem-space-prefer-operators
		    problem-space-prefer-bindings
                    problem-space-apply-or-subgoal))
      (add-in-c-rules pspace slot))
    res))

(defun add-in-c-rules (pspace slot)
  (declare (type problem-space pspace)
	   (symbol slot)
           (special res))
  (dolist (rule (apply slot (list pspace)))
    (push (cons rule (c-rule-abstraction-level (control-rule-if rule) pspace))
	  res)))

(defun c-rule-abstraction-level (exp pspace)
  ;; (format t "~%Abs on ~S" exp)
  (let ((result
         (cond ((not (listp exp)) 0)
               ((eq (car exp) 'user::~)
                (c-rule-abstraction-level (second exp) pspace))
               ((member (car exp) (problem-space-all-preds pspace))
                (c-rule-pred-abs-level exp pspace))
               ((listp (cdr exp))
                (apply #'min
                       (cons 0
                             (mapcar #'(lambda (s)
					 (c-rule-abstraction-level s pspace))
                                     (cdr exp)))))
	       (t 0))))
    ;;(format t "~%  res ~S" result)
    result))

;;; This calculates the abstraction level of a domain-level predicate in
;;; the left hand side of a control rule as the maximum abstraction level
;;; of all predicates with the same first name and the same length in the
;;; problem space. This is because the control rule has no type information.
(defun c-rule-pred-abs-level (exp pspace)
  (or
   (position-if
    #'(lambda (group)
        (member-if #'(lambda (schema)
                       (and (eq (abs-node-name schema) (car exp))
                            (= (length (abs-node-args schema))
                               (length (cdr exp)))))
                   group))
    (getf (problem-space-plist pspace) :abs-hier) :from-end t)
   0))

       

