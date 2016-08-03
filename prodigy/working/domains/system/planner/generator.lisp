;;; $Revision: 1.4 $
;;; $Date: 1995/03/13 00:39:22 $
;;; $Author: jblythe $
;;;
;;; REVISION HISTORY
;;;
;;;  $Log: generator.lisp,v $
;;; Revision 1.4  1995/03/13  00:39:22  jblythe
;;; General clean-ups, including a definition of gen-from-pred that can have
;;; more than one variable in the literal.
;;;
;;; Revision 1.3  1994/05/30  20:55:51  jblythe
;;; Added Tony Maida's patches to have Prodigy run with CMU Lisp 16 and 17.
;;;
;;; Revision 1.2  1994/05/30  20:30:01  jblythe
;;; Added CVS headers so the revision history and descriptions are included in
;;; each changed file.
;;;


;; THE GENERATOR is a lambda expression that can be called with a set
;; of partial values.  It will return a set of partial values for
;; every variable in a particular operator.  A partial bindings is of
;; the form ((<x> obj1 obj2 obj3)+ ))

;; Suggestion for future improvement:  The lambda expression
;; generated by this code works on each variable in the same sequence
;; that they appear in the operator.  What would be better would be to
;; do type checks on all the variables that are bound from the right
;; hand side of the operator or inference rule.  This would allow us
;; to return nil for all bindings if the type check fails, saving us a
;; lot of time and cons'ing in the generator.

(in-package 'prodigy4)

(defun build-generator-for-rule (rule)
  (declare (type rule rule))
  (let ((body (mapcar #'(lambda (x)
			  (build-generator-for-var x rule))
		      (second (rule-precond-exp rule)))))
    (if body
	(maybe-compile
	 `(lambda (PARTIAL-BINDING-LIST) (list ,@body))))))

(defun build-generator-for-var (var-spec rule)
  "This builds the generator for one particular variable.  An example
of a specification could be 
        (<thing> (AND (COMP OBJECT BOX) (good <thing>))) 
        or (<on> OBJECT)
Note that the function GOOD is not called as part of the generator,
but will be part of a later test."

    (let ((var (first var-spec))
	  (spec (second var-spec)))
      ;;aperez: June 2 92
      ;;error in FIND below when partial-binding-list equals T (this happens
      ;;when no vars get bound in the partial bindings, for example if
      ;;the effect has no vars)
      ;;ask Mei about this because I may be introducing a big
      ;;inefficiency here
      `(let ((partial (unless (eq PARTIAL-BINDING-LIST T)
			(find ',var PARTIAL-BINDING-LIST :key #'car))))
	 (if partial
	     ,(type-check var spec rule)
	   ,(build-gen var spec rule)))))
	  

;;; Slightly changed by Jim 17/7/91 to call candidate-types only once.
;;; And 31/10/91 to check if the list has length 1. Doing the work of
;;; an optimising compiler. Sigh.
;;; the following change are used for infinite types.

(defun type-check (var spec rule)
  (if (and (listp spec)
	   (is-infinite-type-p (second spec) *current-problem-space*))
      
      `(let ((vals (second partial)))
	(list :inf (cons ',var vals) ',spec ',(operator-vars rule)))

      (let ((candidate-types (candidate-types spec)))
	`(setf (cdr partial)
	  (delete-if-not
	   #'(lambda (x)
	       ,(cond ((is-infinite-type-p spec *current-problem-space*)
		       `(funcall (type-name-to-type
				  ',spec *current-problem-space*) x))
		      ((= (length candidate-types) 1)
		       `(or (eq (prodigy-object-type x) ',(car candidate-types))
			 (child-type-p (prodigy-object-type x)
			  ',(car candidate-types))))
		      (t `(or (member (prodigy-object-type x) ',candidate-types)
			   (some-child-type-p (prodigy-object-type x)
			    ',candidate-types)))))
	   (cdr partial))))))


(defun candidate-types (spec)
  (declare (special *current-problem-space*))
  (cond   ((symbolp spec)
	   (list (type-name-to-type spec *current-problem-space*)))
	  ((eq (car spec) 'user::and)  (candidate-types (second spec)))
	  ((eq (car spec) 'user::or)  (build-type-union (cdr spec)))
	  ((eq (car spec) 'user::comp) (find-comps (cdr spec)))
				
	  (t (error "This is SPEC:  ~S~%" spec))))
  
(defun build-type-union (type-names)
  "Build-type-union builds a list of types from the list of type-names
and then removes any type which is a child of a type already in the list."
  (let ((types (mapcan #'candidate-types type-names)))
    (delete-redundant-types types)
    ))

(defun find-comps (spec)
  "Creates a list of types that are supsets of main-type but do not
contain any thing that is of the types in substract-types.  It is an
error (signaled) for a super type to be subtracted FROM a sub-type or
from itself."
  (let* ((subtractand (car (candidate-types (car spec))))
	 ;;aperez:
	 ;;substractand has to be a type (not a list), but
	 ;;candidate-types returns a list. I added the CAR.  

	 ;;substractor has to be a list of types (not a list of lists)
	 (subtractor (apply #'append 
			    (mapcar #'candidate-types (cdr spec))))

	 (all-good-types (good-children subtractand subtractor)))

    (delete-redundant-types all-good-types)))

(defun good-children (the-type bad-types)
  (declare (type type the-type))

  (cond ((member the-type bad-types)
	 nil)
	((type-sub the-type)
	 (mapcan #'(lambda (x) (good-children x bad-types))
		 (type-sub the-type)))
	(t (list the-type))))
  

(defun delete-redundant-types (list-of-types)
  "Takes a list of types and deletes the types which are children of
types already in the list."
      (delete-duplicates (delete-duplicates list-of-types
					    :test #'child-type-p)
		       :test #'(lambda (x y) (child-type-p y x))
		       :from-end t))

(defun check-sub-types (main-type main-parents children)

  (dolist (child children)
	  (if (member child main-parents)
	      (error "~S is a sub type of ~S.~%" main-type child))))

;; if var is infinite but is always bound through rhs, then this
;; function won't work. 
(defun build-gen (var spec rule)
  (declare (ignore var))
  (cond ((is-infinite-type-p spec *current-problem-space*)
	 nil)
	((and (listp spec)
	      (is-infinite-type-p (second spec) *current-problem-space*))
      ;; maybe I'll change the format for this, but let's just leave
      ;; it like this for now.
	 `(list :inf ',var ',spec ',(operator-vars rule)))
	(t `(mapcan #'get-values-from-types ',(make-type-list spec)))))


;; The biggest killer in this code is probably the next function,
;; GET-VALUES-FROM-TYPES, since it copies whole lists of objects.  We
;; really need to sit down and think of a way to do this more
;; efficiently.

(defun get-values-from-types (type)
  "This function copies the values from the type-object hierarchy and
returns that copy."
  (copy-list (type-instances type)))

(defun make-type-list (spec)
  (declare (special *current-problem-space*))
  (cond ((symbolp spec) (list (type-name-to-type spec *current-problem-space*)))
	((eq (car spec) 'user::and) (make-type-list (second spec)))
	((eq (car spec) 'user::or)  (mapcan #'name-and-list (cdr spec)))
	((eq (car spec) 'user::comp) (find-comps (cdr spec)))))

(defun name-and-list (spec)
  (declare (special *current-problem-space*))
  (list (type-name-to-type spec *current-problem-space*)))

