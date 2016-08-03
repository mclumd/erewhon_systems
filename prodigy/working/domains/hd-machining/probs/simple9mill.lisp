;; more than one milling-machine available. 

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

	 (has-device mm1 vise1)
	 (on-table mm1 part5)
;	 (holding mm2 vise1 part5 side1 side3-side6)
	 ))
       (goal
	((<part> PART))
	(size-of <part> HEIGHT 2)
	)))
