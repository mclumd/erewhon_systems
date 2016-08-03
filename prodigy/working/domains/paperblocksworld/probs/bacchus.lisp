(setf (current-problem)
      (create-problem
       (name bacchus)
       (objects
	(A B C object))
       (state
	(and (on-table A)
	     (on C A)
	     (on B C)
	     (clear B)
	     (arm-empty)))
       (goal
	(and (on C B)
	     (on B A)))))





