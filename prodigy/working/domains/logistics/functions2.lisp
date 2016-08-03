(defun get-airport-at-city (city)
  (declare (special *current-problem-space*))
  (let ((part-hash (gethash 'loc-at
			    (p4::problem-space-assertion-hash
			     *current-problem-space*)))
	(result nil))
    (if part-hash
     ;;; I should really be testing if (hash-table-p ..)
     ;;; but because of the implementation, I know this always hold
     ;;; provided that part-hash is not empty.
	(maphash #'(lambda (key val)
		     (if (and (p4::literal-state-p val)
			      (eq (elt key 1) city))
			 (setf result val)))
		 part-hash))
    (if result
	(elt (p4::literal-arguments result) 0)
	(error "~% get-airport-at-city: no entry for loc-at ~A in the state."
	       city))))