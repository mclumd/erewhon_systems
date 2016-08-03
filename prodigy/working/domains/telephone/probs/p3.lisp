;;; 
;;; This example has more than one possible plan, so I can test the
;;; multiple-sols facility, and find out how long between different
;;; plans.
;;;
;;;    n1 --2-- n2 --2-- n3
;;;    |        |        |
;;;    4        4        X  (this line just went down)
;;;    |        |        |
;;;    n4 --2-- n5 --2-- n6
;;; 
;;;
;;; There were two going down each vertical line, but the line from n3
;;; to n6 just went down. There are a number of recovery plans for
;;; this. The shortest plan just sticks the old load from n3 to n6
;;; down n2-n5 or n1-n4, but this is not the best plan because the
;;; load is unbalanced. On the other hand, the shortest plan leases
;;; the smallest amount of physical links, so there is a conection
;;; between plan length and goodness. I have to think about that some
;;; more.

(setf (current-problem)
      (create-problem
       (name balance-load)
       (objects
	(n1 n2 n3 n4 n5 n6 node)
	(c14a c14b c25a c25b c36a c36b call))
       (state
	(and (capacity n1 n2 2)
	     (capacity n1 n4 4)
	     (capacity n2 n3 2)
	     (capacity n2 n5 4)
	     (capacity n4 n5 2)
             (capacity n5 n6 2)
	     (routed-to c14a n1)
	     (routed-to c14b n1)
	     (routed-to c25a n2)
	     (routed-to c25b n2)
	     (routed-to c36a n3)
	     (routed-to c36b n3)))
       (igoal
	(and
	 (routed-to c14a n4)
	 (routed-to c14b n4)
	 (routed-to c25a n5)
	 (routed-to c25b n5)
	 (routed-to c36a n6)
	 (routed-to c36b n6)))))))
