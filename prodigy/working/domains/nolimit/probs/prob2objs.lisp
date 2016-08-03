
(setf (current-problem)
      (create-problem
       (name rocket2)
       (objects
	(LocA LocB LOCATION)
	(hammer robot OBJECT)
	(Apollo ROCKET))
       (state
	(and (at Apollo LocA)
	     (at hammer LocA)
	     (at robot LocA)))
       (igoal
	(and (at hammer LocB)
	     (at robot LocB)))))
  
