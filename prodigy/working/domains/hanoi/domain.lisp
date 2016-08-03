;;;
;;; This domain added for testing the abstraction stuff.

(create-problem-space 'hanoi :current t)

(ptype-of Peg  :top-type)
(ptype-of Disk :top-type)
(ptype-of Disk1 Disk)
(ptype-of Disk2 Disk)
(ptype-of Disk3 Disk)

(pinstance-of disk1 Disk1)
(pinstance-of disk2 Disk2)
(pinstance-of disk3 Disk3)

(OPERATOR
 Move-disk1
 (params <from> <to>)
 (preconds
  ((<from> Peg)
   (<to> Peg))
  (and (on disk1 <from>)))
 (effects
  ()
  ((del (on disk1 <from>))
   (add (on disk1 <to>)))))

(OPERATOR
 Move-disk2
 (params <from> <to>)
 (preconds
  ((<from> Peg)
   (<to> Peg))
  (and (on disk2 <from>)
       (~ (on disk1 <from>))
       (~ (on disk1 <to>))))
 (effects
  ()
  ((del (on disk2 <from>))
   (add (on disk2 <to>)))))

(OPERATOR
 Move-disk3
 (params <from> <to>)
 (preconds
  ((<from> Peg)
   (<to> Peg))
  (and (on disk3 <from>)
       (~ (on disk1 <from>))
       (~ (on disk2 <from>))
       (~ (on disk1 <to>))
       (~ (on disk2 <to>))))
 (effects
  ()
  ((del (on disk3 <from>))
   (add (on disk3 <to>)))))


#|
(control-rule not-same-peg
	      (IF (current-ops (move-disk1 move-disk2 move-disk3)))
	      (THEN reject bindings
		    ((<from> . <x>) (<to> . <x>))))
|#


