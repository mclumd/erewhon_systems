(setf (current-problem) 
	(create-problem
		(name p16)
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
				(carriable boxB)
				(inroom boxB rmA)
				(carriable boxC)
				(inroom boxC rmA)
				(dr-to-rm drA rmA)
				(dr-to-rm drA rmB)
				(connects drA rmA rmB)
				(connects drA rmB rmA)
				(unlocked drA)
				(dr-closed drA)
				(is-key keyA drA)
				(carriable keyA)
				(inroom keyA rmB)
				(inroom robot rmB)
				(arm-empty)
))
		(goal
			(and
				(inroom keyA rmA)
))))