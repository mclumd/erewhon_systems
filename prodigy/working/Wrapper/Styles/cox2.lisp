;;; Load this file by calling 
;;; (load "/usr/local/mcox/prodigy/working/cox2.lisp")


;;; Path to output file.
(defvar 
    *Normalized-plan-file* 
    "/usr/local/mcox/prodigy/working/cox4.dat"
  "Path to output file." )


;;;
;;; Third: this is example of writing to file in different form that you want.
;;; MOre later, but you may have to deal with transforming this into what you 
;;; want then into kqml or whatever. Will explain....
;;;
;;;
(defun step-print (op stream) 
  (declare (type p4::instantiated-op op)
	   (stream stream))

(with-open-file 
	       (out stream
		    :direction :output
		    :if-exists :append
		    :if-does-not-exist :create
		    )
	       (format out "~S~%" 
	         (cons (p4::operator-name (p4::instantiated-op-op op))
		       (mapcar #'(lambda (x y)
				    (list  x (cond ((typep y 'p4::prodigy-object)
						   (p4::prodigy-object-name y))
						  ((null y) nil)
						  ((listp y) '( et cetera))
						  (t  y))
					  ))
			    (p4::operator-vars (p4::instantiated-op-op (first (prodigy-result-solution *prodigy-result*))))
			    (p4::instantiated-op-values (first (prodigy-result-solution *prodigy-result*)))))
    ))
)


(defun save-normalized-plan ()
  (let* ((current-plan (prodigy-result-solution *prodigy-result*))
	 (plan-length (length current-plan)))
    (mapcar #'step-print 
	    current-plan 
	    (make-list 
	     plan-length 
	     :initial-element 
	     *Normalized-plan-file*))))

;;;
;;; First ask user for permission, then load prodigy.  Subsequently load domain
;;; and problem, then run PRODIGY.  Save the resultant plan to disk in
;;; normalized frame format.
;;;
(defun ask-user-for-demo ()
  (format t "~%Run prob1 in rocket domain and save to ~S ? " *Normalized-plan-file* )
  (when (y-or-n-p)
    (domain 'rocket)
    (problem 'prob1)
    (run)
    (save-normalized-plan))
  )

(ask-user-for-demo)



;;;(mapcar #'step-print current-plan 
;;;	'("/usr/local/mcox/prodigy/working/cox.dat" 
;;;	  "/usr/local/mcox/prodigy/working/cox.dat" 
;;;	  "/usr/local/mcox/prodigy/working/cox.dat" 
;;;	  "/usr/local/mcox/prodigy/working/cox.dat" 
;;;	  "/usr/local/mcox/prodigy/working/cox.dat" )
;;;	)



;;;(format t "~%Use standard normalized plan output file ~S~% ?"*Normalized-plan-file* )