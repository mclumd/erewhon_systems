;; This is the first test problem for PRODIGY4, its goal is to be
;; holding an object.

(setf (current-problem)
      (create-problem
       (name jim2)
       (objects
	(object-is blockA object)
	(object-is blockB object))
       (state (and (on-table blockA)
		   (clear blockA)
		   (on-table blockB)
		   (clear blockB)
		   (arm-empty)))
       (igoal (on blockA blockB))))

