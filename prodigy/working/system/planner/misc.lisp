;;; $Revision: 1.3 $
;;; $Date: 1994/05/30 20:56:18 $
;;; $Author: jblythe $
;;;
;;; REVISION HISTORY
;;;
;;;  $Log: misc.lisp,v $
;;; Revision 1.3  1994/05/30  20:56:18  jblythe
;;; Added Tony Maida's patches to have Prodigy run with CMU Lisp 16 and 17.
;;;
;;; Revision 1.2  1994/05/30  20:30:30  jblythe
;;; Added CVS headers so the revision history and descriptions are included in
;;; each changed file.
;;;


(in-package "PRODIGY4")
;; This file contains PRODIGY 4 routines that are common to many
;; files.  Sometimes one function is useful in two different files
;; that are really not dependent on one anonther.  Those functions
;; should be places in MISC.LISP

(export '(ptrace))

(defun all-vars (exp)
  "EXP is a recursive cons structure.  Every leaf that is a prodigy
variable is returned in a list."
  
  (cond ((symbolp exp)
	 (if (strong-is-var-p exp)
	     (list exp)
	     nil))
 	((consp exp) (nunion (all-vars (car exp))
			    (mapcan #'all-vars (cdr exp))))))

(defun strong-is-var-p (sym)
  (and (symbolp sym)
       (char= #\< (char (symbol-name sym) 0))
       (char= #\> (char (symbol-name sym) (1- (length (symbol-name sym)))))))

(deftype prodigy-variable ()
  "Type specifier for prodigy variables; those of the form <name>"
  '(and symbolp
        (satisfies strong-is-var-p)))

(defun format? (flag &rest args)
  (declare (special *prodigy-print-flags*))
"If FLAG is a member of the dynamically scoped variable *prodigy-print-flags*
The format will be APPLY'ed to args."

  (if (member flag *prodigy-print-flags*)
      (apply #'format args)))

(defmacro ptrace (symbol)
  "Like trace except that the symbol is assumed to be in the PRODIGY4 package."
  `(trace ,(find-symbol (symbol-name symbol) (find-package "PRODIGY4"))))


(defun remove-problem-space (p-space)
  (declare (type problem-space p-space)
	   (special *package*))
  "This will remove all references to problem spaces not in the list."

  (let ((object-indicator (problem-space-object p-space))
	(type-indicator  (problem-space-type p-space))
	(count 0))
    (declare (fixnum count))

    (do-symbols (sym *package*)
      (when (eq (symbol-package sym) *package*)
	(incf count)
	(remprop object-indicator sym)
	(remprop type-indicator sym)))
  (format t "~&Properties of ~D symbol~:P removed.~%" count)))
			      

