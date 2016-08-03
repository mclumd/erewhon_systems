(setf (getf (p4::problem-space-plist *current-problem-space*) :depth-bound) 50)
(output-level 3)

	(setf (current-problem)
	 (create-problem
	  (name SS2-12)
	  (objects
	   (a b BOX)
	   (key12 KEY)
	   (rm1 rm2 ROOM)
	   (dr12 DOOR))
	  (state
	   (and (arm-empty)
		(dr-to-rm dr12 rm2)
		(dr-to-rm dr12 rm1)
		(connects dr12 rm2 rm1)
		(connects dr12 rm1 rm2)
		(unlocked dr12)
		(dr-open dr12)
		(carriable B)
		(inroom B rm1)
		(inroom A rm2)
		(inroom key12 rm2)
		(inroom robot rm2)
		(carriable key12)
		(is-key dr12 key12)))
	  (goal (next-to A B))))
	
