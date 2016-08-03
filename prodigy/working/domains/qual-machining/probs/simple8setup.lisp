;;same as simple5 but there are more than one milling-machine
;;available. 
;;drill hole in milling machine if also needs to reduce size

(setf (current-problem)
      (create-problem
       (name simple8)
       (objects
	(objects-are mm1 mm2 MILLING-MACHINE)
	(object-is drill1 DRILL)

	(object-is spot-drill1 SPOT-DRILL)
	(object-is twist-drill6 TWIST-DRILL)
	(object-is plain-mill1 PLAIN-MILL)
	(object-is end-mill1 END-MILL)

	(object-is vise1 VISE)

	(object-is brush1 BRUSH)
	(object-is soluble-oil SOLUBLE-OIL)
	(object-is mineral-oil MINERAL-OIL)

        (object-is part5 PART)
	(objects-are hole1 hole2 HOLE))
       (state
	(and
	 (always-true)
	 (diameter-of-drill-bit twist-drill6 9/64)
	 (material-of part5 ALUMINUM)
	 (size-of part5 LENGTH 5)
	 (size-of part5 WIDTH 3)
	 (size-of part5 HEIGHT 3)

	 (has-device mm2 vise1)
	 (on-table mm2 part5)
	 (holding-tool mm2 spot-drill1)
	 (holding mm2 vise1 part5 side1 side3-side6)
	 ))
       (goal
	((<part> PART))
	(and
	 (size-of <part> HEIGHT 2)
	 (has-hole <part> hole1 side1 0.3 9/64 1.375 0.25)
	 ))))
