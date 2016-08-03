
(setf (current-problem)
      (create-problem
       (name p4)
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
	(and (at D office) (at B home)))))




