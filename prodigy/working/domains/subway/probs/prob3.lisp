;;; This is just like problem 1, except that we must make use of the
;;; inference rule that makes adjacency reflexive, because we want to
;;; get back again.

(setf (current-problem)
      (create-problem
       (name subway1)
       (objects
	(gateway-center steel-plaza station)
	(mei person))
       (state (and (adjacent gateway-center wood-street)
		   (adjacent wood-street steel-plaza)
		   (at-p mei steel-plaza)))
       (igoal
	(at-p mei gateway-center))))

