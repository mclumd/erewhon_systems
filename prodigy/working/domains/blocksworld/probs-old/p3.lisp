
(setf (current-problem)
      (create-problem
       (name p3)
       (objects
	(blockA blockB object))
       (state
	(and (clear blockA)
	     (clear blockB)
	     (on-table blockA)
	     (on-table blockB)
	     (arm-empty)))
       (igoal (on blockA blockB))))

