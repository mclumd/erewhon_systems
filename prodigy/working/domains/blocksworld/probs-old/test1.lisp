;; This is the first test problem for PRODIGY4, its goal is to be
;; holding an object.

(setf (current-problem)
      (create-problem
       (name test1)
       (objects
	(object-is blockA object))
       (state
 (and (on-table blockA)
	      (clear blockA)
	      (arm-empty)))
       (igoal (holding blockA))))

