(setf (current-problem)
      (create-problem
       (name drill2)
       (objects
        (object-is shaper1 SHAPER)
	(object-is cutting-tool1 ROUGHING-CUTTING-TOOL)

        (object-is vise1 VISE)

	(object-is brush1 BRUSH)

	(object-is soluble-oil SOLUBLE-OIL)
	(object-is mineral-oil MINERAL-OIL)

	(object-is part2 PART))
       (state
	(and
	 (always-true)
	 (size-of-machine shaper1 20)
	 (material-of part2 COPPER)
	 (size-of part2 LENGTH 5.000001)
	 (size-of part2 WIDTH 3)
	 (size-of part2 HEIGHT 2)))
       (goal
	((<part> PART))
	(surface-finish-side <part> side3 ROUGH-SHAPED))))
