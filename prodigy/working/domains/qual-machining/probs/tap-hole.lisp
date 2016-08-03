;;adapted from testpart6

(setf (current-problem)
      (create-problem
       (name tap-hole)
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

        (object-is part5 PART)
	(object-is hole1 HOLE))
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
	 (size-of part5 HEIGHT 3)))
       (goal
	((<part> PART))
	(and 
	 (size-of <part> HEIGHT 0.5)

	 (is-tapped <part> hole1 side1 .5 1/4 1/2 1.5)
	 (is-counterbored <part> hole1 side1 .5 1/4 1/2 1.5 1/2)
	 ))))

#| with eff-rules.lisp

Solution:
  1. <put-in-drill-spindle drill1 spot-drill1>
  2. <put-holding-device-in-drill drill1 vise1>
  3. <clean part5>
  4. <put-on-machine-table drill1 part5>
  5. <hold-with-vise drill1 vise1 part5 side2-side5>
  6. <drill-with-spot-drill drill1 spot-drill1 vise1 part5 hole1 side1>
  7. <remove-tool-from-machine drill1 spot-drill1>
  8. <put-in-drill-spindle drill1 twist-drill13>
  9. <drill-with-twist-drill drill1 twist-drill13 vise1 part5 hole1 side1 0.5 1/4>
  10. <remove-tool-from-machine drill1 twist-drill13>
  11. <put-in-drill-spindle drill1 counterbore2>
  12. <release-from-holding-device drill1 vise1 part5 side2-side5>
  13. <remove-burrs part5 brush1>
  14. <clean part5>
  15. <hold-with-vise drill1 vise1 part5 side2-side5>
  16. <counterbore drill1 counterbore2 vise1 part5 hole1>
  17. <remove-tool-from-machine drill1 counterbore2>
  18. <put-in-drill-spindle drill1 tap14>
  19. <release-from-holding-device drill1 vise1 part5 side2-side5>
  20. <remove-burrs part5 brush1>
  21. <clean part5>
  22. <hold-with-vise drill1 vise1 part5 side2-side5>
  23. <tap drill1 tap14 vise1 part5 hole1>
  24. <put-tool-on-milling-machine milling-machine1 plain-mill1>
  25. <release-from-holding-device drill1 vise1 part5 side2-side5>
  26. <remove-holding-device-from-machine drill1 vise1>
  27. <put-holding-device-in-milling-machine milling-machine1 vise1>
  28. <remove-burrs part5 brush1>
  29. <clean part5>
  30. <put-on-machine-table milling-machine1 part5>
  31. <hold-with-vise milling-machine1 vise1 part5 side3-side6>
  32. <face-mill milling-machine1 part5 plain-mill1 vise1 side1 height 0.5>

compute-cost = 56
|#
#|without eff-rules.lisp
Solution:
  1. <put-tool-on-milling-machine milling-machine1 plain-mill1>
  2. <put-holding-device-in-milling-machine milling-machine1 vise1>
  3. <clean part5>
  4. <put-on-machine-table milling-machine1 part5>
  5. <hold-with-vise milling-machine1 vise1 part5 side3-side6>
  6. <face-mill milling-machine1 part5 plain-mill1 vise1 side1 height 0.5>
  7. <put-in-drill-spindle drill1 spot-drill1>
  8. <release-from-holding-device milling-machine1 vise1 part5 side3-side6>
  9. <remove-holding-device-from-machine milling-machine1 vise1>
  10. <put-holding-device-in-drill drill1 vise1>
  11. <remove-burrs part5 brush1>
  12. <clean part5>
  13. <put-on-machine-table drill1 part5>
  14. <hold-with-vise drill1 vise1 part5 side2-side5>
  15. <drill-with-spot-drill drill1 spot-drill1 vise1 part5 hole1 side1>
  16. <remove-tool-from-machine drill1 spot-drill1>
  17. <put-in-drill-spindle drill1 twist-drill13>
  18. <release-from-holding-device drill1 vise1 part5 side2-side5>
  19. <remove-burrs part5 brush1>
  20. <clean part5>
  21. <hold-with-vise drill1 vise1 part5 side3-side6>
  22. <drill-with-twist-drill drill1 twist-drill13 vise1 part5 hole1 side1 0.5 1/4>
  23. <remove-tool-from-machine drill1 twist-drill13>
  24. <put-in-drill-spindle drill1 tap14>
  25. <release-from-holding-device drill1 vise1 part5 side3-side6>
  26. <remove-burrs part5 brush1>
  27. <clean part5>
  28. <hold-with-vise drill1 vise1 part5 side2-side5>
  29. <tap drill1 tap14 vise1 part5 hole1>
  30. <remove-tool-from-machine drill1 tap14>
  31. <put-in-drill-spindle drill1 counterbore2>
  32. <release-from-holding-device drill1 vise1 part5 side2-side5>
  33. <remove-burrs part5 brush1>
  34. <clean part5>
  35. <hold-with-vise drill1 vise1 part5 side2-side5>
  36. <counterbore drill1 counterbore2 vise1 part5 hole1>

compute-cost = 64
|#