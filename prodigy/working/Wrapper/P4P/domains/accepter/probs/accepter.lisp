;; This is the first test problem for Multi-PROD Problems

(setf (current-problem)
      (create-problem
       (name sussman)
       (objects
	(A B C D E F G object))
       (state
	(and (on-table A)
	     (on-table B)
	     (on C A)
	     (on G F)
	     (on-table D)
	     (on-table E)
	     (on-table F)
	     (clear B)
	     (clear C)
	     (clear D)
	     (clear E)
	     (clear G)
	     (a-arm-empty)))
       (goal
	(and (on F E)
;	     (on A B)
;	     (on B C)
	     ))))

