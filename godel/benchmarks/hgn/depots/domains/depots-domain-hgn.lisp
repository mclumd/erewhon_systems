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
            (:gdr (move-crate-to-right-place-easy ?c ?c1 ?l ?l1 ?t ?h1)
                  ((on ?c ?c1))
                  ((available ?h1) (clear ?c) (not (need-to-move ?c1)) (truck ?t) (at ?c ?l) (at ?c1 ?l1) (hoist ?h1) (at ?h1 ?l1))
                  (((in ?c ?t)) ((at ?t ?l1)) ((clear ?c1)) ((lifting ?h1 ?c))))

            ;; If there exists a crate placed currently in a truck and doesn't need to be moved from its
            ;; destination once placed there, apply this method
            (:gdr (move-crate-initially-in-truck ?c ?c1 ?t ?l1 ?h1)
                  ((on ?c ?c1))
                  ((available ?h1) (in ?c ?t) (not (need-to-move ?c1)) (at ?c1 ?l1) (hoist ?h1) (at ?h1 ?l1))
                  (((at ?t ?l1)) ((clear ?c1)) ((lifting ?h1 ?c))))

            ;; If there exists a crate that is not clear neither is in a truck but its movable to its final
            ;; destination, apply this method
            (:gdr (move-crate-to-right-place-harder ?c ?c1 ?t ?t1 ?l ?l1 ?h1)
                  ((on ?c ?c1))
                  ((not (clear ?c))
                   (truck ?t1) (not (in ?c ?t1))
                   (not (need-to-move ?c1))
                   (truck ?t)
                   (at ?c ?l)
                   (at ?c1 ?l1)
                   (available ?h1)
                   (hoist ?h1) (at ?h1 ?l1))
                  (((in ?c ?t)) ((at ?t ?l1)) ((clear ?c1)) ((lifting ?h1 ?c))))

            ;; To get the crate into the truck, apply this method
            (:gdr (load-crate-into-truck ?c ?t ?l ?h)
                  ((in ?c ?t))
                  ((truck ?t)
                   (at ?c ?l)
                   (hoist ?h)
                   (available ?h)
                   (at ?h ?l))
                  (((at ?t ?l)) ((clear ?c)) ((lifting ?h ?c))))

            ;; To make a crate clear if its initially not, apply this method
            ;; It uses a truck already present at the location to perform the lifts and loads
            (:gdr (clear-crate ?c ?c1 ?l ?t ?h)
                  ((clear ?c))
                  ((truck ?t) (at ?t ?l)
                   (at ?c ?l)
                   (at ?c1 ?l)
                   (on ?c1 ?c)
                   (available ?h)
                   (hoist ?h) (at ?h ?l))
                  (((clear ?c1)) ((lifting ?h ?c1)) ((in ?c1 ?t))))
            
            (:- (same ?x ?x) nil)
						(:- (different ?x ?y) ((not (same ?x ?y))))

						(:- (need-to-move ?x)
								;; need to move x if x is on y and x is supposed to be on z
                ((on ?x ?y) (goal (on ?x ?z)) (different ?y ?z))
                ;; need to move x if x is on y and y needs to be moved
;                ((pallet ?x) nil)
                ((on ?x ?y) (need-to-move ?y))
                )))
