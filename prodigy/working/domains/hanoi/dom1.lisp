;;;
;;; This domain added for testing the abstraction stuff.

(create-problem-space 'hanoi :current t)

(ptype-of Peg  :top-type)
(ptype-of Disk :top-type)

(OPERATOR
 Move-disk
 (params <disk> <from> <to>)
 (preconds
  ((<disk> Disk)
   (<from> Peg)
   (<to> Peg))
  (and	; (not-equal <from> <to>)
   (on <disk> <from>)
   (forall ((<smaller.disk> Disk))
	   (or (~ (smaller <smaller.disk> <disk>))
	       (and (~ (on <smaller.disk> <from>))
		    (~ (on <smaller.disk> <to>)))))))
 (effects
  ()
  ((del (on <disk> <from>))
   (add (on <disk> <to>)))))

(defun not-equal (peg1 peg2)
  (not (eq peg1 peg2)))
