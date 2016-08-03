;;; $Revision: 1.3 $
;;; $Date: 1994/05/30 20:55:53 $
;;; $Author: jblythe $
;;;
;;; REVISION HISTORY
;;;
;;;  $Log: goal-loop.lisp,v $
;;; Revision 1.3  1994/05/30  20:55:53  jblythe
;;; Added Tony Maida's patches to have Prodigy run with CMU Lisp 16 and 17.
;;;
;;; Revision 1.2  1994/05/30  20:30:03  jblythe
;;; Added CVS headers so the revision history and descriptions are included in
;;; each changed file.
;;;


(in-package "PRODIGY4")
(defun goal-loop-p (node goal)
  (member goal
	  (problem-space-expanded-goals
	   *current-problem-space*)))


