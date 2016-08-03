;; This is the code that will extract a test from the binding select
;; control rules.  There are two top level functions.  The first
;; (EXTRACT-STATIC-CR-TESTS) takes as an argument a control rule and
;; returns a lambda expression of no arguments.  This lambda
;; expression evaluates the part of a control rule that is independent
;; of the variables being selected.  The second function
;; (EXTRACT-CR-TEST ) takes as arguments two lists of variables and
;; builds a test for the cross product of candidate instantiations of
;; those variables.


;;; $Revision: 1.4 $
;;; $Date: 1995/03/13 00:39:14 $
;;; $Author: jblythe $
;;;
;;; REVISION HISTORY
;;;
;;;  $Log: extract-cr.lisp,v $
;;; Revision 1.4  1995/03/13  00:39:14  jblythe
;;; General clean-ups, including a definition of gen-from-pred that can have
;;; more than one variable in the literal.
;;;
;;; Revision 1.3  1994/05/30  20:55:44  jblythe
;;; Added Tony Maida's patches to have Prodigy run with CMU Lisp 16 and 17.
;;;
;;; Revision 1.2  1994/05/30  20:29:53  jblythe
;;; Added CVS headers so the revision history and descriptions are included in
;;; each changed file.
;;;


(in-package "PRODIGY4")
;; HOW A SELECT BINDING CONTROL RULE WORKS

;; Consider the following control rule:

; (CONTROL-RULE SELECT-BINDINGS-UNSTACK-CLEAR
;   (IF (and (current-goal (clear <y>))
;	    (true-in-state (on <x> <y>))))
;    (THEN select bindings ((<ob> . <x>) (<underob> . <y>)) for (UNSTACK)))

; (CONTROL-RULE SELECT-BINDINGS-UNSTACK-CLEAR
;   (IF (and (current-goal (clear <y>))
;           (current-op (UNSTACK))
;	    (true-in-state (on <x> <y>))))
;(THEN select bindings ((<ob> . <x>) (<underob> . <y>))))

;; A binding will be a single variable bound to a single value.  A
;; tuple is a list of bindings each with a distinct variable. 

(defstruct (bind (:print-function bind-print))
  var
  val)

(defun bind-print (bind stream z)
  (declare (type bind bind)
	   (type stream stream)
	   (ignore z))
  (princ "#<BIND: " stream)
  (princ (bind-var bind) stream)
  (princ " " stream)
  (prin1 (bind-val bind) stream)
  (princ ">" stream))

(defun new-binding (var val)
  (make-bind :var var :val val))

(defun format1 (stream string arg)
  (format stream string arg)
  arg)

;; The antecedent (IF part) is a conjunct of lisp functions (refered
;; to as meta-predicates in PRODIGY parlance) that are expressed with
;; a PRODIGY style variable.  In this scheme the functions are
;; evaluated in a left right order in the sense that the first
;; occurance of a variable in the left to right evaluation is "binds"
;; the variable (ie the meta-predicate must return a list of possible
;; values for it).  Further occurences of the variable are treated as
;; if the variable were bound.
;; Save this for later '((:empty-tuple))))


(defun extract-independent-data (control-rule)
  (let ((pre-bound-vars (get-prebound-vars control-rule)))
    `(lambda ()
      (let ((ALL-TUPLES '(:empty-tuple)))
	,(extract-from-exp (control-rule-if control-rule) pre-bound-vars nil
			   :independent)))
))

;; All the code that is relevent to the independent data has been
;; re-written and is now in extract-cr-ii.lisp

;(defun extract-dependent-data (control-rule)
;  (let ((pre-bound-vars (get-prebound-vars control-rule)))
;    `(lambda (ALL-TUPLES)
;      (let ()
;	,(extract-from-exp (control-rule-if control-rule) nil pre-bound-vars
;			   :dependent)))))

