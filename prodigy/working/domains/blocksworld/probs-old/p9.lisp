(setf (current-problem)
      (create-problem
       (name p9)
       (objects
	(objects-are A B C Object))
       (state
	(and (holding A)
	     (clear C)
	     (on C B)
	     (on-table B)))
       (igoal (clear B))))





