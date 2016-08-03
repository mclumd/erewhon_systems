(setf (current-problem)
      (create-problem
       (name drill2)
       (objects
        (object-is milling-machine1 MILLING-MACHINE)
	(object-is drill1 DRILL)
        (object-is vise1 VISE)
	(object-is milling-cutter1 PLAIN-MILL)
	(object-is milling-cutter2 END-MILL)
	(object-is spot-drill1 SPOT-DRILL)
	(object-is twist-drill2 TWIST-DRILL)
	(object-is tap3 TAP)
	(object-is brush1 BRUSH)
	(object-is soluble-oil SOLUBLE-OIL)
	(object-is mineral-oil MINERAL-OIL)

	(object-is hole1 HOLE)
	(object-is part2 PART))
       (state
	(and
	 (always-true)
	 (diameter-of-drill-bit twist-drill2 5/64)
	 (diameter-of-drill-bit tap3 5/64)
	
	 (material-of part2 COPPER)
	 (size-of part2 LENGTH 5)
	 (size-of part2 WIDTH 3)
	 (size-of part2 HEIGHT 3)))
       (goal
;	((<part> PART))
;	 (and
;	  (size-of <part> LENGTH 4)
;	  (size-of <part> HEIGHT 1)
;	  (size-of <part> WIDTH 2)
;	  (is-tapped <part> hole1 side1 1 5/64 .5 .5))
	(and
	 (size-of part2 LENGTH 4)
	 (size-of part2 HEIGHT 1)
	 (size-of part2 WIDTH 2)
	 (is-tapped part2 hole1 side1 1 5/64 .5 .5)))))
