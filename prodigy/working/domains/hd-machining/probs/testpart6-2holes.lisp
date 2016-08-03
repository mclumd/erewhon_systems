;;from Caroline Hayes' thesis, appendix C

;;adapted from testpart6.lisp. Only two holes, of different sizes (one
;;twist-drilled and the other high-helix-drilled)

(setf (current-problem)
      (create-problem
       (name testpart6-2holes)
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
	(objects-are hole1 hole5  HOLE))
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
	 (material-of part55 ALUMINUM)
	 (size-of part55 LENGTH 5)
	 (size-of part55 WIDTH 4)
	 (size-of part55 HEIGHT 2)))
       (goal
	((<part> PART))
	(and 
	 (material-of <part> ALUMINUM)
	 (size-of <part> LENGTH 4)
	 (size-of <part> WIDTH 3)
	 (size-of <part> HEIGHT 0.5)

	 (is-tapped <part> hole1 side1 .5 1/4 1/2 1.5)
	 (is-counterbored <part> hole1 side1 .5 1/4 1/2 1.5 1/2)

	 (is-tapped <part> hole5 side1 .5 1/32 1.125 0.242)
	 ))))

(setf (getf (p4::problem-space-plist *current-problem-space*)
	    :depth-bound) 1000)

#| with eff-rules.lisp

267   n278 <FACE-MILL MILLING-MACHINE1 PART5 PLAIN-MILL1 VISE1 SIDE1 HEIGHT 0.5>
Solution:
  1. <put-in-drill-spindle drill1 spot-drill1>
  2. <put-holding-device-in-drill drill1 vise1>
  3. <clean part5>
  4. <put-on-machine-table drill1 part5>
  5. <hold-with-vise drill1 vise1 part5 side2-side5>
  6. <drill-with-spot-drill drill1 spot-drill1 vise1 part5 hole1 side1>
  7. <drill-with-spot-drill drill1 spot-drill1 vise1 part5 hole5 side1>
  8. <remove-tool-from-machine drill1 spot-drill1>
  9. <put-in-drill-spindle drill1 twist-drill13>
  10. <drill-with-twist-drill drill1 twist-drill13 vise1 part5 hole1 side1 0.5 1/4>
  11. <add-soluble-oil drill1 soluble-oil>
  12. <remove-tool-from-machine drill1 twist-drill13>
  13. <put-in-drill-spindle drill1 high-helix-drill1>
  14. <drill-with-high-helix-drill drill1 high-helix-drill1 vise1 part5 hole5 side1 0.5 1/32>
  15. <remove-tool-from-machine drill1 high-helix-drill1>
  16. <put-in-drill-spindle drill1 tap1>
  17. <release-from-holding-device drill1 vise1 part5 side2-side5>
  18. <remove-burrs part5 brush1>
  19. <clean part5>
  20. <hold-with-vise drill1 vise1 part5 side2-side5>
  21. <tap drill1 tap1 vise1 part5 hole5>
  22. <remove-tool-from-machine drill1 tap1>
  23. <put-in-drill-spindle drill1 counterbore2>
  24. <release-from-holding-device drill1 vise1 part5 side2-side5>
  25. <remove-burrs part5 brush1>
  26. <clean part5>
  27. <hold-with-vise drill1 vise1 part5 side2-side5>
  28. <counterbore drill1 counterbore2 vise1 part5 hole1>
  29. <remove-tool-from-machine drill1 counterbore2>
  30. <put-in-drill-spindle drill1 tap14>
  31. <release-from-holding-device drill1 vise1 part5 side2-side5>
  32. <remove-burrs part5 brush1>
  33. <clean part5>
  34. <hold-with-vise drill1 vise1 part5 side2-side5>
  35. <tap drill1 tap14 vise1 part5 hole1>
  36. <put-tool-on-milling-machine milling-machine1 plain-mill1>
  37. <release-from-holding-device drill1 vise1 part5 side2-side5>
  38. <remove-holding-device-from-machine drill1 vise1>
  39. <put-holding-device-in-milling-machine milling-machine1 vise1>
  40. <remove-burrs part5 brush1>
  41. <clean part5>
  42. <put-on-machine-table milling-machine1 part5>
  43. <hold-with-vise milling-machine1 vise1 part5 side2-side5>
  44. <side-mill milling-machine1 part5 plain-mill1 vise1 side1 side6 length 4>
  45. <face-mill milling-machine1 part5 plain-mill1 vise1 side1 height 0.5>

