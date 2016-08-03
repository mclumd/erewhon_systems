(setf (current-problem)
      (create-problem
       (name p24)
       (objects
	(objects-are A B C Object))
       (state
	(and (on-table C)
	     (on-table B)
	     (on A B)
	     (clear A)
	     (clear C)
	     (arm-empty)))
       (igoal (and (holding C) (clear B)))))
