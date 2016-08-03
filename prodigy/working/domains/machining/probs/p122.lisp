(setf (current-problem)
      (create-problem
       (name drill2)
       (objects
        (object-is milling-machine1 MILLING-MACHINE)
	(object-is spot-drill1 SPOT-DRILL)
	(object-is twist-drill2 TWIST-DRILL)
        (object-is vise1 VISE)
	(object-is brush1 BRUSH)
	(object-is soluble-oil SOLUBLE-OIL)
	(object-is mineral-oil MINERAL-OIL)
	(object-is hole1 HOLE)
	(object-is part1 PART))
       (state
	(and
	 (always-true)
	 (diameter-of-drill-bit twist-drill2 5/64)
	 (material-of part1 BRASS)
	 (size-of part1 LENGTH 5)
	 (size-of part1 WIDTH 3)
	 (size-of part1 HEIGHT 2)))
       (goal
	((<part> PART))
	(has-hole <part> hole1 side1 1 5/64 1 1))))
