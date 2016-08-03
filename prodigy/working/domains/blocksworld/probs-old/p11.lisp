(setf (current-problem)
      (create-problem
       (name p11)
       (objects
	(objects-are blockA blockB Object))
       (state
	(and (holding blockA)
	     (clear blockB)
	     (on-table blockB)))
       (igoal (and (clear blockA) (on blockA blockB)))))





