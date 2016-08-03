;;; Shifter
;;; 

;; create a problem-space named shifter
(create-problem-space 'shifter :current t)

;;declare object and slot 

(ptype-of OBJECT :top-type)
(ptype-of SLOT :top-type)

;;declare instances of object and slot
(pinstance-of <pack1> <pack2> <pack3> OBJECT)
(pinstance-of slot1 slot2 slot3 SLOT)

;;load operator puts the object onto the slot in the conveyor belt
(OPERATOR LOAD

  (params <ob> <st>)
  (preconds 
   ((<ob> OBJECT)
    (<st> SLOT))
   (and (conveyer-empty)
        (in-slot <ob> <st>)
        (at-slot <st>)
))
  (effects 
   () ; no vars need genenerated in effects list
   ((del (in-slot <ob> <st>))
    (del (conveyer-empty))
    (add (is-empty <st>))
    (add (on-conveyer <ob>)))))

;;unload operator removes the object from the slot on the conveyor
(OPERATOR UNLOAD
  (params <ob> <st>)
  (preconds 
   ((<ob> OBJECT)
    (<st> SLOT))
    (and

      (on-conveyer <ob>)
      (at-slot <st>)
      (is-empty <st>)))
  (effects 
   () ; no vars need genenerated in effects list
   (
    (add (conveyer-empty))
    (add (in-slot <ob> <st>))
    (del (on-conveyer <ob>))
    (del (is-empty <st>)))))

;;move-to operator moves the slot from one to the other
(OPERATOR MOVE-TO
  (params <st1> <st2>)
  (preconds 
   ((<st1> SLOT)
   (<st2> SLOT))
   (and (at-slot <st1>)))
  (effects
   () ; no vars need generated in effects list 
   ((del (at-slot <st1>))
    (add (at-slot <st2>)))))

