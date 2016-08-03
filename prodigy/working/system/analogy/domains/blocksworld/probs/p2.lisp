
(setf (current-problem)
      (create-problem
       (name p2)
       (objects
	(A B C object)
	)
       (state
	(and 
	     (on-table B)
	     (clear B)
	     (arm-empty)
	     (on-table C)
	     (clear C)))
       (igoal (holding b))))

