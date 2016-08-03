;;; $Revision: 1.3 $
;;; $Date: 1994/05/30 20:55:57 $
;;; $Author: jblythe $
;;;
;;; REVISION HISTORY
;;;
;;;  $Log: interrupt.lisp,v $
;;; Revision 1.3  1994/05/30  20:55:57  jblythe
;;; Added Tony Maida's patches to have Prodigy run with CMU Lisp 16 and 17.
;;;
;;; Revision 1.2  1994/05/30  20:30:07  jblythe
;;; Added CVS headers so the revision history and descriptions are included in
;;; each changed file.
;;;


;;;
;;; Early functions for doing interrupt handling in Prodigy4
;;;
;;;
;;; Notes: I'd like to use the Common Lisp condition system to do
;;; this, but I don't know if it's actually been adopted in the
;;; language..

(in-package 'p4)

(export '(prod-signal define-prod-handler mask-prod-handler
	  remove-prod-handler clear-prod-signals clear-prod-handlers))

(defparameter *prodigy-handlers* nil
  "Assoc list of condition-function pairs.")

(proclaim '(list *prodigy-handlers*))

(defun prod-signal (type &optional data)
  "Signal a Prodigy condition. \"data\" argument must be a list."
  (declare (special *current-problem-space*))
  (push (cons type data)
	(problem-space-property :signals)))

(defun attend-to-signals ()
  "Deal with signals if declared handler functions exist. This
function also clears all the signals, except any signalled by the
handler functions themselves, which are processed on the next call to
this function."
  (declare (special *current-problem-space*))

  (let ((current-signals (cons (list :always) (problem-space-property :signals))))
    (setf (problem-space-property :signals) nil)
    (dolist (signal current-signals)
      (let ((handler (assoc (car signal) *prodigy-handlers*)))
	(when handler
	  (dolist (handler-func (cdr handler))
	    (let ((decision (funcall handler-func signal)))
	      (if (and (listp decision)
		       (eq (car decision) :stop))
		  (return-from attend-to-signals decision)))))))))

(defun define-prod-handler (condition function)
  "Add a handler function for this condition."
  (declare (symbol condition)
	   (function function)
	   (special *prodigy-handlers*))

  (let ((handlers (or (assoc condition *prodigy-handlers*)
		      (car (push (list condition) *prodigy-handlers*)))))
    (push function (cdr handlers))))

(defun mask-prod-handler (condition function)
  "Mask the current handlers, if any, with this function."
  (push (cons condition function) *prodigy-handlers*))

(defun remove-prod-handler (condition &optional function)
  "Remove a prodigy handler function. If the function is specified, it
will only remove that handler function. Otherwise, all handlers for
that condition will be removed."
  (declare (symbol condition)
	   (special *prodigy-handlers*))

  (let ((handlers (assoc condition *prodigy-handlers*)))
    (if function
	(if (cdr handlers)
	    (setf (cdr handlers) (delete function (cdr handlers))))
	(setf *prodigy-handlers* (delete handlers *prodigy-handlers*)))))

(defun clear-prod-signals ()
  "Get rid of all signals currently awaiting attention."
  (declare (special *current-problem-space*))

  (setf (problem-space-property :signals) nil))

(defun clear-prod-handlers ()
  "Clear all current prodigy signal handlers."
  (declare (special *prodigy-handlers*))
  (setf *prodigy-handlers* nil))