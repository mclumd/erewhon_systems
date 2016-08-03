(defparameter *default-style*
    '(:style 
      (default
       (start      (lambda (stream)
;		     (setf *op-list* nil)
			)
	   )
       (head-print (lambda (head stream)
		     (setf *current-head*
		       (apply 
			#'(lambda (symbol)
			    (gentemp 
			     (string
			      (intern
			       (coerce
				(append
				 (coerce
				  (string symbol)
				  'list)
				 (list #\.))
				'string)))))
			(list head)))
		     )
	)
       (role-print (lambda (role stream)
		     (format stream 
			     "~s ~s ~s~%"  
			     *current-head*
			     (second role)
			     (first role))
		     )
	)
       (done       (lambda (stream)
		     nil
		     )
	) 
       )				;jer-sen
      )
  )



