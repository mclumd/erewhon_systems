(setf (current-problem)
      (create-problem
       (name p20)
       (objects
	(objects-are blockA blockB blockC blockD Object))
       (state
	(and (arm-empty)
	     (clear blockA)
	     (clear blockB)
	     (clear blockC)
	     (on-table blockA)
	     (on-table blockC)
	     (on blockB blockD)))
       (igoal (and (on blockA blockB) (on blockB blockC)))))
