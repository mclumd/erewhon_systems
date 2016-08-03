
(setf (current-problem)
      (create-problem
       (name b3)
       (objects
	(W1 W2 W3 W4 WINDOW)
	(A1 A2 A3 A4 AREA))
       (state
	(and (in W1 A1)
	     (in W2 A1)
	     (in W3 A2)
	     (in W4 A2)
	     (clear A3) (clear A4) (clear A1)
	     (active W4) 
	     (on-top W4) (on-top W2)
	     (on-top-of W4 W3) (on-top-of W2 W1)))	
       (goal (and (active W1) (active W2) (no-clogging)))))


