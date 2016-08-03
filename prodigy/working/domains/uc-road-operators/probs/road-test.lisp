(setf (current-problem)
      (create-problem
       (name road-test)
       (objects
	(jack mark Vehicle)
	(a d g Place))
       (state
	(and (at jack a) (at mark a)
	     (bridge a d) (bridge d a) (road d g) (road g d)))
       (goal
	(and (at jack g) (at mark g)))))


