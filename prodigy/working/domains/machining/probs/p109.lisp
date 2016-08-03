(setf (current-problem)
      (create-problem
       (name drill2)
       (objects
	(object-is drill1 DRILL)
	(object-is spot-drill1 SPOT-DRILL)
	(object-is center-drill1 CENTER-DRILL)
	(object-is countersink1 COUNTERSINK)
        (object-is vise1 VISE)
	(object-is toe-clamp1 TOE-CLAMP)
	(object-is brush1 BRUSH)
	(object-is soluble-oil SOLUBLE-OIL)
	(object-is mineral-oil MINERAL-OIL)
	(object-is part15 PART))
       (state
	(and
	 (always-true)
	 (angle-of-drill-bit countersink1 60)
	 (diameter-of-drill-bit center-drill1 1/16)
	 (material-of part15 ALUMINUM)
	 (size-of part15 LENGTH 5)
	 (size-of part15 DIAMETER 3)))
       (goal
	((<part> PART))
	(has-center-holes <part>))))
