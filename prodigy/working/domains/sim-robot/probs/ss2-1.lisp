(setf (current-problem)
      (create-problem
       (name ss2-1)
       (objects
	(a b  BOX)
	(key12 KEY)
	(rm1 rm2 ROOM)
	(dr12 DOOR))
       (state
	(and (dr-to-rm dr12 rm2)
	     (dr-to-rm dr12 rm1)
	     (connects dr12 rm2 rm1)
	     (connects dr12 rm1 rm2)
	     (arm-empty)
	     (next-to b a)
	     (unlocked dr12)
	     (dr-closed dr12)
	     (pushable b)
	     (inroom b rm1)
	     (inroom a rm1)
	     (inroom key12 rm1)
	     (inroom robot rm1)
	     (carriable key12)
	     (is-key dr12 key12)))
       (igoal (and (locked dr12) (arm-empty)))))

#|
Solution:
	<goto-obj key12 rm1>
	<pickup-obj key12>
	<goto-dr dr12 rm1>
	<lock dr12 key12 rm1>
	<putdown key12>
|#
