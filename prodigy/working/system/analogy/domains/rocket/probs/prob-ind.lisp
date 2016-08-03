
(setf (current-problem)
      (create-problem
       (name prob-ind)
       (objects
	(LocA LocB LOCATION)
	(hammer robot OBJECT)
	(r1 r2 ROCKET))
       (state
	(and (at r1 LocA)
	     (at r2 LocA)
	     (at hammer LocA)
	     (at robot LocA)))
       (igoal
	(and (at hammer LocB)
	     (at robot LocB)))))
  
