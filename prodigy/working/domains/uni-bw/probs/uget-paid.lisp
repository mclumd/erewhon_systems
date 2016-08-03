
(setf (current-problem)
      (create-problem
       (name uget-paid)
       (objects
	(P D B object)
	(home office location))
       (state
	(and (at B home)
	     (at P home)
	     (at D home)
	     (in P)))
       (igoal
	(and (at B office)
	     (at D office)
	     (at P home)))))

