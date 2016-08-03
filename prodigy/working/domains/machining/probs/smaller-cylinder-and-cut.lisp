(setf (current-problem)
      (create-problem
       (name drill2)
       (objects
	(object-is drill1 DRILL)
        (object-is lathe1 LATHE)
        (object-is milling-machine1 MILLING-MACHINE)

        (object-is vise1 VISE)
        (object-is toe-clamp1 TOE-CLAMP)
        (object-is centers1 CENTERS)

	(object-is milling-cutter1 PLAIN-MILL)
	(object-is milling-cutter2 END-MILL)

	(object-is rough-toolbit1 ROUGH-TOOLBIT)

	(object-is spot-drill1 SPOT-DRILL)

	(object-is center-drill1 CENTER-DRILL)
	(object-is countersink1 COUNTERSINK)

	(object-is brush1 BRUSH)

	(object-is soluble-oil SOLUBLE-OIL)
	(object-is mineral-oil MINERAL-OIL)

        (object-is part15 PART))
       (state
	(and
	 (always-true)
	 (diameter-of-drill-bit center-drill1 1/16)
	 (angle-of-drill-bit countersink1 60)
	 (material-of part15 ALUMINUM)
	 (size-of part15 LENGTH 5)
	 (size-of part15 DIAMETER 3)))
       (goal
;	((<part> PART))
;	(and 
;	 (size-of <part> DIAMETER 2)
;	 (size-of <part> LENGTH 3.5))
	(and 
	 (size-of part15 DIAMETER 2)
	 (size-of part15 LENGTH 3.5)))))
