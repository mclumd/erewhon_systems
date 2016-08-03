(setf (current-problem)
      (create-problem
       (name p21)
       (objects
	(objects-are A B C D Object))
       (state
	(and (on-table D)
	     (on C D)
	     (on B C)
	     (on A B)
	     (clear A)
	     (arm-empty)))
       (igoal (and (clear C) (on-table C) (holding D)))))
