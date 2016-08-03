(setf (current-problem)
      (create-problem
       (name p16)
       (objects
	(objects-are blockA blockB blockC Object))
       (state
	(and (arm-empty)
	     (clear blockB)
	     (clear blockA)
	     (clear blockC)
	     (on-table blockA)
	     (on-table blockB)
	     (on-table blockC)))
       (igoal (and (on blockA blockB) (on blockB blockC)))))
