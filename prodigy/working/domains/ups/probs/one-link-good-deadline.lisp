(setf (current-problem)
      (create-problem
       (name one-link-good-deadline)
       (objects
	(hub0 hub1 hub2 HUB)
	(pac0 OBJECT))
       (state 
	(and (link hub0 hub1 3)
	     (link hub1 hub2 4)
	     (effectively-at pac0 hub0 0)))
       (igoal (satisfy-deadline pac0 hub2 10))))
       

;; Simplest example - only one link, good deadline ok

