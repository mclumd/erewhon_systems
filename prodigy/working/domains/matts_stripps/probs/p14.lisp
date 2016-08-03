(setf (current-problem) 
	(create-problem
		(name p14)
		 (objects
			(rmA rmB ROOM)
			(boxA boxB boxC BOX)
			(drA DOOR)
			(keyA KEY)
)
		(state
			(and
				(pushable boxA)
				(inroom boxA rmB)
				(pushable boxB)
				(inroom boxB rmB)
				(carriable boxC)
				(inroom boxC rmB)
				(dr-to-rm drA rmB)
				(dr-to-rm drA rmA)
				(connects drA rmB rmA)
				(connects drA rmA rmB)
				(locked drA)
				(dr-closed drA)
				(is-key keyA drA)
				(carriable keyA)
				(inroom keyA rmA)
				(inroom robot rmB)
				(arm-empty)
))
		(goal
			(and
				(inroom boxB rmB)
))))