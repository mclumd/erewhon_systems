(in-package :shop2)

(defdomain route-finding
					 ((:operator (!move ?t ?l1 ?l2)
											 ((at ?t ?l1) (adjacent ?l1 ?l2))
											 ((at ?t ?l1))
											 ((at ?t ?l2)))

						(:method (move-truck ?t ?l1 ?l2 ?attempted)
										 ((same ?l1 ?l2))
										 ())

						(:method (move-truck ?t ?l1 ?l2 ?attempted)
										 ((at ?t ?l1) (adjacent ?l3 ?l2) (eval (not (member '?l3  '?attempted))))
										 ((move-truck ?t ?l1 ?l3 (?l2 . ?attempted)) (!move ?t ?l3 ?l2)))

						(:method (move-truck ?t ?l1 ?l2 ?attempted)
										 ((at ?t ?l1) (adjacent ?l1 ?l2))
										 ((!move ?t ?l1 ?l2)))



						(:- (same ?x ?x) nil)
						(:- (different ?x ?y) ((not (same ?x ?y))))
						))


