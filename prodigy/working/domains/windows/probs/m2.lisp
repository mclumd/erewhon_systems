
(setf (current-problem)
      (create-problem
       (name m2)
       (objects
	(W5 W4 W3 W2 W1
	    WINDOW)
	(A1 A2 A3 A4 AREA))
       (state
	(and (in W1 A1) (in W2 A1) (in W3 A1) (in W4 A1) 
	     (in W5 A1)
	     (active W4) 
;	     (active W3)
	     (clear A4)  (clear A3)  (clear A2) 
	     (on-top W4)
	     (on-top-of W1 W5)
	     (on-top-of W2 W1)
	     (on-top-of W3 W2) 
	     (on-top-of W4 W3) 
	     ))	
       (goal (and 
	      (clutterless A1)
	      (clutterless A2)
	      (clutterless A3)
	      (clutterless A4)
;	      (~ (clear A3))
;	      (~ (overlaps W3 W2))
	      ))))


