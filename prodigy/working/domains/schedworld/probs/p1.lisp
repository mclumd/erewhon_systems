(setf (current-problem)
      (create-problem
       (name p1)
       (objects
	(PART1 Object))
       (state
	(and (shape PART1 undetermined)
	     (last-scheduled Part1 0)
	     (has-clamp Polisher)
	     (temperature Part1 Cold)
	     (last-time 3)))
       (igoal
	(and (shape PART1 CYLINDRICAL)
	     (surface-condition PART1 POLISHED)))))