(setf (current-problem)
      (create-problem
       (name p19)
       (objects
	(objects-are blockA blockB blockC blockD blockE Object))
       (state
	(and (arm-empty)
	     (clear blockA)
	     (clear blockB)
	     (clear blockC)
	     (clear blockD)
	     (clear blockE)
	     (on-table blockA)
	     (on-table blockB)
	     (on-table blockC)
	     (on-table blockD)
	     (on-table blockE)))
       (igoal (on blockA blockB))))
