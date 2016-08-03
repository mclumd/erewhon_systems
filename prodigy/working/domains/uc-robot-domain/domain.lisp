;;; A translation of the UCPOP robot domain into prodigy 4.0
;;; syntax, for comparison. 
;;; Jim Blythe, 4/4/93

(create-problem-space 'uc-robot-domain :current t)

;;; Unlike the blocksworld, I decided to make the robot a separate
;;; type. This domain is different from the uc-blocksworld in that
;;; there are no conditional effects based on the object not being a
;;; robot. This is a personal choice, though, and I could just as
;;; easily have had a distinguished object called "robot" and just one
;;; object type.

(ptype-of Object :top-type)
(ptype-of Robot  :top-type)
(ptype-of Location :top-type)

(pinstance-of robot Robot)

(OPERATOR 
 pickup
 (params <x> <loc>)
 (preconds 
  ((<x> Object)
   (<loc> Location))
  (and (empty-handed) (at <x> <loc>) (at robot <loc>)))
 (effects
  ()
  ((add (grasping <X>))
   (del (empty-handed)))))

(operator
 drop
 (params <x>)
 (preconds
  ((<x> object))
  (and (grasping <x>)))
 (effects
  ()
  ((add (empty-handed))
   (del (grasping <x>)))))

(operator
 move
 (params <from> <to>)
 (preconds
  ((<from> Location)
   (<to>   (and Location (diff <from> <to>))))
  (and (at robot <from>) (connected <from> <to>)))
 (effects
  ((<carried> Object))
  ((add (at robot <to>))
   (del (at robot <from>))
   (if (grasping <carried>)
       ((add (at <carried> <to>))
	(del (at <carried> <from>)))))))







