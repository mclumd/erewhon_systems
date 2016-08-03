(setf (current-problem) 
	(create-problem
		(name p25)
		 (objects
			(rmA rmB ROOM)
			(boxA boxB boxC BOX)
			(drA DOOR)
			(keyA KEY)
)
		(state
			(and
				(carriable boxA)
				(inroom boxA rmB)
				(pushable boxB)
				(inroom boxB rmA)
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
				(inroom keyA rmB)
				(inroom robot rmA)
				(arm-empty)
))
		(goal
			(and
				(dr-closed drA)
))))