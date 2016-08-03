(setf (current-problem)
      (create-problem
       (name p5)
       (objects
	(objects-are blockA blockB blockC blockD Object))
       (state
	(and
	 (arm-empty)
	 (clear blockA)
	 (clear blockB)
	 (clear blockD)
	 (on-table blockA)
	 (on-table blockC)
	 (on blockD blockC)
	 (on-table blockB)))
       (igoal (and (on blockA blockB)
		   (on blockB blockC)))))





