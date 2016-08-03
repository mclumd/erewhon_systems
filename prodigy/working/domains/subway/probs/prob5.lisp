;;;
;;; This one uses bombs to try a few features out.
;;;

(setf (current-problem)
      (create-problem
       (name subway5)
       (objects
	(gateway-center steel-plaza station)
	(president agent person)
	(bomb1 neutron-bomb)
	(my-ming-vase Sensitive-Object))
       (state (and (adjacent gateway-center wood-street)
		   (adjacent wood-street steel-plaza)
		   (at-o my-ming-vase steel-plaza)
		   (at-p agent gateway-center)
		   (at-p president steel-plaza)
		   (at-o bomb1 wood-street)
		   (location-detonating bomb1 steel-plaza)))
       (igoal
	(destroyed president)
	;(at agent steel-plaza)
	;(at bomb1 steel-plaza)
	)))


