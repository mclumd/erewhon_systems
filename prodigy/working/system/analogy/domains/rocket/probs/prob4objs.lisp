
(setf (current-problem)
      (create-problem
       (name prob4objs)
       (objects
	(LocA LocB LOCATION)
	(hammer robot blancmange book OBJECT)
	(Apollo ROCKET))
       (state
	(and (at Apollo LocA)
	     (at hammer LocA)
	     (at robot LocA)
	     (at book LocA)
	     (at blancmange LocA)))
       (igoal
	(and (at hammer LocB)
	     (at robot LocB)
	     (at book LocB)
	     (at blancmange locB)))))
  
