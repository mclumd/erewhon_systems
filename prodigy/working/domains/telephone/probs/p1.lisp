;;; Just four nodes, totally connected, and two simple calls for
;;; debugging purposes.
;;;
;;;        1------2
;;;        |      |
;;;        |      |
;;;        3------4
;;; all links have cpacity 1. Call requested from 1 to 3 and from 2 to
;;; 4.

(setf (current-problem)
      (create-problem
       (name simple-sample)
       (objects
	(n1 n2 n3 n4 node)
	(c13 c24 call))
       (state
	(and (capacity n1 n2 1)
	     (capacity n1 n3 1)
	     (capacity n2 n4 1)
	     (capacity n4 n3 1)
	     (routed-to c13 n1)
	     (routed-to c24 n2)))
       (igoal
	(and (routed-to c13 n3)
	     (routed-to c24 n4))))
      )
