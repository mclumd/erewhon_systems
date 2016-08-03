;;; Rujith de Silva 1994-11-02
;;; Simple problem in the sim-robot domain
(setf (current-problem)
      (create-problem
       (name test2)
       (objects
	(a b BOX)
	(room1 room2 ROOM)
        (door DOOR))
       (state
	(and (door-to-room door room1)
             (door-to-room door room2)
             (connects door room1 room2)
             (door-open door)
             (pushable a)
             (pushable b)
	     (in-room b room1)
	     (in-room a room1)
	     (in-room robot room1)
	     (arm-empty)))
       (igoal (and (next-to robot door) (next-to a b)))))
