
;;; This problem may not seem too interesting, but it allows me to
;;; test the abstraction stuff, since the abstract plan is definitely
;;; refineable. 
(setf (current-problem)
      (create-problem
       (name rocket1)
       (objects
	(LocA LocB LOCATION)
	(hammer OBJECT)
	(Apollo ROCKET))
       (state
	(and (at Apollo LocA)
	     (at hammer LocA)))
       (igoal
	(and (at hammer LocB)))))
  
