
(setf (current-problem)
      (create-problem
       (name p4)
       (objects
	(blockA object))
       (state
	(and (clear blockA)
	     (on-table blockA)
	     (arm-empty)))
       (igoal (on blockA blockA))))

