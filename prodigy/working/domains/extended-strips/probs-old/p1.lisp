(setf (current-problem)
      (create-problem
       (name p1)
       (objects
	(rm1 rm2 ROOM)
	(dr12 DOOR)
	(B1 b2 OBJECT))
       (state
	(and (arm-empty)
	     (inroom robot rm1)
	     (pushable b1)
	     (pushable b2)
	     (inroom b1 rm1)
	     (inroom b2 rm1)
	     (dr-to-rm dr12 rm1)
	     (dr-to-rm dr12 rm2)
	     (connects dr12 rm1 rm2)
	     (connects dr12 rm2 rm1)
	     (connects dr12 rm2 rm1)
	     (connects dr12 rm1 rm2)
	     (dr-open dr12)))
       (igoal (and (inroom robot rm2)))))
; (next-to b1 b2)

#|
Solution:
	<goto-dr dr12 rm1>
	<go-thru-dr dr12 rm1 rm2>
|#
