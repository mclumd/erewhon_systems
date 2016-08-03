(in-package :p4)

;;;; SOMETHING IS WRONG WITH THIS IMPLEMENTATION. 
;;;; ******* DO NOT USE *******


;;;; Originally from search.lisp in planner dir, then modified in 
;;;; w:/My Documents/prodigy/working/system/agent/latest-source/patches3.lisp, 
;;;; now changed further here. 
;;;; 


;;; 
;;; changed this to call (plan2vectors (gen-file)) immediately before 
;;; returning. [mcox 10aug11]
;;; 
;;; changed this so that it returns the plan passed to it.  [mcox 28may01]
;;; 
(defun announce-plan (plan)
  (declare (list plan))

  (let ((plevel (or (problem-space-property :*output-level*) 2)))
    (when (> plevel 0)
      (cond ((and (consp (car plan)) (consp (caar plan))
		  (eq (caaar plan) :partial-achieve))
	     (format t "~%i didn't completely solve the problem,")
	     (if (eq (second (car (second (car plan)))) :resource-bound)
		 (format t "~%because i exceeded a resource bound, ~s,"
			 (third (car (second (car plan))))))
	     (format t "~%but i solved ~s of the top-level goals with this plan:~%~%"
		     (length (third (caar plan)))))
	    (t
	     (format t "~%~%solution:~%")))
      (let ((*print-case* :downcase))
	(dolist (op (cdr plan))
	  (princ #\tab)
	  (brief-print-inst-op op)
	  (terpri)))
      (terpri)))
  (setf user::*vector-results*
    (cons (user::plan2vectors 
	   (user::gen-file))
	  user::*vector-results*))
  plan)



