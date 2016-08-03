;;; $Revision: 1.1 $
;;; $Date: 1994/05/30 20:55:50 $
;;; $Author: jblythe $
;;;
;;; REVISION HISTORY
;;;
;;;  $Log: funcall-patch.lisp,v $
;;; Revision 1.1  1994/05/30  20:55:50  jblythe
;;; Added Tony Maida's patches to have Prodigy run with CMU Lisp 16 and 17.
;;;

;;; Created by Anthony Maida, February 94 
;;;
;;; Makes funcall accept lambda forms as arguments
;;; so that Prodigy4 runs in CMU Common Lisp 17c
;;; (Also seems to work for CMU Common Lisp 16 - Jim)

(in-package  "PRODIGY4")

(shadow 'funcall)

(defun funcall (fn &rest args)
  (apply #'common-lisp::funcall
        `(,(make-funcall-compatible-with-CMU-lisp fn)
          ,@args)))

(defun make-funcall-compatible-with-CMU-lisp (fn)
  (if (and (consp fn) (eq (car fn) 'lambda))
      (eval `(function ,fn))
      fn))
