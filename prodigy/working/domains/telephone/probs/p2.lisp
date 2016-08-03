;;; Just four nodes, totally connected, and two simple calls for
;;; debugging purposes.
;;;
;;;        1------2
;;;        |      |
;;;        |      |
;;;        3------4
;;;
;;; Just like p1, except that we want both calls routed from 1 to 3.
;;; Since all links have capacity 1, one call will have to take the
;;; path 1243.

(setf (current-problem)
      (create-problem
       (name simple-sample)
       (objects
	(n1 n2 n3 n4 node)
	(c1 c2 call))
       (state
	(and (capacity n1 n2 1)
	     (capacity n1 n3 1)
	     (capacity n2 n4 1)
	     (capacity n4 n3 1)
	     (routed-to c1 n1)
	     (routed-to c2 n1)))
       (igoal
	(and (routed-to c1 n3)
	     (routed-to c2 n3))))
      )
