(in-package :shop2)

(defdomain route-finding
	   ((:operator (!move ?t ?l1 ?l2)
		       ((at ?t ?l1) (adjacent ?l1 ?l2))
		       ((at ?t ?l1))
		       ((at ?t ?l2)))
	    

	    (:gdr (move-truck ?t ?l1 ?l2 ?l3)
						((at ?t ?l2))
						((at ?t ?l1) (adjacent ?l3 ?l2))
						(((at ?t ?l3))))


	    ;	   (:- (adjacent ?x ?y) ((adjacent ?y ?x)))
	    ))

;(def-operator-type '((!move (truck location location))))
