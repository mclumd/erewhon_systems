(setf (current-problem) 
	(create-problem
		(name p44)
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
				(carriable boxB)
				(inroom boxB rmB)
				(carriable boxC)
				(inroom boxC rmB)
				(dr-to-rm drA rmB)
				(dr-to-rm drA rmA)
				(connects drA rmB rmA)
				(connects drA rmA rmB)
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
				(inroom boxA rmB)
))))