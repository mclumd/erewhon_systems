(defparameter *default-style*
    '(:style 
      (default
	  (start      (lambda (stream)
			(format stream "~%< ")
			)
	   )
	  (head-print (lambda (head stream)
			(format stream "~s "  head)
			)
	   )
	(role-print (lambda (role stream)
		      (if (second role)
			  (format stream "~s "  (second role)))
		      )
	 )
	(done (lambda (stream)
		(format stream ">"))
	 ) 
	)				;Boris
      )
  )
