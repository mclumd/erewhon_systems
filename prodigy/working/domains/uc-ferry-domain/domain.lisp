;;Created: Alicia Perez.          Date: nov 16 1992
;;This looks very much like the rocket domain, but only one object
;;(auto) can be in the carrier (ferry) at a time.

(create-problem-space 'uc-ferry-domain :current t)

(ptype-of Auto :top-type)
(ptype-of Place :top-type)
(ptype-of Ferry-type :top-type)

(pinstance-of Ferry Ferry-type)

(operator BOARD
  (params <x> <y>)
  (preconds
   ((<x> auto)
    (<y> place))
   (and (at <x> <y>)
	(at-ferry <y>)
	(empty-ferry)))
  (effects
   ()
   ((add (on <x> ferry))
    (del (at <x> <y>))
    (del (empty-ferry)))))

(operator SAIL
  (params <x> <y>)
  (preconds
   ((<x> place)
    (<y> (and place (diff <x> <y>))))
   (at-ferry <x>))
  (effects
   ()
   ((add (at-ferry <y>))
    (del (at-ferry <x>)))))

(operator DEBARK
  (params <x> <y>)
  (preconds
   ((<x> auto)
    (<y> place))
   (and (on <x> Ferry)
	(at-ferry <y>)))
  (effects
   ()
   ((del (on <x> ferry))
    (add (at <x> <y>))
    (add (empty-ferry)))))


(setf (getf (p4::problem-space-plist *current-problem-space*)
	    :depth-bound) 100)
