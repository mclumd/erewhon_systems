;; This is the first test problem for PRODIGY4, its goal is to be
;; holding an object.

(setf (current-problem)
      (create-problem
       (name test1)
       (objects
	(blockA blockB object))
       (state
	(and (on-table blockA)
	     (clear blockA)
	     (on-table blockB)
	     (clear blockB)
	     (arm-empty)))
       (igoal (or (holding blockA)
		  (holding blockB)))))

