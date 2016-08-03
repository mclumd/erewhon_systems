(setf (current-problem) 
	(create-problem
		(name p42)
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
				(carriable boxC)
				(inroom boxC rmB)
				(dr-to-rm drA rmB)
				(dr-to-rm drA rmA)
				(connects drA rmB rmA)
				(connects drA rmA rmB)
				(unlocked drA)
				(dr-open drA)
				(is-key keyA drA)
				(carriable keyA)
				(inroom keyA rmA)
				(inroom robot rmA)
				(arm-empty)
))
		(goal
			(and
				(dr-closed drA)
))))