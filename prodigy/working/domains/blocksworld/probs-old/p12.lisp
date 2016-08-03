(setf (current-problem)
      (create-problem
       (name p12)
       (objects
	(objects-are blockA blockB Object))
       (state
	(and (holding blockA)
	     (clear blockB)
	     (on-table blockB)))
       (igoal (on-table blockA))))
