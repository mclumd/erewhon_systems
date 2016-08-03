(setf (current-problem)
      (create-problem
       (name drill2)
       (objects
        (object-is lathe1 LATHE)
	(object-is drill1 DRILL)
	(object-is electric-spray-gun1 ELECTRIC-ARC-SPRAY-GUN)

	(object-is wire1 SPRAYING-METAL-WIRE)
	(object-is wire10 SPRAYING-METAL-WIRE)

	(object-is rough-toolbit1 ROUGH-TOOLBIT)

	(object-is vise1 VISE)
        (object-is toe-clamp1 TOE-CLAMP)
        (object-is centers1 CENTERS)

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
	 (material-of wire1 STAINLESS-STEEL)
	 (material-of wire10 TUNGSTEN)
	 (diameter-of-drill-bit center-drill1 1/16)
	 (angle-of-drill-bit countersink1 60)

	 (material-of part15 ALUMINUM)
	 (size-of part15 LENGTH 5)
	 (size-of part15 DIAMETER 3)

	 (surface-coating part15 FUSED-METAL)))
       (goal
	((<part> PART))
	(surface-coating <part> CORROSION-RESISTANT))))