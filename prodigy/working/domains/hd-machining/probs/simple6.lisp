;;from testpart3. Three holes with different tools, two of them with
;;the same setup (on same side).

(setf (current-problem)
      (create-problem
       (name simple6)
       (objects
	(object-is drill1 DRILL)
        (object-is milling-machine1 MILLING-MACHINE)

        (object-is vise1 VISE)

	(object-is spot-drill1 SPOT-DRILL)
	(objects-are twist-drill13 twist-drill5 twist-drill1
		     TWIST-DRILL)
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
	 (diameter-of-drill-bit twist-drill1 1/6)
	 
	 (material-of part51 BRASS)
	 (size-of part51 LENGTH 5)
	 (size-of part51 WIDTH 2)
	 (size-of part51 HEIGHT 3)))
       (goal
	((<part> PART))
	(and 
	 (material-of <part> BRASS)

	 (has-hole  <part> hole1 side1 1 1/8 .5 .25)
	 (has-hole <part> hole4 side4 1 1/6  2.25 .25)
	 (has-hole  <part> hole2 side1 1 1/4 2.25 .25)
	 ))))

(setf (getf (p4::problem-space-plist *current-problem-space*)
	    :depth-bound) 1000)

#|
If the order of the goals is 
	 (has-hole  <part> hole1 side1 1 1/8 .5 .25)
	 (has-hole  <part> hole2 side1 1 1/4 2.25 .25)
	 (has-hole <part> hole4 side4 1 1/6  2.25 .25)

the solution obtained with eff-rules.lisp is the same as with
eff-rules.lisp but without switch-mach-operation-same-tool and
switch-mach-operation-same-hd-setup.
|#
