(setf (current-problem)
      (create-problem
       (name p7)
       (objects
	(objects-are A B Object))
       (state
	(and (arm-empty)
	     (clear B)
	     (on-table A)
	     (on B A)))
       (igoal (holding A))))





