
(setf (current-problem)
      (create-problem
       (name p2)
       (objects
	(P D B object)
	(home office location))
       (state
	(and (at B home)
	     (at P home)
	     (nothing)
	     (at D home)
	     (in P)))
       (igoal
	(and (at P home) (~ (in P))))))



