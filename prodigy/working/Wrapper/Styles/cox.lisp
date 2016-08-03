(defun step-print (op stream) 
  (declare (type p4::instantiated-op op)
	   (stream stream))

(with-open-file 
	       (out stream
		    :direction :output
		    :if-exists :append
		    :if-does-not-exist :create
		    )
	       (format out "(")
	       (format out " ~S" (p4::operator-name (p4::instantiated-op-op op)))
	       (format out "~S"(map nil #'(lambda (x y)
		 (princ " (")
		 (princ x)
		 (princ " ")
		 (cond ((typep y 'p4::prodigy-object)
			(princ (p4::prodigy-object-name y)))
		       ((null y) (princ "()"))
		       ((listp y) (princ "(..)"))
		       (t (princ y)))
		 (princ ")"))
	 (p4::operator-vars (p4::instantiated-op-op op))
	 (p4::instantiated-op-values op)))
    (format out  ")~%")
    )
)

