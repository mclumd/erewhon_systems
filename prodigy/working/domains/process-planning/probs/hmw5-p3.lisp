(setf (current-problem)
      (create-problem
       (name p2)
       (objects
	(part1 part2 PART)
	(bolting1 BOLTING-MACHINE)
	(drill1 DRILL-PRESS) 
	(t0 t1 t2 TIME))
       (state
	(and (has-hole part2 )
	     (last-scheduled part1 t0)
	     (last-scheduled part2 t0)))
       (goal 
	(joined part1 part2))))
