(in-package :shop2)

(defun generate-problems (num-nodes-in-city fraction num-problems)
	(with-open-file (prob-file (concatenate 'string 
																					"hgn-one-city-" 
																					(write-to-string num-nodes-in-city)
																					".lisp")
														 :direction :output
														 :if-exists :supersede
														 :if-does-not-exist :create)
		(with-open-file (prob-file2 (concatenate 'string 
																						 "htn-one-city-" 
																						 (write-to-string num-nodes-in-city)
																						 ".lisp")
																:direction :output
																:if-exists :supersede
																:if-does-not-exist :create)
			(dotimes (num-prob num-problems nil)
				(multiple-value-bind (state goal task) (generate-problem num-nodes-in-city fraction)
					(format prob-file "(in-package :shop2)~%")
					(format prob-file2 "(in-package :shop2)~%")
					(format prob-file "(defproblem OC-~A-~A route-finding~%" num-nodes-in-city num-prob)
					(format prob-file2 "(defproblem OC-~A-~A route-finding~%" num-nodes-in-city num-prob)
					(format prob-file "~T~A~%" state)
					(format prob-file2 "~T~A~%" state)
					(format prob-file "~T;; --- state~%")
					(format prob-file2 "~T;; --- state~%")
					(format prob-file "~T~A)~%~%~%" goal)
					(format prob-file2 "~T~A)~%~%~%" task))))))

(defun generate-problem (num-nodes-in-city fraction)
	(let* ((city (make-array (list num-nodes-in-city num-nodes-in-city)
														:initial-element 1))
;				 (city2 (make-array (list num-nodes-in-city num-nodes-in-city)
;														:initial-element 1))
;				 (city3 (make-array (list num-nodes-in-city num-nodes-in-city)
;														:initial-element 1))
				 (city-array (make-array 1 :initial-contents (list city)))
				 (max-edges (* num-nodes-in-city (- num-nodes-in-city 1)))
				 (num-edges-to-delete (floor (* fraction (/ max-edges 2))))
				 (initial-state nil)
				 (goal nil)
				 (task nil))
		(delete-edges city num-edges-to-delete)
;		(delete-edges city2 num-edges-to-delete)
;		(delete-edges city3 num-edges-to-delete)
		(setf edge-count 0)
		(dotimes (city-count 1 nil)
			(dotimes (i num-nodes-in-city nil)
				(setf initial-state (cons (generate-location-clause (+ (* city-count num-nodes-in-city) i))
																	initial-state))
				(dotimes (j num-nodes-in-city nil)
					(if (= (aref (aref city-array city-count) i j) 1)
						(progn
						(setf initial-state (cons (generate-adjacent-clause (+ (* city-count num-nodes-in-city) i)
																																(+ (* city-count num-nodes-in-city) j))
																			initial-state))
						(setf edge-count (+ 1 edge-count)))))))

;		(format t "edge-count is ~A ~%" edge-count)

		(let* (;(start-city (random 2))
					 (start-loc (random num-nodes-in-city))
					 (goal-loc (random num-nodes-in-city)))
			(setf initial-state (cons (generate-at-clause 1 start-loc) initial-state))
;			(setf initial-state (cons (generate-adjacent-clause connection-city0
;																													connection-city2-1) initial-state))
;			(setf initial-state (cons (generate-adjacent-clause connection-city1
;																													connection-city2-2) initial-state))
;			(setf initial-state (cons (generate-adjacent-clause connection-city2-1
;																													connection-city0) initial-state))
;			(setf initial-state (cons (generate-adjacent-clause connection-city2-2
;																													connection-city1) initial-state))
			(setf initial-state (cons (read-from-string "(truck t1)") initial-state))

			(setf goal (cons (generate-at-clause 1 goal-loc) goal))
			(setf task (cons (read-from-string (concatenate 'string 
																										 "(move-truck t1 loc"
																										 (write-to-string start-loc)
																										 " loc"
																										 (write-to-string goal-loc)
																										 " nil)")) task))

			(values initial-state goal task))))

(defun generate-at-clause (r n)
	(read-from-string (concatenate 'string 
																 "(at t" 
																 (write-to-string r)
																 " loc"
																 (write-to-string n)
																 ")")))

(defun generate-location-clause (n)
	(read-from-string (concatenate 'string 
																 "(location loc" 
																 (write-to-string n)
																 ")")))

(defun generate-adjacent-clause (m n)
	(read-from-string (concatenate 'string 
																 "(adjacent loc" 
																 (write-to-string m)
																 " loc"
																 (write-to-string n)
																 ")")))

(defun row-of-array (a row-index)
	(let ((len (array-dimension a 0))
				(row nil))
		(dotimes (i len nil)
			(setf row (cons (aref a row-index i) row)))
		(reverse row)))


(defun delete-edges (city delete-num)
	(let ((count 0)
				(v (array-dimension city 0)))
		(dotimes (x v nil)
			(setf (aref city x x) 0))
		(loop
			(when (= count delete-num) (return))
			(let* ((i (random v))
						 (j (random v))
						 (ith-row (row-of-array city i))
						 (jth-row (row-of-array city j)))
				(setf (nth j ith-row) 0)
				(setf (nth i jth-row) 0)
;				(format t "i : ~A, j : ~A ~%" i j)
				(if (and (not (= i j))
								 (= (aref city i j) 1)
								 (some (lambda (x) (not (= x 0))) ith-row)
								 (some (lambda (x) (not (= x 0))) jth-row)
								 (or jth-row))
					(progn
						(setf (aref city i j) 0)
						(setf (aref city j i) 0)
						(setf count (+ 1 count))))))
		city))


