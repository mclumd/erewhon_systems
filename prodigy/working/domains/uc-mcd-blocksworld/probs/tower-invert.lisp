(setf (current-problem)
      (create-problem
       (name tower-invert)
       (objects
	(A B C D E Block))
       (state
	(and (is-table Table) (clear A) (on A B) (on B C) (on C D)
	     (on D E) (on E Table) (clear Table)))
       (goal
	(and (on B C) (on C D) (on D E) (on E A)))))



