;;; Rujith de Silva 1994-10-30
;;; Simple problem in the sim-robot domain
(setf (current-problem)
      (create-problem
       (name test1)
       (objects
	(a b BOX)
	(room ROOM)
        (door DOOR))
       (state
	(and (door-to-room door room)
             (pushable a)
             (pushable b)
	     (in-room b room)
	     (in-room a room)
	     (in-room robot room)
	     (arm-empty)))
       (igoal (and (next-to robot door) (next-to a b)))))
