(setf (current-problem)
      (create-problem
       (name sussman)
       (objects
	(A B C Block))
       (state
	(and (is-table Table) (on C A) (on B Table) (on A Table)))
       (goal
	(and (on B C) (on A B)))))


