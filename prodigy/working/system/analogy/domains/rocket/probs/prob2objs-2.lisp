
(setf (current-problem)
      (create-problem
       (name prob2objs-2)
       (objects
	(LocA LocB LOCATION)
	(obj1 obj2 OBJECT)
	(r1 ROCKET))
       (state
	(and (at r1 LocA)
	     (at obj1 LocA)
	     (at obj2 LocA)))
       (igoal
	(and (at obj1 LocB)
	     (at obj2 LocB)))))
  
