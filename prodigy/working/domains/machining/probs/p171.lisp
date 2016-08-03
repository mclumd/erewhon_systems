(setf (current-problem)
      (create-problem
       (name drill2)
       (objects
	(object-is oxygentank-regulator-torch1 GAS-WELDER)
	(object-is rod1 WELDING-ROD)
	(object-is torch1 TORCH)
	(object-is vise1 VISE)
        (object-is toe-clamp1 TOE-CLAMP)

	(object-is part136 PART)	
	(object-is part36 PART))
       (state
	(and
	 (always-true)       	
	 (material-of part36 STEEL)
	 (size-of part36 LENGTH 10)
	 (size-of part36 DIAMETER 5)
	 (surface-finish-side part36 SIDE0 COLD-ROLLED)
	 (surface-finish-side part36 SIDE3 FINISH-MILL)
	 (surface-finish-side part36 SIDE6 ROUGH-MILL)

	 (material-of part136 STEEL)
	 (size-of part136 LENGTH 3)
	 (size-of part136 DIAMETER 5)
	 (surface-finish-side part136 SIDE0 COLD-ROLLED)
	 (surface-finish-side part136 SIDE3 FINISH-GRIND)
	 (surface-finish-side part136 SIDE6 ROUGH-GRIND)))
       (goal
	((<part> PART))
	(size-of <part> LENGTH 13))))