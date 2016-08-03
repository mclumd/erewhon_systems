
(setf (current-problem)
      (create-problem
       (name p5)
       (objects
	(P D B object)
	(home office location))
       (state
	(and (at B home)
	     (at P home)
	     (nothing)
	     (at D home)
	     (in P)
	     (in D)))
       (igoal
	(and (at B office)))))




