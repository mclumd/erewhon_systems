(defun diff (x y)
  (cond
    ((and (p4::prodigy-object-p x)
	  (p4::prodigy-object-p y))
     (not (eq x y)))
    ((p4::prodigy-object-p y)
     (not (eq (p4::prodigy-object-name y)
	      x)))
    ((p4::prodigy-object-p x)
     (not (eq (p4::prodigy-object-name x) 
	      y)))
    (t
     (not (eq (p4::prodigy-object-name x) 
	      (p4::prodigy-object-name y))))))





