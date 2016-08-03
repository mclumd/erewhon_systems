(setf (current-problem)
      (create-problem
       (name p2)
       (objects
	(part1 part2 PART)
	(polisher1 polisher2 POLISHER)
	(sprayer1 SPRAY-PAINTER)
	(t0 t1 t2 t3 TIME))
       (state
	(and (surface-condition part1 unknown)
	     (surface-condition part2 unknown) 
	     (last-scheduled part1 t0)
	     (last-scheduled part2 t0)))
       (goal
	(and (surface-condition part1 polished)
	     (surface-condition part1 painted)
	     (surface-condition part2 polished)
	     (surface-condition part2 painted)))))
