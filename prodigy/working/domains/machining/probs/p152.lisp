(setf (current-problem)
      (create-problem
       (name drill2)
       (objects
        (object-is grinder1 GRINDER)
	(object-is grinding-wheel2 GRINDING-WHEEL)
        (object-is magnetic-chuck1 MAGNETIC-CHUCK)

	(object-is brush1 BRUSH)

	(object-is soluble-oil SOLUBLE-OIL)
	(object-is mineral-oil MINERAL-OIL)
	(object-is part6 PART))
       (state
	(and
	 (always-true)
	 (hardness-of-wheel grinding-wheel2 SOFT)
	 (grit-of-wheel grinding-wheel2 COARSE-GRIT)
	 (material-of part6 STEEL)
	 (size-of part6 LENGTH 5)
	 (size-of part6 WIDTH 3)
	 (size-of part6 HEIGHT 2)))
       (goal
	((<part> PART))
	(size-of <part> LENGTH 4))))
)
)
