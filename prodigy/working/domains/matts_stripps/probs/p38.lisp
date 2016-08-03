(setf (current-problem) 
	(create-problem
		(name p38)
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
				(inroom boxB rmB)
				(carriable boxC)
				(inroom boxC rmA)
				(dr-to-rm drA rmA)
				(dr-to-rm drA rmB)
				(connects drA rmA rmB)
				(connects drA rmB rmA)
				(locked drA)
				(dr-closed drA)
				(is-key keyA drA)
				(carriable keyA)
				(inroom keyA rmB)
				(inroom robot rmB)
				(arm-empty)
))
		(goal
			(and
				(inroom boxA rmA)
))))