;; The variable bound-vars in EXTRACT-FROM-EXP refers to the variables
;; bound from the right hand side of the operator, or variables which
;; depend on those, and not the kind of binding we think of when the
;; problem solver is actually running.  In other words, these are vars
;; that will be bound by the problem solver at run time.  These are
;; the variables that are dependent on the (<ob> . <x>) (<underob> . <y>)
;; part of the control rule.
  
(defun extract-from-exp (lhs rhs-bound-vars lhs-bound-vars dependency)
  (cond ((member (car lhs) '(user::and user::or user::forall
			     user::exists user::~))
	 (build-complex-exp lhs rhs-bound-vars lhs-bound-vars dependency))
	(t (build-meta-predicate-call lhs rhs-bound-vars lhs-bound-vars dependency))))

;; Here we actually work on an atomic expression such as 

	    
(defun build-complex-exp (lhs rhs-bound-vars lhs-bound-vars dependency)
  (case (car lhs)
    (user::and (build-and-exp lhs rhs-bound-vars lhs-bound-vars dependency))
    (user::or (build-or-exp lhs rhs-bound-vars lhs-bound-vars dependency))
    (user::forall (build-forall-exp lhs rhs-bound-vars lhs-bound-vars dependency))
    (user::exists (build-exists-exp lhs rhs-bound-vars lhs-bound-vars dependency))
    (user::~ (build-not-exp lhs rhs-bound-vars lhs-bound-vars dependency))))

