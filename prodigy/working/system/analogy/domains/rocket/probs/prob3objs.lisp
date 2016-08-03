
(setf (current-problem)
      (create-problem
       (name prob3objs)
       (objects
	(LocA LocB LOCATION)
	(hammer robot blancmange OBJECT)
	(Apollo ROCKET))
       (state
	(and (at Apollo LocA)
	     (at hammer LocA)
	     (at robot LocA)
	     (at blancmange LocA)))
       (igoal
	(and (at hammer LocB)
	     (at robot LocB)
	     (at blancmange locB)))))
  
