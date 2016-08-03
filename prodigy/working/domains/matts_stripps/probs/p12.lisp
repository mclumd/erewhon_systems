(setf (current-problem) 
	(create-problem
		(name p12)
		 (objects
			(rmA rmB ROOM)
			(boxA boxB boxC BOX)
			(drA DOOR)
			(keyA KEY)
)
		(state
			(and
				(carriable boxA)
				(inroom boxA rmA)
				(pushable boxB)
				(inroom boxB rmA)
				(pushable boxC)
				(inroom boxC rmA)
				(dr-to-rm drA rmA)
				(dr-to-rm drA rmB)
				(connects drA rmA rmB)
				(connects drA rmB rmA)
				(unlocked drA)
				(dr-closed drA)
				(is-key keyA drA)
				(carriable keyA)
				(inroom keyA rmA)
				(inroom robot rmB)
				(arm-empty)
))
		(goal
			(and
				(inroom boxA rmA)
))))