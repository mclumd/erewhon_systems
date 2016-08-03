;;; $Revision: 1.4 $
;;; $Date: 1995/03/13 00:39:20 $
;;; $Author: jblythe $
;;;
;;; REVISION HISTORY
;;;
;;;  $Log: extract-static.lisp,v $
;;; Revision 1.4  1995/03/13  00:39:20  jblythe
;;; General clean-ups, including a definition of gen-from-pred that can have
;;; more than one variable in the literal.
;;;
;;; Revision 1.3  1994/05/30  20:55:48  jblythe
;;; Added Tony Maida's patches to have Prodigy run with CMU Lisp 16 and 17.
;;;
;;; Revision 1.2  1994/05/30  20:29:59  jblythe
;;; Added CVS headers so the revision history and descriptions are included in
;;; each changed file.
;;;


;; The functions here extract the static predicates and their
;; variables from the preconds of an operator.
;; *****************************************************************
;; The functions in this file which will be useful to the RETE net are:

;;   EXTRACT-STATIC-PRECONDS rule var-list1 var-list2
;;     This function will return a test of two lists of objects, each
;;     object corresponds to its var in var-list1 or var-list2.  The
;;     lambda expression checks the state to see if the cross product
;;     of the first list with the second is valid over all the static
;;     predicates in the rule.

;;  BUILD-STATIC-GENERATOR rule var


;; We need all the static preds for a conjunctive preconds, a forall
;; and for an exists.  For disjunctive conditions we will need to
;; return disjuncts of static predicates.  For negations we need to
;; return a negation of the static predicate.

;; Each function takes a list of variables.  Only the operator
;; preconds whose vars are a super set of both the tuple of variables
;; in the argument list.

;; example precond
;; It should be used on the vars (<a> <b> <c> <room1> <room2>)

;; To function correctly this code assumes that all instantiated
;; literals of static predicates are statep t.  If this is not the
;; case then the line (literal-state-p ARG) must be added in the
;; beginning of the conjunct of the lambda expression use the the some
;; call created in the function BUILD-TEST.

(defparameter *rule-precond* 
  '(nil (and (red <a>)
	 (big <b>)
	 (connected <room1> <room2>)
	 (forall (<lots> sometype)
	  (within <lots> <a>))
	 (hot <room1>)
	 (~ (big <room2>))
	 (or (purple <b>)
	  (yellow <d>)
	  (green <d>)
	  (purple <c>)))))

(in-package "PRODIGY4")


