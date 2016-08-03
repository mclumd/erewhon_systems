;;; $Revision: 1.3 $
;;; $Date: 1994/05/30 20:55:37 $
;;; $Author: jblythe $
;;;
;;; REVISION HISTORY
;;;
;;;  $Log: circular.lisp,v $
;;; Revision 1.3  1994/05/30  20:55:37  jblythe
;;; Added Tony Maida's patches to have Prodigy run with CMU Lisp 16 and 17.
;;;
;;; Revision 1.2  1994/05/30  20:29:49  jblythe
;;; Added CVS headers so the revision history and descriptions are included in
;;; each changed file.
;;;


(in-package 'user)

(defun find-circular-structure (arg previous-cons)

  (cond ((not (consp arg)) nil)

	((member arg previous-cons)
	 arg)

	(t (or (find-circular-structure (car arg) (cons arg previous-cons))
	       (find-circular-structure (cdr arg) (cons arg previous-cons))))))

