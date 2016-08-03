;same simple4setup.lisp, but not so much setup ready yet

;;choose same bindings (side-pair) to make hole and spot hole

(setf (current-problem)
      (create-problem
       (name simple4setup2)
       (objects
	(object-is milling-machine1 MILLING-MACHINE)
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

	 (has-device drill1 vise1)
	 (on-table drill1 part5)
	 (holding-tool drill1 spot-drill1)
	 ))
       (goal
	((<part> PART))
	(has-hole <part> hole1 side1 0.3 9/64 1.375 0.25)
	)))

