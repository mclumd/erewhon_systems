;;; Rujith de Silva 1994-11-02
;;; Simple problem in the sim-robot domain
(setf (current-problem)
      (create-problem
       (name test3)
       (objects
	(box BOX)
        (key KEY)
	(room1 room2 ROOM)
        (door DOOR)
        (x locx)
        (y locy))
       (state
	(and (door-to-room door room1)
             (door-to-room door room2)
             (connects door room1 room2)
             (loc-in-room x y room1)
             (door-closed door)
             (locked door)
             (pushable box)
	     (in-room box room1)
             (in-room key room1)
             (carriable key)
             (is-key door key)
	     (in-room robot room1)
             (next-to robot key)
	     (arm-empty)))
       (igoal (and (in-room robot room2) (at box x y)))))
