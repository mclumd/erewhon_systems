;; This is the first test problem for PRODIGY4, its goal is to be
;; holding an object.

(setf (current-problem)
      (create-problem
       (name jim1)
       (objects
	(object-is blockA object)
	(object-is blockB object))
       (state
	(and (on-table blockA)
	     (clear blockA)
	     (arm-empty)))
       (igoal (holding blockA))))

