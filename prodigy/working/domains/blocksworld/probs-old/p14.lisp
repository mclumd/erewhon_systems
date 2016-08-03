(setf (current-problem)
      (create-problem
       (name p14)
       (objects
	(objects-are blockA blockB blockC Object))
       (state
	(and (holding blockA)
	     (clear blockB)
	     (clear blockC)
	     (on-table blockB)
	     (on-table blockC)))
       (igoal (and (on blockA blockB) (holding blockC)))))
