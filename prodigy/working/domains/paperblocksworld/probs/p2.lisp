
(setf (current-problem)
      (create-problem
       (name p2)
       (objects
	(A B C object))
       (state
	(and (holding A)
	     (clear B)
	     (on B C)
	     (on-table C)))
       (igoal (arm-empty))))

