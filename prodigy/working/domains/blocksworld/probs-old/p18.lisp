(setf (current-problem)
      (create-problem
       (name p18)
       (objects
	(objects-are blockA blockB blockC Object))
       (state
	(and (arm-empty)
	     (clear blockB)
	     (clear blockA)
	     (on blockA blockC)
	     (on-table blockB)
	     (on-table blockC)))
       (igoal (on blockA blockB))))
