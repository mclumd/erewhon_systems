(setf (current-problem)
      (create-problem
       (name p23)
       (objects
	(objects-are A B C Object))
       (state
	(and (on-table C)
	     (on-table B)
	     (on-table A)
	     (clear A)
	     (clear B)
	     (clear C)
	     (arm-empty)))
       (igoal (and (holding C) (on A B)))))
