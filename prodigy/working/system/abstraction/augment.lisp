;;;
;;; This file makes use of the axioms to augment the problem space
;;; before using the reduced model approach in abstraction. It's based
;;; on stuff from select-hierarchy in alpine.
;;;

#-clisp
(unless (find-package "PRODIGY4")
	(make-package "PRODIGY4" :nicknames '("P4") :use '("LISP")))

(in-package  "PRODIGY4")


(defun augment-goal-expr (goal-expr &optional (declarations nil) (ground nil))
  (cond ((null goal-expr) nil)
	((member (car goal-expr) '(user::forall user::exists))
	 goal-expr)
	((eq (car goal-expr) 'user::or)
	 (cons 'user::or
	       (augment-or-expr (cdr goal-expr) declarations ground)))
	((eq (car goal-expr) 'user::and)
	 (cons 'user::and
	       (augment-and-expr (cdr goal-expr) (cdr goal-expr)
				 declarations ground)))
	(t
	 (let ((augmentations
		(augment-goal goal-expr (problem-space-property
					 :axioms) nil declarations ground)))
	   (if augmentations
	       (cons 'user::and (cons goal-expr augmentations))
	       goal-expr)))))

(defun augment-or-expr (or-expr decls ground)
  (cond ((null or-expr) nil)
	((member (caar or-expr) '(user::forall user::exists))
	 (cons (car or-expr)
	       (augment-or-expr (cdr or-expr) decls ground)))
	;; Otherwise assume it's a literal (no nesting)
	(t
	 (let ((augmentations (augment-goal (car or-expr) (problem-space-property :axioms)
					    nil decls ground)))
	   (cons
	    (if augmentations
		(cons 'user::and (cons (car or-expr) augmentations))
		(car or-expr))
	    (augment-or-expr (cdr or-expr) decls ground))))))

(defun augment-and-expr (and-expr exp-list decls ground)
  (cond ((null and-expr) nil)
	((member (caar and-expr) '(user::forall user::exists))
	 (cons (augment-goal-expr (car and-expr) decls ground)
	       (augment-and-expr (cdr and-expr) exp-list decls ground)))
	(t
	 (let ((augmentations (augment-goal (car and-expr)
					    (problem-space-property :axioms)
					    exp-list decls ground)))
	   (cons (car and-expr)
		 (augment-and-expr (append augmentations (cdr and-expr))
				   (append exp-list augmentations)
				   decls ground))))))

(defun augment-goal (exp axioms exp-list &optional (decls nil) (ground nil))
  (cond ((null axioms) nil)
	((let ((new-bindings (abs-match (list (caar axioms)) (list exp)
					'(((nil))) decls (extract-vars exp))))
	   (if new-bindings
	       (augment-exp-list exp-list (cdar axioms)
				 nil new-bindings decls ground))))
	(t (augment-goal exp (cdr axioms) exp-list decls ground))))

(defun augment-exp-list (exp-list augmentation unmatched-aug bindings decls ground)
  (cond ((null augmentation)
	 (if ground
	     (remove-var-lits (reverse (sublis (car bindings) unmatched-aug)))
	     (reverse (sublis (car bindings) unmatched-aug))))
	(t
	 (let ((new-bindings (abs-match (list (car augmentation)) exp-list
					bindings
					decls (extract-vars exp-list))))
	   (if new-bindings
	       (augment-exp-list exp-list (cdr augmentation)
				 unmatched-aug new-bindings decls ground)
	       (augment-exp-list exp-list (cdr augmentation)
				 (cons (car augmentation) unmatched-aug)
				 bindings decls ground))))))

(defun remove-var-lits (lits)
  (cond ((null lits) nil)
	((and (has-vars (car lits))
	      (not (member (caar lits)
			   (problem-space-static-preds *current-problem-space*))))
	 (remove-var-lits (cdr lits)))
	(t (cons (car lits) (remove-var-lits (cdr lits))))))

(defun has-vars (lit)
  (some #'strong-is-var-p
	(if (eq (car lit) 'user::~)
	    (cdr (second lit))
	    (cdr lit))))

;;;=======================================
;;; Matching stuff
;;;=======================================

;;; So how many matchers are there in 4.0 now? This must be
;;; inefficient (certainly for the coders if no-one else!).
;;; Oh well.

(proclaim '(special *MATCH-TRACE*))
(defvar *MATCH-TRACE* nil
  "Prints out stuff about the matcher used with the abstraction axioms.")

(defun abs-match (e1 e2 bindings decls &optional notvars)
  (unless (listp bindings)
    (error "Illegal binding list in abstraction matcher."))
  (when *MATCH-TRACE*
    (format t "~%~%Exp1: ")
    (princ e1)
    (format t "~%Exp2: ")
    (princ e2)
    (format t "~%Bindings: ")
    (princ bindings)
    (format t "~%Result: "))
  (let ((result (abs-matcher e1 e2 bindings decls notvars)))
    (if *MATCH-TRACE* (princ result))
    result))

(defun abs-matcher (exp1 exp2 blsts decls notvars)
  (cond ((null exp1) blsts)
	(t (let ((new-blsts (remove-duplicates 
			     (abs-match-each (car exp1) exp2 blsts
					     decls notvars)
			     :test #'equal)))
	     (cond ((not (null new-blsts))
		    (abs-matcher (cdr exp1) exp2 new-blsts decls notvars)))))))

(defun abs-match-each (lit1 exp2 blsts decls notvars)
  (cond ((null exp2) nil)
	(t (let ((new-blsts (abs-match-each-blst lit1 (car exp2) blsts
						 decls notvars)))
	     (cond ((null new-blsts)
		    (abs-match-each lit1 (cdr exp2) blsts decls notvars))
		   (t (append new-blsts 
			      (abs-match-each lit1 (cdr exp2) blsts
					      decls notvars))))))))

(defun abs-match-each-blst (lit1 lit2 blsts decls notvars)
  (cond ((null blsts) nil)
	(t (let ((new-blsts (also-unify lit1 lit2 (car blsts) decls notvars)))
	     (cond ((null new-blsts)
		    (abs-match-each-blst lit1 lit2 (cdr blsts) decls notvars))
		   (t (cons new-blsts 
			    (abs-match-each-blst lit1 lit2 (cdr blsts)
						 decls notvars))))))))


;;;
;;; This function takes two expressions and a list of bindings and attempts to
;;; unify them.  It assumes that the variable names in each expression are unique
;;; from those in the other expression.  The initial blst should be ((nil . nil)) 
;;; and the function returns nil if it fails to unify. 
;;;
(defun also-unify (x y blst decls notvars)
  (let ((x (sublis blst x))
	(y (sublis blst y)))
    (cond ((and (null x)(null y)) blst)
	  ((eq x y) blst)
	  ((and (isa-var notvars x)
		(eq (arg-type x decls)(arg-type y decls)))
	   (deref (acons x y blst)(acons x y blst) notvars))
	  ((and (isa-var notvars y)
		(eq (arg-type x decls)(arg-type y decls)))
	   (deref (acons y x blst)(acons y x blst) notvars))
	  ((not (and (listp x)(listp y)))
	   (if (eq x y) blst))
	  (t (let ((car-blst (also-unify (car x)(car y) blst decls notvars)))
	       (cond ((null car-blst) nil)
		     (t (also-unify (cdr x)(cdr y) car-blst decls notvars))))))))

;;;
;;; Takes a binding list (the first and second argument should be identical)
;;; and derefereces all the variables in that list.  This means it takes
;;; the cdr of each association pair, checks to see if it is a variable and
;;; then replaces it with any corresponding bindings if it is.
;;;
(defun deref (blst entire-blst notvars)
  (cond ((null blst) nil)
	((isa-var notvars (cdar blst))
	 (cond ((null (assoc (cdar blst) entire-blst))
		(cons (car blst)(deref (cdr blst) entire-blst notvars)))
	       (t (cons (cons (caar blst)(cdr (assoc (cdar blst) entire-blst)))
			(deref (cdr blst) entire-blst notvars)))))
	(t (cons (car blst)(deref (cdr blst) entire-blst notvars)))))

(defun isa-var (notvars x)
  (and (strong-is-var-p x)
       (not (member x notvars))))

(defun extract-vars (tree)
  (cond ((null tree) tree)
	((consp tree)
	 (append (extract-vars (car tree))
		 (extract-vars (cdr tree))))
	((strong-is-var-p tree) (list tree))))


;;; Determine the type of an argument.  Arguments are of the form: foo.bar
;;; where foo is the type and the .bar is optional, but is used to distinguish 
;;; multiple variables of the same type.  If typing is turn off simply use 
;;; type for every variable.  Note that types are stored under the argument name
;;; to avoid redoing the typing.
;;;
(defun arg-type (arg decls)
  (cond ((strong-is-var-p arg)
	 (var-type arg decls))
	((symbolp arg)
	 (type-name (prodigy-object-type (object-name-to-object
					  arg *current-problem-space*))))))

;;; Determines the type of a argument by recurring through the string until 
;;; either a '.' or a '>' is reached.
;;;
(defun argument-type (arg-string pos)
  (cond ((or (= pos (array-dimension arg-string 0))
	     (eq #\. (schar arg-string pos))
	     (eq #\> (schar arg-string pos)))
	 nil)
	((eq #\< (schar arg-string pos))
	 (argument-type arg-string (1+ pos)))
	(t (concatenate 'string 
			(string (schar arg-string pos))
			(argument-type arg-string (1+ pos))))))

(defun check-arg-type (type)
  (if (type-name-to-type type *current-problem-space*)
      type))