(defun build-not-exp (not-exp rhs-bound-vars lhs-bound-vars dependency)
  (multiple-value-bind (lisp-code new-bindings)
      (extract-from-exp (second not-exp)
			rhs-bound-vars lhs-bound-vars dependency)
    (if (not lisp-code)  ;; if no lisp ignore expression
	(values nil new-bindings)
	
	(if (set-difference (second not-exp) lhs-bound-vars)
	    (error "~S contains the following vars: ~S that are not~
bound by the antecedent (LHS)~% or the the consequent (RHS) of the ~
a control-rule.  A negation (~) may not bind variables.~%"
		   not-exp
		   (set-difference (second not-exp) lhs-bound-vars))

	    ;; no error so lets return code with a NOT and the new bindings
	    (values
	     (cons 'not lisp-code)  ;; a little lisp code
	     new-bindings)))))

(defun build-and-exp (lhs rhs-bound-vars lhs-bound-vars dependency)
   (append '(and
	     ;(progn (format t "~&ALL-TUPLES: ~S~%" all-tuples) t)
	     )

     (do ((rbv rhs-bound-vars (if (not lisp-code)
				  new-vars
				  rbv))
	  (lbv lhs-bound-vars (if lisp-code
				  new-vars
				  lbv))
	  (exps (cdr lhs) ; start with LHS w/o the AND
		(cdr exps))
	  (lisp-code nil)
	  (new-vars nil)
	  (all-lisp-code nil))
	 ((endp exps) all-lisp-code)
;       (format t "~%All-lisp-code:  ~S.~%" all-lisp-code)
;       (format t "This is RBV: ~S~%This is LBV:  ~S~%" rbv lbv)
	 (multiple-value-setq (lisp-code new-vars)
		(extract-from-exp (car exps) rbv lbv dependency))
;       (format t "~%The Lisp-code:  ~S.~%" lisp-code)
       (if lisp-code
	   (setf all-lisp-code
		 (append all-lisp-code `((setf ALL-TUPLES ,lisp-code))))))))

;; No generated bindings are permited inside a disjunct.
;; At this point I will ignore disjuncts since handleing them in two
;; different parts is very difficult.

(defun build-or-exp (&rest x)
  (declare (ignore x))
  t)
  
;; In both the exists and foralls we have DO loops.  Each iteration
;; through a DO loop is a check on another tuple that has been build
;; by the system.  The EXISTS combines the tuples with the the values
;; for the existentially quantified variable and returns those
;; combinations.  The FORALL match only returns the tuples given it,
;; and only those that are true under the universal quantification.

(defun build-exists-exp (exists-exp rhs-bound-vars lhs-bound-vars dependency)
   (let ((exists-gen (second (second exists-exp)))
	 (exists-lambda (build-exists-lambda (third exists-exp)
					     rhs-bound-vars
					     lhs-bound-vars
					     dependency)))

     (cond ((and (independentp (second exists-gen) rhs-bound-vars)
		 exists-lambda)
	    `(do* ((tuples ALL-TUPLES (cdr tuples))
		   (exists-tuples ,(build-meta-predicate-call exists-gen
							rhs-bound-vars
							lhs-bound-vars
							dependency)
		                  ,(build-meta-predicate-call exists-gen
							rhs-bound-vars
							lhs-bound-vars
							dependency))
		   (good-tuples (delete-if-not ,exists-lambda exists-tuples)
		                (nconc
				 (delete-if-not ,exists-lambda exists-tuples))))
	      ((endp tuples) good-tuples)))
	   (t nil))))

(defun build-exists-lambda (exp rhs-bound-vars lhs-bound-vars dependency)
  "This function builds the lambda expression that a exists maps over
possible tuples.  By using the variable ALL-TUPLES I can shadow the
previous definition of ALL-TUPLES to only look at the value bound by
the forall."
  (let ((lam
	 `(lambda (a-tuple)
	   (let ((ALL-TUPLES (list a-tuple)))
	     ,(extract-from-exp exp rhs-bound-vars lhs-bound-vars dependency)))))
	lam))

;; I think that this implementation for FORALL is going to be very
;; expensive.  It may need to be redone someday.  It takes the values
;; generated for the universal quantification and builds the cross
;; product with all of the tuples in the variable ALL-TUPLES.

(defun build-forall-exp (forall-exp rhs-bound-vars lhs-bound-vars dependency)
  (let (;(univ-var (first (second forall-exp)))
	(univ-gen (second (second forall-exp)))
	(forall-lambda (build-forall-lambda (third forall-exp)
					    rhs-bound-vars
					    lhs-bound-vars
					    dependency)))

    (cond ((and (independentp (second univ-gen) rhs-bound-vars)
		forall-lambda)
	   `(if (not (equalp *init-tuple* ALL-TUPLES))
	     (do* ((tuples ALL-TUPLES (cdr tuples))
		   (all-tuples (list (car tuples))  ; shadow ALL-TUPLES
			       (list (car tuples)))
		   
		   (forall-tuples ,(build-meta-predicate-call univ-gen
							rhs-bound-vars
							lhs-bound-vars
							dependency)
				  ,(build-meta-predicate-call univ-gen
							rhs-bound-vars
							lhs-bound-vars
							dependency))
		   (good-tuple-p (every ',forall-lambda forall-tuples)
				 (every ',forall-lambda forall-tuples))
		   (result (if good-tuple-p (list (car tuples)))
			   (if good-tuple-p (append (list (car tuples))  result)
			                    result)))
		  
		  ((endp tuples) ; termintation condition
		   (cdr result))))) ; Get rid of NIL at head of list


	  (t nil))))

;; The let in the next expression will be used when I add (compile nil
;; lam) to it.  (This is for after debugging.)

(defun build-forall-lambda (exp rhs-bound-vars lhs-bound-vars dependency)
  "This function builds the lambda expression that a forall maps over
possible tuples.  By using the variable ALL-TUPLES I can shadow the
previous definition of ALL-TUPLES to only look at the value bound by
the forall."
  (let ((lam
	 `(lambda (a-tuple)
	   (let ((ALL-TUPLES (list a-tuple)))
	     ,(extract-from-exp exp rhs-bound-vars lhs-bound-vars dependency)))))
	(maybe-compile lam)
        ;lam
	))

  
;; First I'll write this for the simple case of function name followed
;; by prodigy variables, then I'll worry about the complicated case of
;; a recursive list structure as an argument [like (on <a> <b>)].

;; BUILD-META-PREDICATE-CALL returns two values.  If the first is NIL then
;; the second one will be additional variables dependent on the RHS of
;; the control rule.  If the first is non-NIL then it will be lisp
;; code and the second will be the new complete set of lhs bound
;; variables (i.e. those variables bound from the left side).

#|(defun build-meta-predicate-call (expression rhs-bound-vars lhs-bound-vars dependency)
   (cond ((and (not (independentp (cdr expression) rhs-bound-vars))
	       (eq dependency :independent))
	  (values nil ;; no lisp code
		  (cons rhs-bound-vars
			(set-difference (cdr expression) lhs-bound-vars ))))

	 (t

	  
	  ;;  Here we can make the function call over all possible
	  ;;  bindings and return the new bindings.  We need to have
	  ;;  a DO loop over all the lhs-bound-vars (ie those
	  ;;  variables that are not dependent on the objects being
	  ;;  examined from the RHS of the control rule.)
	  
	  (values
	   
   	   ;;first value is code.  It will just be a SETF if
	   ;; there are can be no relevant tuples (ie all the)
	   ;; variables are unbound when the 
	   ;; otherwise it will be a DO loop.
	   
	   (if (independentp (cdr expression) lhs-bound-vars)
	       `(mapcan
		 #'(lambda (x)
		     (build-new-tuple x
				      ,(function-call expression lhs-bound-vars)))
		 ALL-TUPLES)
	       
	       
	       `(do* ((tuples  ALL-TUPLES (cdr tuples))
		      (result (build-new-tuple (car TUPLES)
					       (if (car TUPLES) ,(function-call expression lhs-bound-vars)))
		       (nconc result (build-new-tuple (car tuples)
						      (if (car tuples) ,(function-call expression lhs-bound-vars))))))
		 ((endp tuples) result)
		 
		 ))
	   
	   ;; second value is lhs bound-vars
	   (union lhs-bound-vars (all-vars (cdr expression)))
	   ;; (cdr expression)
	   ;; must be made to
	   ;; handle more
	   ;; complex things.
	   ))))|#

(defun build-meta-predicate-call (exp rhs-bound-vars lhs-bound-vars dependency)
  (cond ((eq dependency :independent)
	 (cond ((independentp (cdr exp) rhs-bound-vars)
		(values  ;; This first value is the code
		 (if (independentp (cdr exp) lhs-bound-vars)
		     `(mapcan
		       #'(lambda (x)
			   (build-new-tuple x
					    ,(function-call exp lhs-bound-vars)))
		       ALL-TUPLES)
		     
	       
		     `(do* ((tuples  ALL-TUPLES (cdr tuples))
			    (result (build-new-tuple (car TUPLES)
						     (if (car TUPLES) ,(function-call exp lhs-bound-vars)))
			     (nconc result (build-new-tuple (car tuples)
							    (if (car tuples) ,(function-call exp lhs-bound-vars))))))
		       ((endp tuples) result)
		       
		       ))
		 ;; The second values is new LHS bound vars
		 (union lhs-bound-vars (all-vars (cdr exp)))))
	       
	       (:one
		(values nil ;; No code
			    ;; but RHS bound vars
			(cons rhs-bound-vars
			      (set-difference (cdr exp) lhs-bound-vars))))))
	
	((eq dependency :dependent)
	 (cond ((not (independentp (cdr exp) rhs-bound-vars))
		(values
		 ;; First we have some code for the RHS bound predicates
		 `(do* ((tuples  ALL-TUPLES (cdr tuples))
			(result (build-new-tuple (car TUPLES)
						 (if (car TUPLES)
						     ,(function-call exp (append lhs-bound-vars rhs-bound-vars))))
			 (nconc result (build-new-tuple (car tuples)
							(if (car tuples) ,(function-call exp (append lhs-bound-vars rhs-bound-vars)))))))
		   ((endp tuples) result))
		 
		   
		 (union rhs-bound-vars
		  (set-difference (all-vars (cdr exp))
					lhs-bound-vars))))

	       (t
		(values
		 nil
		 ;; No code
		 ;; but LHS bound vars
		 (union
		  lhs-bound-vars (all-vars (cdr exp)))))

	 
	 ))

	(t (error "~&~S should be either :INDEPENDENT or~
                                     :DEPENDENT.~%" dependency))))

	       
	   

  

(defun function-call (expression vars)
  ;; vars is a list of the variable that will be bound when the
  ;; expression is called.

  `(,(car expression)
     ,.(mapcar #'(lambda (x) (get-var-if-bound x vars))
               (cdr expression))))


(defun get-var-if-bound (exp-var vars)
  (if (member exp-var vars)
      `(bind-val (find ',exp-var (car TUPLES) :key #'bind-var))
      `',exp-var))


#|(defun build-new-tuple (tuple new-bindings)
   (cond ((consp new-bindings)
	  (mapcar #'(lambda (x) (nconc x tuple)) new-bindings))
	 ((null tuple) nil) ; this is because the DO loop doesn't
			    ; terminate until after it makes this
			    ; function call
	 (new-bindings (list tuple))
	 ((null new-bindings) nil)))|#

;;; Jim 8/7/91: I added the #+cmu and #-cmu parts in an effort to get
;;; this code running on allegro as well as CMU Common Lisp. The #-
;;; part should work for all Common Lisps, but the #+ bit might be
;;; faster in CMU Lisp, I dunno really.
(defun build-new-tuple (tuple new-bindings)
  (cond ((and (eq tuple :empty-tuple) (not (consp new-bindings)))
	  (if new-bindings
	      (list tuple) ; (ie (list :empty-tuple))
	      nil))
	((null tuple) nil)
	((not (consp new-bindings))
	 (if new-bindings
	     (list tuple)
	     nil))
	((eq tuple :empty-tuple)
	 new-bindings)
	(t
	 (mapcar #+CMU #'(lambda (x) (nconc x tuple))
		 #-CMU #'(lambda (x) (if (consp x)
					 (nconc x tuple)
					 x))
		 new-bindings))))

(defun print-bindings (x)
  (do* ((i 0 (1+ i))
	(xcdr x (cdr xcdr)))
       ((endp xcdr) nil)

    (format t "~&~:R tuple: ~S.~%" i (car xcdr))))


#|(defun build-new-tuple (tuple new-bindings)
  "If the new-bindings is non-NIL and a cons then it is put onto the
tuple.  A list of tuples is returned.  It must be a list of the 
form ((<var1> val1 val2) (<var2> val3 val4)) where the var# is a prodigy
variable and val# is a prodigy object (ie structure).  If new-bindings
is non-NIL and not a cons then the tuple is returned.  If it is NIL
then nil is returned."

  (cond ((consp new-bindings)
	 (do* ((nbs new-bindings (cdr nbs))
	       (new-binding (car nbs) (car nbs))
	       (result (new-tuples tuple new-binding)
		       (nconc result
			      (new-tuples tuple new-binding))))

	      ((endp nbs) result)))
	  (new-bindings
	   (list tuple))
	  (t nil)))


(defun new-tuples (tuple new-binding)
  (mapcar #'(lambda (binding) (cons binding tuple))
	  (mapcar #'(lambda (prodigy-object)
		      (cons (car new-binding) prodigy-object))
		  (cdr new-binding))))|#

(defun get-prebound-vars (cr)
  (declare (type control-rule cr))
  "Returns a list of the variables that are bound from the right hand
side of the control rule.  If any of the cdr's return a cons instead
of a symbol then an error should result."

  (mapcar #'cdr (fourth (control-rule-then cr))))


(defun independentp (exp vars)
     "EXP is a recursive lisp structure that is examined.  If any leaf
of the structure is a symbol is a prodigy varaible and is in vars (it
will be a prodigy variable) then independentp returns NIL, else
non-NIL."
  
  (cond ((symbolp exp)
	 (if (and (strong-is-var-p exp) (member exp vars))
	     nil
	     t))
 	((consp exp) (and (independentp (car exp) vars)
			  (independentp (cdr exp) vars)))))
