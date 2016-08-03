(setf (current-problem)
      (create-problem
       (name two-routes-ok)
       (objects
	(hub0 hub1 hub2 hub3 HUB)
	(pac0 OBJECT))
       (state
	(and (link hub0 hub1 3)
	     (link hub1 hub3 4)
	     (link hub0 hub2 3)
	     (link hub2 hub3 5)
	     (effectively-at pac0 hub0 0)))
       (igoal (satisfy-deadline pac0 hub3 10))))