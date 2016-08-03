(setf (current-problem)
      (create-problem
       (name drill2)
       (objects
        (object-is circular-saw1 CIRCULAR-SAW)
	(object-is saw-attachment2 FRICTION-SAW)
        (object-is vise1 VISE)
	(object-is brush1 BRUSH)
	(object-is soluble-oil SOLUBLE-OIL)
	(object-is mineral-oil MINERAL-OIL)
	(object-is part2 PART))
       (state
	(and
	 (always-true)       
	 (material-of part2 COPPER)
	 (size-of part2 LENGTH 5)
	 (size-of part2 WIDTH 3)
	 (size-of part2 HEIGHT 2)
	 (surface-finish-side part2 SIDE5 ROUGH-GRIND)))
       (goal
	((<part> PART))
	(surface-finish-side <part> SIDE5 ROUGH-MILL))))