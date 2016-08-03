
(setf (current-problem)
      (create-problem
       (name prob1-hammer)
       (objects
	(LocA LocB LOCATION)
	(hammer OBJECT)
	(Apollo ROCKET))
       (state
	(and (at Apollo LocA)
	     (at hammer LocA)))
       (igoal
	(and (at hammer LocB)))))
  
