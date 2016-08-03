;;from testpart6
;; How to select an available part such that the number of ops (in
;; particular number of set ups) is reduced.

(setf (current-problem)
      (create-problem
       (name sel-part3)
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

        (objects-are part55 part5 PART)
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
	 (has-hole part5 hole3 side1 .5 1/4 3.5 1.5)
	 
	 ;;part55
	 (material-of part55 ALUMINUM)
         (size-of part55 LENGTH 5)
         (size-of part55 WIDTH 4)
         (size-of part55 HEIGHT 2)
	 ))
       (goal
	((<part> PART))
	(and 
	 (material-of <part> ALUMINUM)
	 (size-of <part> LENGTH 4)
	 (size-of <part> WIDTH 3)
	 (size-of <part> HEIGHT 0.5)

	 (is-tapped <part> hole1 side1 .5 1/4 1/2 1.5)
	 ;;(is-counterbored <part> hole1 side1 .5 1/4 1/2 1.5 1/2)
	 (is-tapped <part> hole2 side1 .5 1/4 1/2 2.5)
	 (is-tapped <part> hole3 side1 .5 1/4 3.5 1.5)
	 ))))

#|
Solution: with part5
  1. <put-in-drill-spindle drill1 tap14>
  2. <clean part5>
  3. <put-holding-device-in-drill drill1 vise1>
  4. <put-on-machine-table drill1 part5>
  5. <hold-with-vise drill1 vise1 part5 side3 side6>
  6. <tap drill1 tap14 vise1 part5 hole3>
  7. <release-from-holding-device drill1 vise1 part5 side3 side6>
  8. <remove-burrs part5 brush1>
  9. <clean part5>
  10. <hold-with-vise drill1 vise1 part5 side3 side6>
  11. <tap drill1 tap14 vise1 part5 hole2>
  12. <release-from-holding-device drill1 vise1 part5 side3 side6>
  13. <remove-burrs part5 brush1>
  14. <clean part5>
  15. <hold-with-vise drill1 vise1 part5 side3 side6>
  16. <tap drill1 tap14 vise1 part5 hole1>
  17. <put-tool-on-milling-machine milling-machine1 end-mill1>
  18. <release-from-holding-device drill1 vise1 part5 side3 side6>
  19. <remove-holding-device-from-machine drill1 vise1>
  20. <put-holding-device-in-milling-machine milling-machine1 vise1>
  21. <remove-burrs part5 brush1>
  22. <clean part5>
  23. <put-on-machine-table milling-machine1 part5>
  24. <hold-with-vise milling-machine1 vise1 part5 side2 side5>
  25. <face-mill milling-machine1 part5 end-mill1 vise1 side4 height 0.5>
  26. <release-from-holding-device milling-machine1 vise1 part5 side2 side5>
  27. <remove-burrs part5 brush1>
  28. <clean part5>
  29. <hold-with-vise milling-machine1 vise1 part5 side1 side4>
  30. <side-mill milling-machine1 part5 end-mill1 vise1 side6 side5 width 3>
  31. <face-mill milling-machine1 part5 end-mill1 vise1 side6 length 4>


Solution: with part5
  1. <put-in-drill-spindle drill1 spot-drill1>
  2. <put-holding-device-in-drill drill1 vise1>
  3. <clean part55>
  4. <put-on-machine-table drill1 part55>
  5. <hold-with-vise drill1 vise1 part55 side3 side6>
  6. <drill-with-spot-drill drill1 spot-drill1 vise1 part55 hole1 side1>
  7. <drill-with-spot-drill drill1 spot-drill1 vise1 part55 hole2 side1>
  8. <drill-with-spot-drill drill1 spot-drill1 vise1 part55 hole3 side1>
  9. <remove-tool-from-machine drill1 spot-drill1>
  10. <put-in-drill-spindle drill1 twist-drill13>
  11. <drill-with-twist-drill drill1 twist-drill13 vise1 part55 hole1 side1 0.5 1/4>
  12. <drill-with-twist-drill drill1 twist-drill13 vise1 part55 hole2 side1 0.5 1/4>
  13. <drill-with-twist-drill drill1 twist-drill13 vise1 part55 hole3 side1 0.5 1/4>
  14. <remove-tool-from-machine drill1 twist-drill13>
  15. <put-in-drill-spindle drill1 tap14>
  16. <release-from-holding-device drill1 vise1 part55 side3 side6>
  17. <remove-burrs part55 brush1>
  18. <clean part55>
  19. <hold-with-vise drill1 vise1 part55 side3 side6>
  20. <tap drill1 tap14 vise1 part55 hole3>
  21. <release-from-holding-device drill1 vise1 part55 side3 side6>
  22. <remove-burrs part55 brush1>
  23. <clean part55>
  24. <hold-with-vise drill1 vise1 part55 side3 side6>
  25. <tap drill1 tap14 vise1 part55 hole2>
  26. <release-from-holding-device drill1 vise1 part55 side3 side6>
  27. <remove-burrs part55 brush1>
  28. <clean part55>
  29. <hold-with-vise drill1 vise1 part55 side3 side6>
  30. <tap drill1 tap14 vise1 part55 hole1>
  31. <put-tool-on-milling-machine milling-machine1 end-mill1>
  32. <release-from-holding-device drill1 vise1 part55 side3 side6>
  33. <remove-holding-device-from-machine drill1 vise1>
  34. <put-holding-device-in-milling-machine milling-machine1 vise1>
  35. <remove-burrs part55 brush1>
  36. <clean part55>
  37. <put-on-machine-table milling-machine1 part55>
  38. <hold-with-vise milling-machine1 vise1 part55 side3 side6>
  39. <side-mill milling-machine1 part55 end-mill1 vise1 side2 side4 height 0.5>
  40. <release-from-holding-device milling-machine1 vise1 part55 side3 side6>
  41. <remove-burrs part55 brush1>
  42. <clean part55>
  43. <hold-with-vise milling-machine1 vise1 part55 side1 side4>
  44. <side-mill milling-machine1 part55 end-mill1 vise1 side6 side5 width 3>
  45. <face-mill milling-machine1 part55 end-mill1 vise1 side6 length 4>
|#