|#

#| with only sc-rules.lisp
316   n328 <TAP DRILL1 TAP1 VISE1 PART5 HOLE5>
Solution:
  1. <put-tool-on-milling-machine milling-machine1 plain-mill1>
  2. <put-holding-device-in-milling-machine milling-machine1 vise1>
  3. <clean part5>
  4. <put-on-machine-table milling-machine1 part5>
  5. <hold-with-vise milling-machine1 vise1 part5 side2-side5>
  6. <face-mill milling-machine1 part5 plain-mill1 vise1 side3 length 4>
  7. <release-from-holding-device milling-machine1 vise1 part5 side2-side5>
  8. <remove-burrs part5 brush1>
  9. <clean part5>
  10. <hold-with-vise milling-machine1 vise1 part5 side3-side6>
  11. <face-mill milling-machine1 part5 plain-mill1 vise1 side1 height 0.5>
  12. <put-in-drill-spindle drill1 spot-drill1>
  13. <release-from-holding-device milling-machine1 vise1 part5 side3-side6>
  14. <remove-holding-device-from-machine milling-machine1 vise1>
  15. <put-holding-device-in-drill drill1 vise1>
  16. <remove-burrs part5 brush1>
  17. <clean part5>
  18. <put-on-machine-table drill1 part5>
  19. <hold-with-vise drill1 vise1 part5 side2-side5>
  20. <drill-with-spot-drill drill1 spot-drill1 vise1 part5 hole1 side1>
  21. <remove-tool-from-machine drill1 spot-drill1>
  22. <put-in-drill-spindle drill1 twist-drill13>
  23. <release-from-holding-device drill1 vise1 part5 side2-side5>
  24. <remove-burrs part5 brush1>
  25. <clean part5>
  26. <hold-with-vise drill1 vise1 part5 side3-side6>
  27. <drill-with-twist-drill drill1 twist-drill13 vise1 part5 hole1 side1 0.5 1/4>
  28. <remove-tool-from-machine drill1 twist-drill13>
  29. <put-in-drill-spindle drill1 tap14>
  30. <release-from-holding-device drill1 vise1 part5 side3-side6>
  31. <remove-burrs part5 brush1>
  32. <clean part5>
  33. <hold-with-vise drill1 vise1 part5 side2-side5>
  34. <tap drill1 tap14 vise1 part5 hole1>
  35. <remove-tool-from-machine drill1 tap14>
  36. <put-in-drill-spindle drill1 counterbore2>
  37. <release-from-holding-device drill1 vise1 part5 side2-side5>
  38. <remove-burrs part5 brush1>
  39. <clean part5>
  40. <hold-with-vise drill1 vise1 part5 side2-side5>
  41. <counterbore drill1 counterbore2 vise1 part5 hole1>
  42. <add-soluble-oil drill1 soluble-oil>
  43. <remove-tool-from-machine drill1 counterbore2>
  44. <put-in-drill-spindle drill1 spot-drill1>
  45. <drill-with-spot-drill drill1 spot-drill1 vise1 part5 hole5 side1>
  46. <remove-tool-from-machine drill1 spot-drill1>
  47. <put-in-drill-spindle drill1 high-helix-drill1>
  48. <drill-with-high-helix-drill drill1 high-helix-drill1 vise1 part5 hole5 side1 0.5 1/32>
  49. <remove-tool-from-machine drill1 high-helix-drill1>
  50. <put-in-drill-spindle drill1 tap1>
  51. <release-from-holding-device drill1 vise1 part5 side2-side5>
  52. <remove-burrs part5 brush1>
  53. <clean part5>
  54. <hold-with-vise drill1 vise1 part5 side2-side5>
  55. <tap drill1 tap1 vise1 part5 hole5>
|#