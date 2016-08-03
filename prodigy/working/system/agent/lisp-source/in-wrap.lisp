(in-package :user)

#|
(unless (find-package "Transducer")
  (make-package "Transducer" :nicknames '("Trans")))

(in-package "Transducer")
|#


(defun input-wrapper (port-num
		      &optional 
		      style
		      domain
		      problem)
  (if style
      (setf *current-style*
	style))
  (if domain
      (user::domain
       (setf *default-domain*
	 domain)))
  (if problem
      (user::problem 
       (setf *default-prob*
	 problem)))
  )

