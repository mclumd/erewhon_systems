(setf (current-problem)
      (create-problem
       (name p10)
       (objects
	(objects-are blockA blockB Object))
       (state
	(and (arm-empty)
	     (clear blockA)
	     (clear blockB)
	     (on-table blockA)
	     (on-table blockB)))
       (igoal (on blockA blockB))))





