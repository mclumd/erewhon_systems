(setf (current-problem)
      (create-problem
       (name one-rout-exact)
       (objects
	(hub0 hub1 hub2 HUB)
	(pac0 OBJECT))
       (state
	(and (link hub0 hub1 4)
	     (link hub1 hub2 6)
	     (effectively-at pac0 hub0 0)))
       
       (igoal (satisfy-deadline pac0 hub2 10))))

