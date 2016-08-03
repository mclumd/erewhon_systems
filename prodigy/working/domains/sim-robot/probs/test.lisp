
(setf (current-problem)
      (create-problem
       (name test)
       (objects
	(rm1 rm2 ROOM)
	(dr12 DOOR)
	(B A OBJECT)
	(key12 KEY))
       (state
	(and (carriable B)
	     (next-to robot B)
	     (arm-empty)
	     (next-to B dr12)
	     (inroom B rm1)))

       (igoal (~ (next-to B dr12)))))

