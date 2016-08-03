(setf (current-problem)
      (create-problem
       (name kill-the-mouse)
       (objects
	(jerry Toy-Mouse)
	(room1 room2 Room))
       (state
	(and (in jerry room1)
	     (in lyotard room2)
	     (frustrated lyotard)))
       (igoal
	(~ (frustrated lyotard)))
     ))

