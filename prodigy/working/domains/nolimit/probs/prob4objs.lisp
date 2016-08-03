(setf (current-problem)
      (create-problem
       (name rocket4)
       (objects
	(LocA LocB LOCATION)
	(hammer robot blancmange aqualung OBJECT)
	(Apollo ROCKET))
       (state
	(and (at Apollo LocA)
	     (at hammer LocA)
	     (at robot LocA)
	     (at blancmange LocA)
	     (at aqualung LocA)))
       (igoal
	(and (at hammer LocB)
	     (at robot LocB)
	     (at blancmange locB)
	     (at aqualung locB)))))

  
