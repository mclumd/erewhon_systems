
(setf (current-problem)
      (create-problem
       (name prob1-blancmange)
       (objects
	(LocA LocB LOCATION)
	(blancmange OBJECT)
	(Apollo ROCKET))
       (state
	(and (at Apollo LocA)
	     (at blancmange LocA)))
       (igoal
	(and (at blancmange LocB)))))
  
