(setf (current-problem) 
	(create-problem
		(name p23)
		 (objects
			(rmA rmB ROOM)
			(boxA boxB boxC BOX)
			(drA DOOR)
			(keyA KEY)
)
		(state
			(and
				(pushable boxA)
				(inroom boxA rmA)
				(pushable boxB)
				(inroom boxB rmB)
				(pushable boxC)
				(inroom boxC rmA)
				(dr-to-rm drA rmB)
				(dr-to-rm drA rmA)
				(connects drA rmB rmA)
				(connects drA rmA rmB)
				(locked drA)
				(dr-closed drA)
				(is-key keyA drA)
				(carriable keyA)
				(inroom keyA rmB)
				(inroom robot rmA)
				(arm-empty)
))
		(goal
			(and
				(inroom boxC rmA)
))))