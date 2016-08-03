
(setf (current-problem)
      (create-problem
       (name p3)
       (objects
	(A B C object))
       (state
	(and (holding A)
	     (on-table B)
	     (clear B)
	     (on-table C)
	     (clear C)))
       (igoal (holding b))))

