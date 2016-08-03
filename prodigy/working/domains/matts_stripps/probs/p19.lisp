(setf (current-problem) 
	(create-problem
		(name p19)
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
				(pushable boxC)
				(inroom boxC rmA)
				(dr-to-rm drA rmA)
				(dr-to-rm drA rmB)
				(connects drA rmA rmB)
				(connects drA rmB rmA)
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