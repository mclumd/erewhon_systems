(setf (current-problem)
      (create-problem
       (name p22)
       (objects
	(objects-are A B C D E F G Object))
       (state
	(and (clear B)
	     (on-table B)
	     (on-table G)
	     (on F G)
	     (on E F)
	     (on D E)
	     (on C D)
	     (clear C)
	     (holding A)))
       (igoal (and (on B C) (on-table A) (on F A) (on C D)))))
