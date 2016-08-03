
(setf (current-problem)
      (create-problem
       (name prob1-robot)
       (objects
	(LocA LocB LOCATION)
	(robot OBJECT)
	(Apollo ROCKET))
       (state
	(and (at Apollo LocA)
	     (at robot LocA)))
       (igoal
	(and (at robot LocB)))))
  
