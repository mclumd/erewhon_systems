
(setf (current-problem)
      (create-problem
       (name b1)
       (objects
	(W1 W2 W3 W4 W5 WINDOW)
	(A1 A2 A3 A4 AREA))
       (state
	(and (in W1 A1)
	     (in W2 A1)
	     (in W3 A1)
	     (in W4 A1)
	     (in W5 A1)
	     (active W4)
	     (clear A4)  (clear A3)  (clear A2) 
	     (on-top W4)
	     (on-top-of W4 W3) (on-top-of W3 W2) (on-top-of W2 W1)
(on-top-of W1 W5)))	
       (goal (and (in W1 A1) (active W1) (active W2) (active W4)
		  (on-top-of W2 W3) (on-top-of W1 W5) (no-clogging)))))

