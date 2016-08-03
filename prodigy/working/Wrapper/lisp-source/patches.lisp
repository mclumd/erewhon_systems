;;;;
;;;; NOT USED 
;;;;

;;; Replaces the function from plan2frames.lisp. This version is a temp one for
;;; writing to standard output.
;;;
(defun normalize-and-write-step (op stream) 
  (declare (type p4::instantiated-op op)
	   (stream stream))
  (let ((out stream)
	(plan-step 
	 (p4::instantiated-op-op op)))
    (format out "~A" *default-data-line*)
    (format 
     out 
     "~S" 
     (cons 
      (p4::operator-name 
       plan-step)
      (mapcar 
       #'(lambda (x y)
	   (list  
	    x 
	    (cond ((typep y 
			  'p4::prodigy-object)
		   (p4::prodigy-object-name y))
		  ((null y) 
		   nil)
		  ((listp y) 
		   '("et cetera"))
		  (t  
		   y))
	    ))
       (p4::operator-vars plan-step)
       (p4::instantiated-op-values op)
       )
      )
     )
    (format out ")~%")
    
    )
  )
