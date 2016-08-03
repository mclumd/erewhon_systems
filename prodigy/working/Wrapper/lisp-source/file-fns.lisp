(in-package :user)

(defvar *ready1-file-name* "/tmp/ready1.txt")
(defvar *ready2-file-name* "/tmp/ready2.txt")
(defvar *data-file-name* "/tmp/data.txt")


;;; 
;;; Added optional non-blocking argument set to nil by default. When t, the
;;; system does not wait for input. If input does not exist, it
;;; returns. [28jul00 cox]
;;; 
(defun get-file-message (&optional 
			 (r-f-name 
			  *ready1-file-name*)
			 (d-f-name 
			  *data-file-name*)
			 non-blocking
			 &aux
			 request)
  (when (if non-blocking
	    (probe-file r-f-name)
	  (ready r-f-name))
    (with-open-file
	(data-file d-f-name
	 :direction :input)
      (cond ((or (eq (setf request (read data-file))
		     'run-request)
		 (eq request
		     'savep-request))
	     (let* ((obj-list (read data-file))
		    (state-list (read data-file))
		    (goal-list (read data-file))
		    )
	       (values request obj-list state-list goal-list)
	       ))
	    (t ;Will handle case for p4p-agent
	     request)
	    )
      )
    )
  )



(defun ready (&optional 
	       (r-f-name 
		*ready1-file-name*))
  (do ()
      ((probe-file r-f-name)
       t))
  )


;;; Signals to GTrans that data.txt is ready to examine.
(defun create-ready-file (&optional 
			  (r-f-name 
			   *ready2-file-name*))
  (with-open-file
      (ready-file r-f-name
       :direction :output
       :if-exists :append
       :if-does-not-exist :create
       )
    (format ready-file "ready")
    (format 
     t 
     "~%Creating READY file ~S~%"
     r-f-name )
    )
  (send-shell (format nil "chmod  og+rw ~s~%" r-f-name) 
  	      *registrar-shell*)
  )


(defun write-list (output-file alist)
  (cond ((null alist)
	 nil)
	(t
	 (format output-file 
		 "~s~%"
		 (first alist))
	 (write-list output-file (rest alist)))
	)
  )


(defun create-data-file (alist
			 &optional 
			  (d-f-name 
			   *data-file-name*))
  (with-open-file
      (data-file d-f-name
       :direction :output
       :if-exists :overwrite
       :if-does-not-exist :create
       )
    (write-list data-file alist)
    )
    (format 
     t 
     "~%Creating DATA file ~S~%"
     d-f-name )
    (send-shell (format nil "chmod  og+rw ~s~%" d-f-name) 
  	      *registrar-shell*)
  )
