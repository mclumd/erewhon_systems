(setf (current-problem)
      (create-problem
       (name tower-invert)
       (objects
	(A B C Object))
       (state
	(and (on A B) (on B C) (on C Table)
	     (clear A) (clear Table)))
       (goal
	(and (on B C) (on C A)))))



