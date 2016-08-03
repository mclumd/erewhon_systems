;;; This file is now part of x-analogy-support.lisp in ~/prodigy/analogy/Development


;;; Not really predicate. Returns a list of open variable arguments (instances)
;;; and associated types.
;;;
(defun has-open-vars-p (case
			case-header
			&aux 
			(case-name
			 (case-header-name
			  case-header))
			(subst-map 
			 (fourth 
			  case))
			(inst-map 
			 (case-header-insts-to-vars
			  case-header))
			(objects
			 (case-header-objects
			  case-header))
			open-vars)
;;;  (print case-name)
;;;  (terpri)
;;;  (print subst-map)
;;;  (terpri)
;;;  (print inst-map)
;;;  (terpri)
;;;  (break)
  (dolist (each-goal (case-header-goal case-header))
	  (dolist (each-arg (rest each-goal))
		  (if (not
		       (assoc
			(rest
			 (assoc 
			  each-arg
			  inst-map))
			subst-map))
		      (setf open-vars
			    (cons
			     (list (rest
				    (assoc 
				     each-arg
				     inst-map))
				   (get-object-type-from-header
				    objects
				    each-arg))
			     open-vars))
		    )))
  open-vars
  )


(defun get-object-type-from-header (objects 
				    instance
				    &aux
				    (object-id
				     (first 
				      (member instance 
					      objects
					      :test
					      #'member))))
  (first (last object-id))
  )


(defun make-open-var-substitutions (&aux
				    open-vars)
  (dolist (each-case *replay-cases*)
	  (when (setf
		 open-vars
		 (has-open-vars-p 
		  each-case
		  (first
		   (member (first each-case)
			   *case-headers*
			   :test
			   #'(lambda (x y)
			       (equal x 
				      (case-header-name 
				       y)))))))
		(format t 
			"~%Case ~s has open variables ~s.~%"
			(first each-case)
			open-vars)
		(dolist (each-open-var open-vars)
			(setf (fourth each-case)
			      (cons 
			       (cons (first each-open-var)
				     (get-instance-from-current-context
				      (first (rest each-open-var))))
			       (fourth each-case)))
			)
		))
  )



(defun get-instance-from-current-context (type-id
					  &aux
					  (prodigy-type
					   (is-type-p 
					    type-id
					    *current-problem-space*)))
  (p4::prodigy-object-name
   (first 
    (p4::type-instances 
     prodigy-type)))
  )


