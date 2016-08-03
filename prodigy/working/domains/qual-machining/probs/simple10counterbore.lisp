;; adapted from testpart7. size-of goals in different parts

(setf (current-problem)
      (create-problem
       (name simple10)
       (objects
	(object-is drill1 DRILL)
        (object-is milling-machine1 MILLING-MACHINE)

        (object-is vise1 VISE)

	(object-is spot-drill1 SPOT-DRILL)
	(object-is twist-drill13 TWIST-DRILL)
	(object-is tap14 TAP)
	(object-is counterbore2 COUNTERBORE)	
	(object-is high-helix-drill1 HIGH-HELIX-DRILL)
	(object-is tap1 TAP)
	(object-is plain-mill1 PLAIN-MILL)
	(object-is end-mill1 END-MILL)
	
	(object-is brush1 BRUSH)
	(object-is soluble-oil SOLUBLE-OIL)
	(object-is mineral-oil MINERAL-OIL)

        (objects-are part5 part1 PART)
	(objects-are hole1 hole2 HOLE))
       (state
	(and
	 (always-true)
	 (diameter-of-drill-bit twist-drill13 1/4)
	 (diameter-of-drill-bit tap14 1/4)
	 (size-of-drill-bit counterbore2 1/2)
	 (diameter-of-drill-bit high-helix-drill1 1/32)
	 (diameter-of-drill-bit tap1 1/32)
	 (material-of part5 ALUMINUM)
	 (size-of part5 LENGTH 5)
	 (size-of part5 WIDTH 3)
	 (size-of part5 HEIGHT 3)
	 (material-of part1 ALUMINUM)
	 (size-of part1 LENGTH 5)
	 (size-of part1 WIDTH 3)
	 (size-of part1 HEIGHT 3)))
       (goal
	()
;	(and 
;	 (size-of part1 HEIGHT 0.5)
	 (is-counterbored part5 hole1 side1 .5 1/4 1/2 1.5 1/2)
;	 (size-of part5 LENGTH 0.5))
	 )))

