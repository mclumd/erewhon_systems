(in-package :user)

;;; The following loads need not be done in one-way communication. 
(load "/usr/local/mcox/Research/PRODIGY/Wrapper/P4P/fake-P4P.lisp")
(load "/usr/local/mcox/Research/PRODIGY/Multi-PROD/multiple.lisp")
(load "/usr/local/mcox/Research/PRODIGY/Multi-PROD/patches.lisp")
(load "/usr/local/mcox/Research/PRODIGY/Multi-PROD/socket-specific.lisp")


(setf *use-monitors-p* t)

(setf *active-p4p* nil)
(setf *muliple-PRODIGYs-on* t)

(setf *interactive-pause* nil)
(setf *pause* nil)

(defvar *change-state-on* t)

#|

(defvar *data2-file-name*
  "/tmp/data2.txt")


(defvar *ready3-file-name*
  "/tmp/ready3.txt")


(defvar *ready4-file-name*
  "/tmp/ready4.txt")

;;; The following defun need not be done in one-way communication. 
;;; Am I sure now that the fn has non-blocking option?
(defun fake-P4P (&optional
		 (sequence 
		  *p4p-sequence*)
		 non-blocking)
  (format t "~%Fake P4P WAITING~%")
  (do ((delta (first sequence) 
	      (first sequence)))
      ((or (null sequence)
	   (and non-blocking
		(not (probe-file
		      *ready4-file-name*))))
       nil)
    (ready *ready4-file-name*)		;Wait until PRODIGY is ready.
    (delete-file *ready4-file-name*)
    (pop sequence)			;cannot perform the pop in the var list
					;of the do funct because the last 
					;element of the list will not be used.
    (create-data-file
     (list delta)
     *data2-file-name*)
    (create-ready-file 
     *ready3-file-name*)
    )
  )
|#



(setf *world-path* "/usr/local/users/mcox/Research/PRODIGY/Wrapper/P4P/domains/")
(domain 'accepter)
(problem 'accepter)
(output-level 3)

;;; Now within do-session
;(reset)


(if (y-or-n-p "Run Session Now? ")
    (do-session t)
  )



