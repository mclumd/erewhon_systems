(setf (current-problem)
      (create-problem
       (name drill2)
       (objects
	(object-is drill1 DRILL)
	(object-is spot-drill1 SPOT-DRILL)

	(object-is gun-drill3 GUN-DRILL)
        (object-is vise1 VISE)
	(object-is brush1 BRUSH)
	(object-is soluble-oil SOLUBLE-OIL)
	(object-is mineral-oil MINERAL-OIL)
	(object-is hole1 HOLE)
        (object-is part5 PART))
       (state
	(and
	 (always-true)
	 (diameter-of-drill-bit gun-drill3 3/32)
	 (material-of part5 ALUMINUM)
	 (size-of part5 LENGTH 5)
	 (size-of part5 WIDTH 3)
	 (size-of part5 HEIGHT 2)))
       (goal
	((<part> PART))
	(has-hole <part> hole1 side1 1 3/32 1 1))))
