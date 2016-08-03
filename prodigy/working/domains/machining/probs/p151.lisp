(setf (current-problem)
      (create-problem
       (name drill2)
       (objects
        (object-is grinder1 GRINDER)
	(object-is grinding-wheel1 GRINDING-WHEEL)
        (object-is magnetic-chuck1 MAGNETIC-CHUCK)

	(object-is brush1 BRUSH)

	(object-is soluble-oil SOLUBLE-OIL)
	(object-is mineral-oil MINERAL-OIL)

	(object-is part5 PART))
       (state
	(and
	 (always-true)
	 (hardness-of-wheel grinding-wheel1 HARD)
	 (grit-of-wheel grinding-wheel1 COARSE-GRIT)
	 
	 (material-of part5 ALUMINUM)
	 (size-of part5 LENGTH 5)
	 (size-of part5 WIDTH 3)
	 (size-of part5 HEIGHT 2)))
       (goal
	((<part> PART))
	(surface-finish-side <part> SIDE6 ROUGH-GRIND))))