;;; Changed to return a function form only when extract-static does
;;; not return nil. When it returns nil, this returns t. Changed all
;;; the calls in generator.lisp to deal with this in order to compile less.
(defun extract-static-preconds (rule vars1 vars2)
  (let* ((tests (extract-static t (third (rule-precond-exp rule)) vars1 vars2)))

    (if tests
      (maybe-compile
	`(lambda (TEST-BINDINGS1 TEST-BINDINGS2)
	  ;; TEST-BINDING# are bindings
	  ;; to be tested
	  ,(if vars2
	       '(declare (special *current-problem-space* TEST-BINDINGS1
			  TEST-BINDINGS2))
	       '(declare (special *current-problem-space* TEST-BINDINGS1)
		     (ignore TEST-BINDINGS2)))
	  ,.tests))
	t)))

(defun merge-precond-and-conditional-effects (rule)
  (let ((precond (third (rule-precond-exp rule)))
	(cond-effects (rule-cond-effects rule)))
    (list :and precond cond-effects)))

(defun rule-cond-effects (rule)
  "Returns a list of all the conditional effects of the rule."
  (mapcan #'get-cond-effect (third (rule-effects rule))))

(defun get-cond-effect (effect)
  (if (eq (car effect) 'user::if)
      (list effect)))

(defun extract-static (parity pred vars1 vars2)
  (case (car pred)
	(user::and (extract-and-static parity pred vars1 vars2))
	(user::or (extract-or-static parity pred vars1 vars2))
	(user::~ (extract-neg-static parity pred vars1 vars2))
	(user::forall (extract-forall-static parity pred vars1 vars2))
	(user::exists (extract-exists-static parity pred vars1 vars2))
	(t
	 (if (and (static-pred-p (car pred))
		  (good-functions pred vars1 vars2))
	     (list (build-test parity pred vars1 vars2))))))


(defun extract-and-static (parity pred vars1 vars2)
  (let ((tests (mapcan #'(lambda (x) (extract-static parity x vars1 vars2))
		       (cdr pred))))
    (if tests
	(list (cons 'and tests)))))

(defun extract-or-static (parity pred vars1 vars2)
  (declare (ignore pred parity vars1 vars2))
  ;; This is actually a very difficult function to write correctly and
  ;; not very useful if it is.  This I will ignore disjuncts.
  nil)

#|    (let ((result (mapcan #'(lambda (x) (extract-static x vars1 vars2))
		    (cdr pred))))
      (if result
	  (list (cons 'or result))
	nil))|#

(defun extract-forall-static (parity pred vars1 vars2)
  (mapcan #'(lambda (x) (extract-static parity x vars1 vars2)) (cddr pred)))

(defun extract-exists-static (parity pred vars1 vars2)
  (mapcan #'(lambda (x) (extract-static parity x vars1 vars2)) (cddr pred)))

(defun extract-neg-static (parity pred vars1 vars2)
  (extract-static (not parity) (second pred) vars1 vars2))
#|
  (let ((stat (extract-static (second pred) vars1 vars2)))
    (if stat (list (cons 'not stat)) nil)))
|#

;; If the variables in both vars lists intersect in some way with the
;; static predicate then we know this will be a constraining test for
;; the tuples to be merged.

#|
(defun constrains-vars-p (literal-args vars1 vars2)
  (or (and (null literal-args) (null vars1) (null vars2))
      (and (intersection-p literal-args vars1)
	   (or (null vars2)
	       (intersection-p literal-args vars2)))))
|#

(defun extract-mixed-statics (parity mixed-pred vars1 vars2)
  (let ((conditional-test
	 (extract-conditional-statics parity (third mixed-pred) vars1 vars2))
	(general-test (extract-static parity  (second mixed-pred) vars1 vars2)))
    (if conditional-test
	(list (append (append '(and) general-test)
		      conditional-test))
	general-test)))

(defun extract-conditional-statics (parity preconds vars1 vars2)
  (let ((condi-test
	 (mapcan #'(lambda (x) (extract-conditional-static parity x vars1 vars2))
		 preconds)))
    (if condi-test
	`((case CONDITION
	    ,.condi-test
	    ((nil) t)
	    (otherwise "error ~%"))))))
	
(defun extract-conditional-static (parity cond vars1 vars2)
  (let ((test (extract-static parity (second cond) vars1 vars2)))
    (if test
	`(((,cond) ,.test)))))

#|
;  This function should be part of the common lisp standard.
(defun intersection-p (list1 list2)
  "Returns non-nil if any element of list1 is in list2, otherwise
returns nil.  Much like using intersection as a predicate, except that
it does no cons'ing."
  (do ((result nil)
       (l1 list1 (cdr l1)))
      ((or result (endp l1)) result)
    (if (member (car l1) list2)
	(setf result t))))
|#

;; These functions build a test for a particular predicate with
;; particular variables.

(defun build-test (parity precond vars1 vars2)

   ;;Each var in vars1 and vars2 represents a position in the precond.
   ;;A precond is an uninstantiated literal (ie literal with vars such
   ;;as (ON <x> <y>).)  It is assumed that vars1 and vars2 are
   ;;independent sets of variables.  The lists posA and posB are
   ;;always of the form (0 1 2 ...).  The are used as counters to be
   ;;passed into the mapcar's.  This may seem like a hack (because it
   ;;is) but it was the easiest way to fix the code.

#|
  (let* ((pos1 (mapcar #'(lambda (x) (position x (cdr precond))) vars1))
	 (pos2 (mapcar #'(lambda (x) (position x (cdr precond))) vars2))
	 (posA (mapcar #'(lambda (x) (position x vars1)) vars1))
	 (posB (mapcar #'(lambda (x) (position x vars2)) vars2)))

    (format t "~& pos1 ~S ~%" pos1)
    (format t "~& pos2 ~S ~%" pos2)
    (format t "~& posA ~S ~%" posA)
    (format t "~& posB ~S ~%" posB) |#
    
   (declare (special *current-problem-space))

       `(let* ((ALL-LITERALS (new-get-literals ',(car precond) *current-problem-space*))
	       (ass (mapcar #'(lambda (x)
				(let ((pos1 (position x ',vars1)))
				  (if pos1
				      (elt TEST-BINDINGS1 pos1)
				      (if (strong-is-var-p x) 
					  (elt TEST-BINDINGS2
					       (position x ',vars2))
					  (object-name-to-object
					   x *current-problem-space*)))))
			    ',(cdr precond)))
	       (lit (and ALL-LITERALS (gethash ass ALL-LITERALS))))
      	 ,(if parity
	      '(and lit (literal-state-p lit))
	      '(not (and lit (literal-state-p lit))))))

#|	 
	 (some #'(lambda (ARG)
		   (declare ,(if vars2 '(special TEST-BINDINGS1 TEST-BINDINGS2)
				 '(special TEST-BINDINGS1)))
;		   (print ARG)
		   (and
		    ,(if parity
			 '(literal-state-p ARG)
			 '(not (literal-state-p ARG)))
		   ,.(mapcar #'(lambda (p1 pA)
				 (if (and p1 pA)
				     (build-binding-test1 p1 pA)
				     t))
			     pos1 posA) 	    
		   ,.(mapcar #'(lambda (p2 pB)
				 (if (and p2 pB)
				  (build-binding-test2 p2 pB)
				  t))
			     pos2 posB)))
		   ALL-LITERALS))))
|#

;; The next two functions build tests to compare the literal value in
;; ARG with the potential binding in TEST-BINDING1.  TEST-BINDING# is
;; a tuple.  If all the tests on each tuple pass then they may be
;; merge in the network.

#|
(defun build-binding-test1 (pos-literal pos-cand-bind)
  `(eq (elt (literal-arguments ARG) ,pos-literal)
    (elt TEST-BINDINGS1 ,pos-cand-bind)))

(defun build-binding-test2 (pos-literal pos-cand-bind)
  `(eq (elt (literal-arguments ARG) ,pos-literal)
    (elt TEST-BINDINGS2 ,pos-cand-bind)))
|#

;; This test is the dummy test that I use to debug the precond parsing.
#|(defun build-test (pred vars1 vars2)
  (list :test-for pred))|#

;; If you are only interested in the possible values of one variable
;; for a particular static predicate that you might prefer to generate
;; those values from the state rather then test all possible objects
;; for that predicate.

#|
(defun build-static-generator (rule var)
  (let* ((extended-precond (merge-precond-and-conditional-effects rule))
	 (test (maybe-compile (extract-static-preconds rule
						       (list var)
						       nil))))
    (find-static-predicate extended-precond var test)))
	 
(defun find-static-predicate (pred var test)
    (cond ((member (car pred) '(user::and
				user::~
				user::or
				user::forall
				user::exists
				:and))
	   (find-static-predicate-in-complex pred var test))
	  ((and (static-pred-p (car pred))
		(constrains-var-p (cdr pred) var))
	   (build-generator-lambda pred var test))
	  (t nil)))
|#

#|
(defun find-static-predicate-in-complex (pred var test)
  (case (car pred)
	(user::and (find-static-in-and pred var test))
	(user::or (find-static-in-or pred var test))
	(user::~ (find-static-in-neg pred var test))
	(user::forall (find-static-in-forall pred var test))
	(user::exists (find-static-in-exists pred var test))
	(:and (find-merged-static pred var test))))

(defun find-static-in-and (pred var test)
 (some #'(lambda (x) (find-static-predicate x var test)) (cdr pred)))

(defun find-static-in-or (pred var test)
  (declare (ignore pred var test))
  ;; This is actually a very difficult function to write correctly and
  ;; not very useful if it is.  This I will ignore disjuncts.
  nil)

(defun find-static-in-exists (pred var test)
  (some #'(lambda (x) (find-static-predicate x var test)) (cddr pred)))

(defun find-static-in-forall (pred var test)
  (some #'(lambda (x) (find-static-predicate x var test)) (cddr pred)))

(defun find-static-in-neg (pred var test)
 (declare (ignore pred var test))
  ;; We can't really use a negation to generate, but this is the same
  ;; as pruning the information in the object-type hierarchy with the
  ;; static predicates.
 nil)

(defun find-merged-static (pred var test)
  (or (find-static-predicate (second pred) var test)
      (find-conditional-static (third pred) var test)))

(defun find-conditional-static (pred var test)
  (declare (ignore pred var test))
  :not-defined-yet)

(defun constrains-var-p (vars var)
  (if (member var vars)
      t nil))
|#
;; Now we need to take the values generated from one static predicate
;; and prune them by all the static predicates.  Since this is such a
;; simple thing to do I don't bother trying to save computation by
;; generating a lambda expression.  Just call it with the static
;; precond, the variable name a previous-values list.  It is
;; destructive so don't pass in a previous-values that you don't want
;; destroyed.

#|
(defun prune-from-static (precond variable previous-values)
  (declare (special *current-problem-space*))
  (let ((pos (1- (position variable precond))))
    (delete-if-not #'(lambda (x)   
		       (member x (get-literals (car precond) 
					       *current-problem-space*)
			       :key #'(lambda (x) (get-nth-value x
								 pos))))
		   previous-values)))


(defun build-generator-lambda (precond variable test)
  (let ((pos (1- (position variable precond))))
    `(lambda (CONDITIONAL)
       (declare (special *current-problem-space*))
       (mapcan #'(lambda (x) (value-matches-test ',test ,pos x CONDITIONAL))
	       (get-literals ',(car precond)
			     *current-problem-space*)))))


(defun value-matches-test (test position literal cond)
  "Returns VALUE (which is a single cons of a literal) if VALUE is ok
with the rest of the static predicates.  It's a little wasteful because
we generate a new cons for every value, even those that don't pass.
The only way around this would be to maintain a free cons someplace.
The problem is that the test requires a list, we should modify that
function to take a single argument."
  (let ((value (get-nth-value literal position)))
    (if (funcall test value cond)
	value
        nil)))

(defun get-nth-value (literal n)
  "Returns a list of one literal."
  (list (elt (literal-arguments literal) n)))


(defun get-literals (predicate p-space)
  "Returns the list of literals for PREDICATE which must be a static
predicate.  This list will be EQ to the list in the assertion hash so
care must be taken not to screw it up."
  (let ((lits (gethash predicate (problem-space-assertion-hash
				  p-space))))
    (if (not (hash-table-p lits))
	lits
      (error "The predicate ~S must be a static predicate.~%"
	     predicate))))
|#

(defun new-get-literals (predicate p-space)
  (gethash predicate (problem-space-assertion-hash p-space)))
