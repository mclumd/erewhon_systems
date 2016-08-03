(in-package :shop2)

(defdomain depots
           ((:operator (!drive ?x ?y ?z) 
                       ((truck ?x) (at ?x ?y) (place ?z))
                       ((at ?x ?y)) 
                       ((at ?x ?z)))

            (:operator (!lift ?x ?y ?z ?p)
                       ((at ?x ?p) (available ?x) (at ?y ?p) (on ?y ?z) (clear ?y))
                       ((at ?y ?p) (clear ?y) (available ?x) (on ?y ?z))
                       ((clear ?z) (lifting ?x ?y)))

            (:operator (!drop ?x ?y ?z ?p)
                       ((at ?x ?p) (at ?z ?p) (clear ?z) (lifting ?x ?y))
                       ((lifting ?x ?y) (clear ?z))
                       ((available ?x) (clear ?y) (at ?y ?p) (on ?y ?z)))

            (:operator (!load ?x ?y ?z ?p)
                       ((at ?x ?p) (at ?z ?p) (lifting ?x ?y))
                       ((lifting ?x ?y)) 
                       ((in ?y ?z) (available ?x)))

            (:operator (!unload ?x ?y ?z ?p)
                       ((at ?x ?p) (at ?z ?p) (available ?x) (in ?y ?z))
                       ((in ?y ?z) (available ?x))
                       ((lifting ?x ?y)))

            ;; If there exists a crate that is clear in its initial position and once moved to its final
            ;; destination need not be moved, apply this method
            (:gdr (move-crate-to-right-place ?c ?c1 ?l ?l1 ?t ?h1)
                  ((on ?c ?c1))
                  ((available ?h1) (not (need-to-move ?c1)) (truck ?t) (at ?c ?l) (at ?c1 ?l1) (hoist ?h1) (at ?h1 ?l1))
                  ;; (((in ?c ?t)) ((at ?t ?l1)) ((clear ?c1)) ((lifting ?h1 ?c))))
                  ;; (((clear ?c)) ((in ?c ?t)) ((clear ?c1)) ((lifting ?h1 ?c))))
                  (((clear ?c)) ((clear ?c1))))


            ;; To make a crate clear if its initially not, apply this method
            ;; It uses a truck already present at the location to perform the lifts and loads
            (:gdr (clear-crate ?c ?c1 ?l ?t ?h)
                  ((clear ?c))
                  ((truck ?t) ; (at ?t ?l)
                   (at ?c ?l)
                   (at ?c1 ?l)
                   (on ?c1 ?c)
                   (available ?h)
                   (hoist ?h) (at ?h ?l))
                  (((at ?t ?l)) ((clear ?c1)) ((in ?c1 ?t))))
            
            (:- (same ?x ?x) nil)
						(:- (different ?x ?y) ((not (same ?x ?y))))

						(:- (need-to-move ?x)
								;; need to move x if x is on y and x is supposed to be on z
                ((on ?x ?y) (goal (on ?x ?z)) (different ?y ?z))
                ;; need to move x if x is on y and y needs to be moved
;                ((pallet ?x) nil)
                ((on ?x ?y) (need-to-move ?y))
                )))
