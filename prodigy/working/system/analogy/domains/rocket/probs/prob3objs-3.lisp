
(setf (current-problem)
      (create-problem
       (name prob3objs-3)
       (objects
	(LocA LocB LOCATION)
	(obj1 obj2 obj3 OBJECT)
	(r1 ROCKET))
       (state
	(and (at r1 LocA)
	     (at obj1 LocA)
	     (at obj2 LocA)
	     (at obj3 LocA)))
       (igoal
	(and (at obj1 LocB)
	     (at obj2 LocB)
	     (at obj3 locB)))))
  
