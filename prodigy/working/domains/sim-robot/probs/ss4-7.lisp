(setf (current-problem)
      (create-problem
       (name ss2-4)
       (objects
	(a b BOX)
	(key12 KEY)
	(rm1 rm2 ROOM)
	(dr12 DOOR))
       (state
	(and  (dr-to-rm dr12 rm2)
	      (dr-to-rm dr12 rm1)
	      (connects dr12 rm2 rm1)
	      (connects dr12 rm1 rm2)
	      (connects dr12 rm1 rm2)
	      (connects dr12 rm2 rm1)
	      (arm-empty)
	      (unlocked dr12)
	      (dr-open dr12)
	      (pushable b)
	      (inroom b rm2)
	      (inroom a rm2)
	      (inroom key12 rm1)
	      (inroom robot rm2)
	      (is-key dr12 key12)))
       (igoal (and (locked dr12) (inroom key12 rm2)))))