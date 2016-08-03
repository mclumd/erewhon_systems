;;; Manuela Veloso 10/93

;;; Mostly Jim's code: /afs/cs/user/jblythe/domains/art-0d/domain.lisp
;;; Changed so the test would use the examples in the cases file.
;;; and results are dumped into the results directory.

;;; Jim 9/93: code to make a random problem, given the number of goals
;;; required. It uses *number-a-ops* to determine how many goals can
;;; actually be represented.

;;; use eg (setf (current-problem) (random-problem 2)) and then (run).

;;; Assumes the files of cases is loaded and *examples* is the list of
;;; problems to run on.
;;; If cases have k goals then call (test k)

(defun test-cases (&optional (max-ops 30))
  (let ((*number-a-ops* max-ops)
	(start-time nil)
	(res nil))
    (n-domain 'art-md-ns)			; load domain
    (pset :depth-bound 1000)
    (output-level 0)
    (dolist (probs *examples*)
      (let ((batch nil))
	(dolist (prob probs)
	  (setf (current-problem)
		(eval
		 `(create-problem
		   (name random-generated-problem)
		   (objects nil)
		   (goal ,(if (= 1 (length (nth 1 prob)))
			      (nth 1 prob)
			      (cons 'and (nth 1 prob))))
		   (state ,(if (= 1 (length (car prob)))
			       (car prob)
			       (cons 'and (car prob)))))))
	  (gc)				; garbage collect before run
	  (setf start-time (get-internal-run-time))
	  (run)
	  (push (- (get-internal-run-time) start-time)
		batch))
	(store-in-results-file batch (length (nth 1 (car probs))))
	(print probs)
	(push batch res)))
    res))


(defun store-in-results-file (batch goal-number)
  (with-open-file (out
		   (format nil
			   "/usr/mmv/prodigy4.0/domains/art-md-ns/results/prod-~A"
			   goal-number)
		   :direction :output
		   :if-exists :rename-and-delete
		   :if-does-not-exist :create)
    (dolist (res batch)
      (format out "~S~%" res))))
