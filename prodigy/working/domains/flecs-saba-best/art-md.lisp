;;; Manuela Veloso 10/93

(defun init-art-md ()
  (reset-domain)
  (dotimes (i *number-a-ops*)
    (defstep :action (list (make-sym 'a (1+ i)))
      :precond `((,(make-sym 'i (1+ i))))
      :add `((,(make-sym 'g (1+ i))))
      :del (let ((all-dels nil))
	     (dotimes (j i)
	       (push (cons 'del `((,(make-sym 'I (1+ j))))) all-dels))
	     all-dels))))

(defun make-cases (file &optional (n *number-a-ops*))
  (with-open-file (out file :direction :output :if-does-not-exist :create)
    (let ((initial (listm 'i n))
	  (goalset (listm 'g n)))
      (format out "~%(setf *examples*~%  '(")
      (dotimes (goals n)
	(format out "~%    (")
	(dotimes (i *cases-per-cell*)
	  (format out "(~S~%      ~S)~%     "
		  (random-order initial)
		  (random-order goalset (1+ goals))))
	(format out "~%    )"))
      (format out "~%))~%"))))

    




