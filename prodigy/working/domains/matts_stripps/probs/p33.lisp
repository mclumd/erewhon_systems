(setf (current-problem) 
	(create-problem
		(name p33)
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
				(carriable boxB)
				(inroom boxB rmB)
				(pushable boxC)
				(inroom boxC rmA)
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
				(unlocked drA)
))))