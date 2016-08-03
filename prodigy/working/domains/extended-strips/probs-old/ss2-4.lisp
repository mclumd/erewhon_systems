(setf (current-problem)
      (create-problem
       (name ss2-4)
       (objects
	(a b BOX)
	(key12 KEY)
	(rm1 rm2 ROOM)
	(dr12 DOOR))
       (state
	(and (dr-to-rm dr12 rm2)
	     (dr-to-rm dr12 rm1)
	     (connects dr12 rm2 rm1)
	     (connects dr12 rm1 rm2)
	     (connects dr12 rm1 rm2)
	     (connects dr12 rm2 rm1)
	     (arm-empty)
	     (unlocked dr12)
	     (dr-open dr12)
	     (pushable a)
	     (inroom b rm2)
	     (inroom a rm1)
	     (inroom key12 rm2)
	     (inroom robot rm1)
	     (carriable key12)
	     (is-key dr12 key12)))
       (igoal (and (inroom key12 rm1) (dr-closed dr12)))))

#|
solution:
	<goto-dr dr12 rm1>
	<go-thru-dr dr12 rm1 rm2>
	<goto-obj key12 rm2>
	<pickup-obj key12>
	<goto-dr dr12 rm2>
	<carry-thru-dr key12 dr12 rm1 rm2>
	<close-door dr12>
|#
