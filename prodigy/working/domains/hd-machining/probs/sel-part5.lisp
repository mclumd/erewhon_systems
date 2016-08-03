;;from testpart6
;; How to select an available part such that the number of ops (in
;; particular number of set ups) is reduced.

(setf (current-problem)
      (create-problem
       (name sel-part5)
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

        (objects-are part5 part55 PART)
	(objects-are hole1 hole2 hole3 HOLE))
       (state
	(and
	 (always-true)
	 (diameter-of-drill-bit twist-drill13 1/4)
	 (diameter-of-drill-bit tap14 1/4)
	 (size-of-drill-bit counterbore2 1/2)
	 (diameter-of-drill-bit high-helix-drill1 1/32)
	 (diameter-of-drill-bit tap1 1/32)

	 ;;part5
	 (material-of part5 ALUMINUM)
	 (size-of part5 LENGTH 5)
	 (size-of part5 WIDTH 4)
	 (size-of part5 HEIGHT 3)
	 (has-hole part5 hole1 side1 .5 1/4 1/2 1.5)
	 (has-hole part5 hole2 side1 .5 1/4 1/2 2.5)
	 
	 ;;part55
	 (material-of part55 ALUMINUM)
         (size-of part55 LENGTH 4)
         (size-of part55 WIDTH 4)
         (size-of part55 HEIGHT .5)
	 ))
       (goal
	((<part> PART))
	(and 
	 (material-of <part> ALUMINUM)
	 (size-of <part> LENGTH 4)
	 (size-of <part> WIDTH 3)
	 (size-of <part> HEIGHT 0.5)

	 (has-hole <part> hole1 side1 .5 1/4 1/2 1.5)
	 (has-hole <part> hole2 side1 .5 1/4 1/2 2.5)
	 ))))

;;conspiracy number is 3 for both. Used control rule to force each part.

#|  part5
Solution:
  1. <put-tool-on-milling-machine milling-machine1 end-mill1>
  2. <put-holding-device-in-milling-machine milling-machine1 vise1>
  3. <clean part5>
  4. <put-on-machine-table milling-machine1 part5>
  5. <hold-with-vise milling-machine1 vise1 part5 side2 side5>
  6. <face-mill milling-machine1 part5 end-mill1 vise1 side4 height 0.5>
  7. <release-from-holding-device milling-machine1 vise1 part5 side2 side5>
  8. <remove-burrs part5 brush1>
  9. <clean part5>
  10. <hold-with-vise milling-machine1 vise1 part5 side1 side4>
  11. <side-mill milling-machine1 part5 end-mill1 vise1 side6 side5 width 3>
  12. <face-mill milling-machine1 part5 end-mill1 vise1 side6 length 4>
compute-cost = 23

Solution:  part55
  1. <put-tool-on-milling-machine milling-machine1 spot-drill1>
  2. <put-holding-device-in-milling-machine milling-machine1 vise1>
  3. <clean part55>
  4. <put-on-machine-table milling-machine1 part55>
  5. <hold-with-vise milling-machine1 vise1 part55 side3 side6>
  6. <drill-with-spot-drill-in-milling-machine milling-machine1 spot-drill1 vise1 part55 hole2 side1>
  7. <drill-with-spot-drill-in-milling-machine milling-machine1 spot-drill1 vise1 part55 hole1 side1>
  8. <remove-tool-from-machine milling-machine1 spot-drill1>
  9. <put-tool-on-milling-machine milling-machine1 twist-drill13>
  10. <release-from-holding-device milling-machine1 vise1 part55 side3 side6>
  11. <remove-burrs part55 brush1>
  12. <clean part55>
  13. <hold-with-vise milling-machine1 vise1 part55 side2 side5>
  14. <drill-with-twist-drill-in-milling-machine milling-machine1 twist-drill13 vise1 part55 hole2 side1 0.5 1/4>
  15. <drill-with-twist-drill-in-milling-machine milling-machine1 twist-drill13 vise1 part55 hole1 side1 0.5 1/4>
  16. <remove-tool-from-machine milling-machine1 twist-drill13>
  17. <put-tool-on-milling-machine milling-machine1 end-mill1>
  18. <release-from-holding-device milling-machine1 vise1 part55 side2 side5>
  19. <remove-burrs part55 brush1>
  20. <clean part55>
  21. <hold-with-vise milling-machine1 vise1 part55 side1 side4>
  22. <face-mill milling-machine1 part55 end-mill1 vise1 side5 width 3>
compute-cost = 39
|#




