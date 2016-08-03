(setf (current-problem)
      (create-problem
       (name p13)
       (objects
	(objects-are blockA blockB Object))
       (state
	(and (holding blockA)
	     (clear blockB)
	     (on-table blockB)))
       (igoal (clear blockA))))
