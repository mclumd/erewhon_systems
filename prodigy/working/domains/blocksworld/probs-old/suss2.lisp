;; This is the first test problem for PRODIGY4 for Sussman's anomalies

(setf (current-problem)
      (create-problem
       (name sussman)
       (objects
	(A B C D E object))
       (state
	(and (on-table A)
	     (on-table B)
	     (on C A)
	     (on-table D)
	     (clear C)
	     (on E D)
	     (clear B)
	     (clear E)
	     (arm-empty)))
       (goal
	(and (on A B)
	     (on B C)
	     (on-table E)))))

