(defparameter *current-node-count* 0)

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

(defun generate-subtree (level bf radius)
	(if (= level radius)
		(progn
			(setf *current-node-count* (+ *current-node-count* 1))
			(cons (generate-location-clause (- *current-node-count* 1))
						nil))
		(let* ((root *current-node-count*)
					 (state1 (list (generate-location-clause root))))
			(setf *current-node-count* (+ 1 *current-node-count*))
			(dotimes (i bf nil)
				(setf state1 (cons (generate-adjacent-clause *current-node-count* root) state1))
				(setf state1 (cons (generate-adjacent-clause  root *current-node-count*) state1))
				(setf state1 (append (generate-subtree (+ level 1) bf radius) state1)))
;				(format t "state1 is ~A ~%" state1))
			state1)))

(defun generate-problem (bf radius num-problems)
	(with-open-file (prob-file (concatenate 'string 
																					"hgn-route-finding-" 
																					(write-to-string bf) 
																					"-"
																					(write-to-string radius)
																					".lisp")
														 :direction :output
														 :if-exists :supersede
														 :if-does-not-exist :create)
		(with-open-file (prob-file2 (concatenate 'string 
																						 "htn-route-finding-" 
																						 (write-to-string bf) 
																						 "-"
																						 (write-to-string radius)
																						 ".lisp")
																:direction :output
																:if-exists :supersede
																:if-does-not-exist :create)
			(setf *current-node-count* 0)
			(let ((state (generate-subtree 0 bf radius))
						(num-nodes (/ (- (expt bf (+ radius 1)) 1) (- bf 1))))
				(format prob-file "(in-package :shop2)~%")
				(format prob-file2 "(in-package :shop2)~%")
				(format t "~A ~A ~%" num-nodes *current-node-count*)

				(dotimes (n num-problems nil)
					(let* ((init-loc (random num-nodes))
								 (final-loc (random num-nodes))
								 (init-loc-pred (read-from-string (concatenate 'string 
																															 "(at t1 loc" 
																															 (write-to-string init-loc)
																															 ")")))
								 (final-loc-pred (read-from-string (concatenate 'string 
																																"(at t1 loc" 
																																(write-to-string final-loc)
																																")")))
								 (final-loc-task (read-from-string (concatenate 'string
																																 "(move-truck t1 loc"
																																 (write-to-string init-loc)
																																 " "
																																 "loc"
																																 (write-to-string final-loc)
																																 " nil)")))
								 (truck-pred '(truck t1)))
						(format prob-file "(defproblem RF-~A-~A-~A route-finding~%" bf radius n)
						(format prob-file2 "(defproblem RF-~A-~A-~A route-finding~%" bf radius n)
						(format prob-file "~T~A~%" (cons truck-pred (cons init-loc-pred state)))
						(format prob-file2 "~T~A~%" (cons truck-pred (cons init-loc-pred state)))
						(format prob-file "~T;; --- state~%")
						(format prob-file2 "~T;; --- state~%")
						(format prob-file "~T(~A))~%~%~%" final-loc-pred)
						(format prob-file2 "~T(~A))~%~%~%" final-loc-task)))))))






