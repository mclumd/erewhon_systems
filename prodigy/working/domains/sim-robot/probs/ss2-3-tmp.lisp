(setf (current-problem)
      (create-problem
       (name ss2-3)
       (objects
	( c BOX)
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
	     (pushable c)
	     (inroom c rm1)
;	     (inroom b rm2)
;	     (inroom a rm2)
	     (inroom key12 rm1)
	     (inroom robot rm2)
	     (carriable key12)
	     (is-key dr12 key12)))
       (igoal (and (inroom key12 rm1) (inroom c rm2)))))

#|
Solution:
	<goto-dr dr12 rm2>
	<open-door dr12>
	<go-thru-dr dr12 rm2 rm1>
	<goto-obj c rm1>
	<push-to-dr c dr12 rm1>
	<push-thru-dr c dr12 rm1 rm2>
|#
