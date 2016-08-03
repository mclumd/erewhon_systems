
(setf (current-problem)
      (create-problem
       (name m2)
       (objects
	(S1 SCREEN)
	(W1 W2 W3 W4 
	    WINDOW)
	(A1 A2 A3 A4 AREA))
       (state
	(and (part-of A1 S1)(part-of A2 S1)(part-of A3 S1)(part-of A4 S1) 
	     (in W1 A1) (in W2 A1) (in W3 A1) (in W4 A3) 
	     (active W4) 
	     (clear A4) (clear A2) 
	     (on-top W3) (on-top W4)
	     (on-top-of W3 W2) (on-top-of W2 W1)
	     ))	
       (goal (and 
	      (clutterfree S1)
	      ))))


