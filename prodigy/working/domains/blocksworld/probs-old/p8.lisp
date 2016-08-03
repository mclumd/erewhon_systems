(setf (current-problem)
      (create-problem
       (name p8)
       (objects
	(objects-are A B C Object))
       (state
	(and (arm-empty)
	     (clear B)
	     (on-table A)
	     (on B C)
	     (on C A)))
       (igoal (holding C))))





