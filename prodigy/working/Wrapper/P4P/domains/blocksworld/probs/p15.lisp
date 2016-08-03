(setf (current-problem)
      (create-problem
       (name p15)
       (objects
	(objects-are A B C Object))
       (state
	(and (arm-empty)
	     (clear B)
	     (clear A)
	     (on-table A)
	     (on-table C)
	     (on B C)))
       (igoal (holding A))))
