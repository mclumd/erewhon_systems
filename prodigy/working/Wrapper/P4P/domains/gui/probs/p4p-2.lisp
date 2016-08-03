
(setf (current-problem)
      (create-problem
       (name p4p2)
       (objects
	(emacs UIP Load Email View
	    WINDOW)
	(A1 A2 A3 A4 AREA))
       (state
	(and (in emacs A1) (in UIP A2) (in Load A3) (in Email A4) (in View A4) 
	     (active View) 
	     (on-top emacs) (on-top UIP) (on-top Load) (on-top View) (on-top-of View Email) 
	     ))	
       (goal (and 
	      (no-clutter)
	      ))))


