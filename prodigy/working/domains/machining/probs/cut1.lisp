(setf (current-problem)
      (create-problem
       (name drill2)
       (objects
        (object-is milling-machine1 MILLING-MACHINE)
        (object-is vise1 VISE)
	(object-is milling-cutter1 PLAIN-MILL)
	(object-is milling-cutter2 END-MILL)
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
	 (size-of part2 HEIGHT 3)))
       (goal
	((<part> PART))
	(and
	 (size-of <part> LENGTH 4)
	 (size-of <part> HEIGHT 1)
	 (size-of <part> WIDTH 2))
	)))
