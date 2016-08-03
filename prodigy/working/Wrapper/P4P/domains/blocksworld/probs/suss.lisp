;; This is the first test problem for PRODIGY4, its goal is to be
;; holding an object.

(setf (current-problem)
      (create-problem
       (name sussman)
       (objects
	(blockA  blockb blockC object))
       (state
	(and (on-table blockA)
	     (on-table blockB)
	     (on blockC blockA)
	     (clear blockB)
	     (clear blockC)
	     (arm-empty)))
       (goal
	(and (on blockA blockB)
	     (on blockB blockC)))))




