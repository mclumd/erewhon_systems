;;; $Revision: 1.4 $
;;; $Date: 1995/10/03 11:04:48 $
;;; $Author: jblythe $
;;;
;;; REVISION HISTORY
;;;
;;;  $Log: matching.lisp,v $
;;; Revision 1.4  1995/10/03  11:04:48  jblythe
;;; Commiting files that were inadvertently edited in the working version
;;; release - two formatting edits by khaigh and a change to printing
;;; instantiated ops when a case is being used for guidance by mmv.
;;;
;;; Revision 1.3  1994/05/30  20:56:12  jblythe
;;; Added Tony Maida's patches to have Prodigy run with CMU Lisp 16 and 17.
;;;
;;; Revision 1.2  1994/05/30  20:30:23  jblythe
;;; Added CVS headers so the revision history and descriptions are included in
;;; each changed file.
;;;


(in-package "PRODIGY4")

;;; meta-predicate should be written in such a way that
;;; its arguments can be either a variable, or real
;;; object.  They are just like domain functions.  They
;;; they return NIL if the exp doesn't match, T if the exp
;;; is matched and doesn't have any variables, or a list
;;; or binding-lists if the exp matches and has variables.



(defun match-lhs (lhs node)
  (descend-match lhs node nil))



;;; bingins is a binding-list; it returns list-of-binding-list
;; Karen: feb 14, 1995: I don't believe that "node" is used
;;        by any of the children... this fact is used by
;;        the footprinter and by the control rules for applied-ops
(defun descend-match (expr node bindings &optional type-declarations)
  (cond ((eq expr t) (list bindings))
	((eq (car expr) 'user::and)
	 (and-match (cdr expr) node bindings type-declarations))
	((eq (car expr) 'user::or)
	 (or-match (cdr expr) node bindings type-declarations))
	((eq (car expr) 'user::exist)
	 (exists-match  expr node bindings type-declarations))
	((eq (car expr) 'user::forall)
	 (error "Sorry, cannot do forall matching yet. ~%"))
	((eq (car expr) 'user::~)
	 (negation-match (cadr expr) node bindings type-declarations))
	(t (let ((vals (gen-values expr bindings type-declarations)))
	     (cond ((null vals) nil)
		   ((eq vals t) (list bindings))
		   ((mapcar #'(lambda (b)
				(if (listp b)
				    (nconc b bindings)
				    b))
			    vals)))))))

;;; this should return list-of-binding-list; bindings is a binding-list.
;;;  Returns all the matchings of exp.
(defun gen-values (expr bindings &optional type-declarations)
  (declare (special *current-problem-space*))
  (if (member (car expr) (problem-space-all-preds *current-problem-space*))
      (funcall #'user::known
	       (sublis bindings expr) type-declarations)
      (apply (substitute-internal (car expr)) ; Rujith - subst. internal fn
	     (sublis bindings (cdr expr)))))


;;; expr looks like (exist (<x> <y>) (pred ...)), returns list-of-binding-list
;(defun exists-match (expr node bindings)
;  
;  (let* ((vars (second expr))
;	(exp (third expr))
;	(real-binding (remove-if #'(lambda (x)
;				     (shadowed-by-vars vars x)))))))


(defun and-match (exprs node bindings type-declarations)
  (cond ((null exprs) (list bindings))
	((null (cdr exprs))
	 (descend-match (car exprs) node bindings type-declarations))
	(t (let ((new-bls 
		  (descend-match (car exprs) node bindings type-declarations)))
	     (and new-bls
		  (mapcan #'(lambda (new-b)
			      (and-match (cdr exprs) node new-b
					 type-declarations))
			  new-bls))))))


;;; negation-match is not used as generator for variables in control rules.
;;; it only returns T or F.

(defun negation-match (expr node bindings type-declarations)
  (cond ((eq expr t) nil)
	((eq (car expr) 'user::exist)
	 (negated-exists-match expr node bindings type-declarations))
	((atom (car expr))
	 (negated-pred-match expr node bindings type-declarations))
	(t (error "~% NEGATION-MATCH: bad expression ~A" expr))))



;;; this will not generate bindings, it only reture true or false.
;;; the expr looks like:  (exist (<x> <y>) (pred ...))

(defun negated-exists-match (expr node bindings type-declarations)

  (let* ((vars (second expr))
	 (exp (third expr))
	 (real-binding (remove-if #'(lambda (x)
				      (shadowed-by-vars vars x))
				  bindings))
	 (matching-result (descend-match exp node real-binding
					 type-declarations)))
    (if (not matching-result)
	(list bindings)
	nil)))


;;; binding should look like (<x> . A), vars is a list of variables,looks
;;; like (<x> <y>).

(defun shadowed-by-vars (vars binding)
  (some #'(lambda (var) (eq var (car binding))) vars))

;;; for negation match, after substituting variables in EXP with
;;; BINDINGS, there should NOT be any variables left in EXPR.  

(defun negated-pred-match (expr node bindings type-declarations)
  (let ((arguments (substitute-binding (cdr expr) bindings)))
    (if (has-unbound-vars arguments)
	(error "~% NEGATED-PRED-MATCH: there are unbound vars in expr "
	       "~A " expr)
	(if (not (descend-match expr node bindings type-declarations))
	    (list bindings)
	    nil))))




(defun or-match (expr node bindings type-declarations)
  (do* ((exp expr (cdr exp))
	(ex (car exp) (car exp))
	(arguments (substitute-binding (cdr ex) bindings))
	(notbound (has-unbound-vars arguments)
		  (has-unbound-vars arguments))
	(result (unless (or notbound (endp exp))
		  (descend-match ex node bindings type-declarations))
		(unless (or notbound (endp exp))
		  (descend-match ex node bindings type-declarations))))
       ((or notbound result (endp exp))
	(if notbound
	    (error "~%OR-MATCH: has unbound vars in expr ~A" expr)
	    (if result (list bindings) nil)))
    ))


(defun predicate-value (expr)
  (or (null expr) (eql expr t)))


(defun list-of-binding-lists-p (expr)
; is expression of the form (((<var> . val) ...)))
  (and (listp expr) (every #'binding-list-p  expr) t))


(defun binding-list-p (expr) 
  (and (listp expr) (every #'binding-p expr) t))


(defun binding-p (x)
  (and (listp x) 
       (symbolp  (car x))
       (atom (cdr x))))

(defun has-unbound-vars (expr)
  (cond ((atom expr)
	 (strong-is-var-p expr))
	(t (or (has-unbound-vars (car expr))
	       (has-unbound-vars (cdr expr))))))
#|

	 (or (some #'p4::strong-is-var-p expr)
	     (mapcar #'has-unbound-vars
	      (remove-if #'symbolp expr))))))
|#

