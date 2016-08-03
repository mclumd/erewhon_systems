;; This is a simple test for the subway domain. The goal to have a
;; ticket must appear at least twice to move the necessary two stations.

;; Once I remember the station names, this problem file will allow you to
;; traverse the entire Pittsburgh subway system!!

(setf (current-problem)
      (create-problem
       (name subway1)
       (objects
	(gateway-center steel-plaza station)
	(jim ronald_mcdonald person))
       (state (and (adjacent gateway-center wood-street)
		   (adjacent wood-street steel-plaza)
		   (at-p ronald_mcdonald wood-street)
		   (at-p jim gateway-center)))
       (goal ((<person> Person))
	     (at-p <person> Steel-Plaza))
       ))

;;
;;       (igoal
;;	(at <person> steel-plaza))))
;;
