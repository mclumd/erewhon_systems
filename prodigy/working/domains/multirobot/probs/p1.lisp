(setf (current-problem)
      (create-problem
       (name p1)
       (objects
	(object-is A BOX)
	(object-is B BLOCK)
	(objects-are robot1 robot2 ROBOT)
	(object-is d12 DOOR)
	(objects-are room1 room2 ROOM))
       (state
	(and  (lower-corner room1  0  0)
	      (upper-corner room1  3  1)
	      (lower-corner room2  0  2)
	      (upper-corner room2  3  3)
	      (door-loc d12 2 1 2 2)
	      (at robot1 0 0)
	      (at robot2 0 0)
	      (at A 3 0)
	      (pushable A)
	      (door-closed d12)))
       (igoal (and (at A 0 0)
		   (door-open d12)))))


       
