(setf (current-problem)
      (create-problem
       (name ss2-2)
       (objects
	(a b c BOX)
	(key12 KEY)
	(room1 room2 ROOM)
	(door12 DOOR))
       (state
	(and (door-to-room door12 room2)
	     (door-to-room door12 room1)
	     (connects door12 room1 room2)
	     (unlocked door12)
	     (door-open door12)
	     (pushable a)
	     (in-room c room2)
	     (in-room b room1)
	     (in-room a room2)
	     (in-room key12 room1)
	     (in-room robot room1)
	     (carriable key12)
	     (arm-empty)
	     (is-key door12 key12)))
       (igoal (and (door-closed door12) (in-room robot room2)))))

#|
Solution:
	<goto-door door12 room1>
	<go-thru-door door12 room1 room2>
	<close-door door12>
|#
