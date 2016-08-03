;; This is the first test problem for PRODIGY4, its goal is to be
;; holding an object.

(setf (current-problem)
      (create-problem
       (name half-sussman)
       (objects
	(blockA blockB blockC object))
       (state
	(and (on-table blockA)
	     (on-table blockB)
	     (on-table blockC)
	     (clear blockA)
	     (clear blockB)
	     (clear blockC)
	     (arm-empty)))

       (igoal
	(and (on blocka blockb)
	     (on blockb blockc)))))
	
