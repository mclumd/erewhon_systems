(setf (current-problem)
      (create-problem
       (name drill2)
       (objects
	(object-is drill1 DRILL)
	(object-is spot-drill1 SPOT-DRILL)
	(object-is straight-fluted-drill3 STRAIGHT-FLUTED-DRILL)
	(object-is high-helix-drill3 HIGH-HELIX-DRILL)
	(object-is reamer3 REAMER)
	(object-is vise1 VISE)
	(object-is brush1 BRUSH)
	(object-is soluble-oil SOLUBLE-OIL)
	(object-is mineral-oil MINERAL-OIL)
	(objects-are part2 part6 PART)
	(objects-are hole1 hole2 HOLE)
	(objects-are side1 side5 SIDE))
       (state
	(and
	 (always-true)
	 (diameter-of-drill-bit straight-fluted-drill3 3/32)
	 (diameter-of-drill-bit high-helix-drill3 3/32)
	 (diameter-of-drill-bit reamer3 3/32)

	 (material-of part2 COPPER)
	 (size-of part2 LENGTH 5)
	 (size-of part2 WIDTH 3)
	 (size-of part2 HEIGHT 3)

	 (material-of part6 STEEL)
	 (size-of part6 LENGTH 5)
	 (size-of part6 WIDTH 3)
	 (size-of part6 HEIGHT 3)))
       ;; in 2.0 it works with part6
       (goal
	((<part> PART))
	(and (is-reamed <part> hole1 side1 1 3/32 1 1)
	     (has-hole <part> hole2 side5 1.5 3/32 2 2))
;	(and (is-reamed part6 hole1 side1 1 3/32 1 1)
;	     (has-hole part6 hole2 side5 1.5 3/32 2 2))
	)))
	