(setf (getf (p4::problem-space-plist *current-problem-space*) :depth-bound) 30)
(output-level 3)

(setf (current-problem)
      (create-problem
       (name goto-dr)
       (objects
	(room1 room2 Room)
	(door12 Door)
	(box1 Box)
	)
       (state
	(and
	 (dr-to-rm door12 room1)(dr-to-rm door12 room2)
	 (connects door12 room1 room2)
	 (connects door12 room2 room1)
	 (dr-open door12)
	 (arm-empty)
	 (next-to robot box1)
	 (inroom robot room1)
	 (inroom box1 room1)
	 (pushable box1)))
       (goal (next-to robot door12))))
	
	 

    
