;;; This is the rocket problem, using identical operators to nolimit's
;;; in order to make comparison easy.

(create-problem-space 'nolimit-rocket :current t)

(ptype-of OBJECT    :top-type)
(ptype-of LOCATION  :top-type)
(ptype-of ROCKET    :top-type)

(pinstance-of locA locB LOCATION)

(Operator
 Load-Rocket
 (params <object> <place> <rocket>)
 (preconds
  ((<object> OBJECT)
   (<place> LOCATION)
   (<rocket> ROCKET))
  (and (at <rocket> <place>)
       (at <object> <place>)))
 (effects
  ()
  ((del (at <object> <place>))
   (add (inside <object> <rocket>)))))

(Operator
 Unload-Rocket
 (params <object> <place> <rocket>)
 (preconds
  ((<object> OBJECT)
   (<place>  LOCATION)
   (<rocket> ROCKET))
  (and (inside <object> <rocket>)
       (at <rocket> <place>)))
 (effects
  ()
  ((del (inside <object> <rocket>))
   (add (at <object> <place>)))))

(Operator
 Move-Rocket
 (params <rocket>)
 (preconds
  ((<rocket> ROCKET))
  (at <rocket> locA))
 (effects
  ()
  ((del (at <rocket> locA))
   (add (at <rocket> locB)))))
