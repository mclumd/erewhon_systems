;;; $Revision: 1.4 $
;;; $Date: 1995/03/13 00:39:18 $
;;; $Author: jblythe $
;;;
;;; REVISION HISTORY
;;;
;;;  $Log: extract-functions.lisp,v $
;;; Revision 1.4  1995/03/13  00:39:18  jblythe
;;; General clean-ups, including a definition of gen-from-pred that can have
;;; more than one variable in the literal.
;;;
;;; Revision 1.3  1994/05/30  20:55:46  jblythe
;;; Added Tony Maida's patches to have Prodigy run with CMU Lisp 16 and 17.
;;;
;;; Revision 1.2  1994/05/30  20:29:57  jblythe
;;; Added CVS headers so the revision history and descriptions are included in
;;; each changed file.
;;;


;; This code extracts the functions from the precond binding
;; specifications of an operator.  A set of precond binding
;; specifications can have conjunctive elements with functions as
;; filters.  Here is an example:
;;    (<underob> (and OBJECT (diff <ob> <underob>))))

;; The function diff can be extracted and used in the matcher as an
;; n-test that compares two tuples together.

;; The function EXTRACT-BINDING-SPEC-FUNCTIONS is the top level
;; function that should be called to build the match tests the
;; function is called with two lists of variables and a rule (operator
;; or inference rule) and returns a lambda expression that will call
;; all tests that combine the two lists of variables.

(in-package "PRODIGY4")

(defun EXTRACT-BINDING-SPEC-FUNCTIONS (rule vars1 vars2)
  (let ((extracted-functions
	 (extract-functions (second (rule-precond-exp rule)) vars1 vars2)))
    (if extracted-functions
	`(lambda (TEST-BINDINGS1 TEST-BINDINGS2)
	   ;; TEST-BINDING# are bindings
	   ;; to be tested
	   ,(if vars2
		'(declare (special *current-problem-space* TEST-BINDINGS1 TEST-BINDINGS2))
	      '(declare (special *current-problem-space* TEST-BINDINGS1)
			(ignore TEST-BINDINGS2)))
	   (and ,.extracted-functions))
      t)))

(defun merge-precond-and-cond-bind-spec (rule)
  (append (second (rule-precond-exp rule))
	  (second (rule-effects rule))))

(defun extract-functions (specs vars1 vars2)
  (let ((relevant-functions (mapcan #'(lambda (x) (get-functions
						   (second x) vars1 vars2))
				    specs)))
    (mapcar #'(lambda (x) (build-function-call x vars1 vars2))
	    relevant-functions)))

(defun build-function-call (x vars1 vars2)
  (cons (substitute-internal (car x)) ; Rujith - substitute internal fns.
	(build-argument-list (cdr x) vars1 vars2)))

(defun build-argument-list (arg-list vars1 vars2)
  (mapcar #'(lambda (x)
	      (if (strong-is-var-p x)
		  (do-arg-replacement x vars1 vars2)
		  x))
	  arg-list))

(defun do-arg-replacement (var-name vars1 vars2)
  (if (member var-name vars1)
      `(elt TEST-BINDINGS1 ,(position var-name vars1))
      `(elt TEST-BINDINGS2 ,(position var-name vars2))))

(defun get-functions (spec vars1 vars2)
  "If spec is an AND returns functions relevant to both vars1 and vars2."

  (declare (special *current-problem-space*))
  (cond ((and (listp spec) (eq (car spec) 'user::and))
;	 (format t "~&There is a function to get.~%")

	 (if (is-infinite-type-p (second spec) *current-problem-space*)
	     (mapcan #'(lambda (x) (good-functions x vars1 vars2))
		     (cdddr spec))
	     (mapcan #'(lambda (x) (good-functions x vars1 vars2))
		     (cddr spec))))
	(t nil)))

#|
(defun good-functions (func vars1 vars2)
  (cond ((and (intersection-p (cdr func) vars1)
	      (intersection-p (cdr func) vars2))
	 (list func))
	 (t nil)))
|#

;; works only for the case where i extract functions whose join tests
;; are from right to left, so vars2 is a list of single var.
(defun good-functions (func vars1 vars2)
  (let ((vars (all-vars func)))
    (cond ((= 1 (length vars))
	   (and (null vars1) (equal vars2 vars) (list func)))
	  (t (and vars1
		  (every #'(lambda (x) (if (strong-is-var-p x)
					   (or (member x vars1)
					       (member x vars2))
					   t))
			 vars)
		  (list func))))))
	     
#|
  (if (and (member (car vars2) (cdr func))
	   (or (and vars1
		    (intersection vars1 (cdr func))
		    (every #'(lambda (x) (if (strong-is-var-p x)
					     (or (member x vars1)
						 (member x vars2))
					     t))
			   (cdr func)))
	       (and (null vars1)
		    (notany #'strong-is-var-p
			    (set-difference (cdr func) vars2)))))
      (list func)))
|#

	
   

