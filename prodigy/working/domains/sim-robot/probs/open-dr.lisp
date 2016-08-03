(setf (getf (p4::problem-space-plist *current-problem-space*) :depth-bound) 50)
(output-level 3)

(setf (current-problem)
      (create-problem
       (name open-dr)
       (objects
	(room1 room2 room3 room4 Room)
	(door12 door13 door34 door24 Door)
	(box1 box2 box3 Box)
	)
       (state
	(and
	 (dr-to-rm door12 room1)(dr-to-rm door12 room2)
	 (dr-to-rm door13 room1)(dr-to-rm door13 room3)
	 (dr-to-rm door34 room3)(dr-to-rm door34 room4)
	 (dr-to-rm door24 room2)(dr-to-rm door24 room4)
	 (connects door12 room1 room2)
	 (connects door13 room1 room3)
	 (connects door34 room3 room4)
	 (connects door24 room2 room4)
	 (connects door12 room2 room1)
	 (connects door13 room3 room1)
	 (connects door34 room4 room3)
	 (connects door24 room4 room2)
	 (dr-open door12)
	 (dr-open door13)
	 (dr-open door34)
	 (dr-closed door24)
	 (unlocked door34)
	 (locked door24)
	 (arm-empty)
	 (next-to robot box3)
	 (inroom robot room3)
	 (inroom box1 room3)
	 (inroom box2 room3)
	 (inroom box3 room4)
	 (pushable box1)
	 (pushable box2)
	 (pushable box3)))
       (igoal
	(dr-closed door34))
;	(and
;	 (dr-closed door34)
;	 (next-to robot box3)))
	))
	 

    
