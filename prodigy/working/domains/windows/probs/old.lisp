
(setf (current-problem)
      (create-problem
       (name m1)
       (objects
	(S1 SCREEN)			;NEW
	(W1 W2 W3 W4 
	    WINDOW)
	(A1 A2 A3 A4 AREA))
       (state
	(and (part-of A1 S1)(part-of A2 S1)(part-of A3 S1)(part-of A4 S1) ;NEW
	     (in W1 A1) (in W2 A1) (in W3 A1) (in W4 A1) 
	     (active W4) 
	     (clear A4) (clear A3) (clear A2) 
	     (on-top W4)
	     (on-bottom W1)
	     (on-top-of W4 W3) (on-top-of W3 W2) (on-top-of W2 W1)
	     (burried W3)(burried W2)(burried W1)
	     ))	
       (goal (and 
	      (clutterless A1)
	      (clutterless A2)
	      (clutterless A3)
	      (clutterless A4)
;	       (clutterfree S1)
	      ))))


