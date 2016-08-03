	(setf (current-problem)
	 (create-problem
	  (name SS1-4)
	  (objects
	   (a b c BOX)
	   (dr12 DOOR)
	   (key12 KEY)
	   (rm1 rm2 ROOM))
	  (state
	   (and (arm-empty)
		(dr-to-rm dr12 rm2)
		(dr-to-rm dr12 rm1)
		(connects dr12 rm2 rm1)
		(connects dr12 rm1 rm2)
		(dr-closed dr12)
		(locked dr12)
		(pushable C)
		(carriable B)
		(inroom C rm1)
		(inroom B rm1)
		(inroom A rm2)
		(inroom key12 rm2)
		(inroom robot rm2)
		(carriable key12)
		(is-key dr12 key12)))
	  (goal (and (inroom C rm2) (inroom robot rm1)))))
