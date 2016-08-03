(setf (current-problem)
      (create-problem
       (name sussman)
       (objects
	(A B C Object))
       (state
	(and (on C A) (on A Table) (on B Table)
	     (clear C) (clear B) (clear Table)))
       (goal
	(and (on B C) (on A B)))))


