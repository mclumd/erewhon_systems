(setf (current-problem)
      (create-problem
       (name drill2)
       (objects
	(object-is drill1 DRILL)

	(object-is spot-drill1 SPOT-DRILL)

	(object-is straight-fluted-drill1 STRAIGHT-FLUTED-DRILL)

	(object-is counterbore4 COUNTERBORE)
        (object-is vise1 VISE)

	(object-is brush1 BRUSH)

	(object-is soluble-oil SOLUBLE-OIL)
	(object-is mineral-oil MINERAL-OIL)

	(object-is part1 PART)
	(object-is hole1 HOLE))
       (state
	(and
	 (always-true)
	 (diameter-of-drill-bit straight-fluted-drill1 1/32)
	 (size-of-drill-bit counterbore4 3/8)
	 (material-of part1 BRASS)
	 (size-of part1 LENGTH 5)
	 (size-of part1 WIDTH 3)
	 (size-of part1 HEIGHT 2)))
       (goal
       ((<part> PART))
	(is-counterbored <part> hole1 side1 1 1/32 1 1 3/8)
;	(is-counterbored part1 hole1 side1 1 1/32 1 1 3/8)
	)))
