(setf (current-problem)
      (create-problem
       (name p1)
       (objects
	(part1 PART)
	(polisher1 polisher2 POLISHER)
	(sprayer1 SPRAY-PAINTER)
	(t0 t1 t2 TIME))
       (state
	(and (surface-condition part1 unknown) 
	     (last-scheduled part1 t0)))
       (goal
	(and (surface-condition part1 polished)
	     (surface-condition part1 painted)))))
