;;; This one forces the system to subgoal on an inference rule by
;;; making the goal - to be "at home" only added by an inference rule.

(setf (current-problem)
      (create-problem
       (name subway1)
       (objects
	(objects-are gateway-center steel-plaza station)
	(object-is mr_rogers person))
       (state (and (adjacent gateway-center wood-street)
		   (adjacent wood-street steel-plaza)
		   (at-p mr_rogers gateway-center)
		   (home-for mr_rogers steel-plaza)))
       (igoal
	(at-p mr_rogers home))))



