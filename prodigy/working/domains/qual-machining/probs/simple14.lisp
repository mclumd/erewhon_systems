;;from simple12.lisp

(setf (current-problem)
      (create-problem
       (name simple14)
       (objects
	(object-is drill1 DRILL)
        (object-is milling-machine1 MILLING-MACHINE)

        (object-is vise1 VISE)

	(object-is spot-drill1 SPOT-DRILL)
	(objects-are twist-drill13 twist-drill5 TWIST-DRILL)
	(object-is tap6 TAP)
	(object-is counterbore4 COUNTERBORE)	
	(object-is plain-mill1 PLAIN-MILL)
	(object-is end-mill1 END-MILL)
	
	(object-is brush1 BRUSH)
	(object-is soluble-oil SOLUBLE-OIL)
	(object-is mineral-oil MINERAL-OIL)

        (object-is part51 PART)
	(objects-are hole1 hole2 hole3 hole4 HOLE))
       (state
	(and
	 (always-true)
	 (diameter-of-drill-bit twist-drill13 1/4)
	 (diameter-of-drill-bit twist-drill5 1/8)
	 (diameter-of-drill-bit tap6 1/8)
	 (size-of-drill-bit counterbore4 3/8)

	 (material-of part51 BRASS)
	 (size-of part51 LENGTH 5)
	 (size-of part51 WIDTH 2)
	 (size-of part51 HEIGHT 3)

	 (holding-tool drill1 twist-drill5)
	 (has-spot part51 hole1 side1 .5 .25)
	 (has-spot part51 hole3 side4 .25 1.12)	 
	 ))
       (goal
	((<part> PART))
	(and 
	 (has-hole <part> hole1 side1 1 1/8 .5 .25)
	 (has-hole <part> hole3 side4 3 1/4 .25 1.12)
	 ))))

(setf (getf (p4::problem-space-plist *current-problem-space*)
	    :depth-bound) 1000)
