(setf (current-problem)
      (create-problem
       (name ss2-2)
       (objects
	(a b c BOX)
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
	     (unlocked dr12)
	     (dr-open dr12)
	     (pushable a)
	     (inroom c rm2)
	     (inroom b rm1)
	     (inroom a rm2)
	     (inroom key12 rm1)
	     (inroom robot rm1)
	     (carriable key12)
	     (arm-empty)
	     (is-key dr12 key12)))
       (igoal (and (dr-closed dr12) (inroom robot rm2)))))

#|
Solution:
	<goto-dr dr12 rm1>
	<go-thru-dr dr12 rm1 rm2>
	<close-door dr12>
|#
