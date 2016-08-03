(setf (current-problem)
      (create-problem
       (name one-link-bad-deadline)
       (objects
	(hub0 hub1 hub2 HUB)
	(pac0 OBJECT))
       (state
	(and (link hub0 hub1 25)
	     (link hub1 hub2 4)
	     (effectively-at pac0 hub0 0)))
       (igoal (satisfy-deadline pac0 hub2 10))))
