
(setf (current-problem)
      (create-problem
       (name b2)
       (objects
	(W1 W2 WINDOW)
	(A1 A2 A3 A4 AREA))
	
       (state
	(and (in W1 A1)
	     (in W2 A2)
	     (clear A4) (clear A3) 
	     (active W1) (active W2)
	     (on-top W2) (on-top W1)
	     )) 
       (goal (and (active W2) (in W1 A2) (in W2 A1) (no-clogging)))))


