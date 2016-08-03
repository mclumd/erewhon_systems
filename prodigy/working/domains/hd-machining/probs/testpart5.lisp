;;adapted from Hayes' testpart5.lisp

(setf (current-problem)
      (create-problem
       (name testpart5)
       (objects
	(object-is drill1 DRILL)
        (object-is milling-machine1 MILLING-MACHINE)

        (object-is vise1 VISE)

	(object-is spot-drill1 SPOT-DRILL)
	(object-is twist-drill13 TWIST-DRILL)
	(object-is tap14 TAP)
	(object-is counterbore1 COUNTERBORE)	
	(object-is high-helix-drill1 HIGH-HELIX-DRILL)
	(object-is plain-mill1 PLAIN-MILL)
	(object-is end-mill1 END-MILL)
	
	(object-is brush1 BRUSH)
	(object-is soluble-oil SOLUBLE-OIL)
	(object-is mineral-oil MINERAL-OIL)

        (object-is part6 PART)
	(objects-are hole1 hole2 HOLE))
       (state
	(and
	 (always-true)
	 (diameter-of-drill-bit high-helix-drill1 1/32)
	 (diameter-of-drill-bit twist-drill13 1/4)
	 (size-of-drill-bit counterbore1 1/4)
	 (diameter-of-drill-bit tap14 1/4)

	 (material-of part6 STEEL)
	 (size-of part6 LENGTH 5)
	 (size-of part6 WIDTH 3)
	 (size-of part6 HEIGHT 3)))
       (goal
	((<part> PART))
	(and
	 (material-of <part> STEEL)
	 (size-of <part> LENGTH 4.25)
	 (size-of <part> WIDTH 1.25)
	 (size-of <part> HEIGHT 1)
	 
	 (is-counterbored <part> hole1 side1 1/4  1/32 3/4 5/8 1/4)
	 (is-tapped <part> hole2 side1 1 1/4 57/16 5/8)
	 ))))

#| with eff-rules.lisp
Solution:
  1. <put-in-drill-spindle drill1 spot-drill1>
  2. <put-holding-device-in-drill drill1 vise1>
  3. <clean part6>
  4. <put-on-machine-table drill1 part6>
  5. <hold-with-vise drill1 vise1 part6 side2-side5>
  6. <drill-with-spot-drill drill1 spot-drill1 vise1 part6 hole1 side1>
  7. <drill-with-spot-drill drill1 spot-drill1 vise1 part6 hole2 side1>
  8. <add-soluble-oil drill1 soluble-oil>
  9. <remove-tool-from-machine drill1 spot-drill1>
  10. <put-in-drill-spindle drill1 high-helix-drill1>
  11. <drill-with-high-helix-drill drill1 high-helix-drill1 vise1 part6 hole1 side1 1/4 1/32>
  12. <remove-tool-from-machine drill1 high-helix-drill1>
  13. <put-in-drill-spindle drill1 twist-drill13>
  14. <drill-with-twist-drill drill1 twist-drill13 vise1 part6 hole2 side1 1 1/4>
  15. <remove-tool-from-machine drill1 twist-drill13>
  16. <put-in-drill-spindle drill1 tap14>
  17. <release-from-holding-device drill1 vise1 part6 side2-side5>
  18. <remove-burrs part6 brush1>
  19. <clean part6>
  20. <hold-with-vise drill1 vise1 part6 side2-side5>
  21. <tap drill1 tap14 vise1 part6 hole2>
  22. <remove-tool-from-machine drill1 tap14>
  23. <put-in-drill-spindle drill1 counterbore1>
  24. <release-from-holding-device drill1 vise1 part6 side2-side5>
  25. <remove-burrs part6 brush1>
  26. <clean part6>
  27. <hold-with-vise drill1 vise1 part6 side2-side5>
  28. <counterbore drill1 counterbore1 vise1 part6 hole1>
  29. <put-tool-on-milling-machine milling-machine1 plain-mill1>
  30. <release-from-holding-device drill1 vise1 part6 side2-side5>
  31. <remove-holding-device-from-machine drill1 vise1>
  32. <put-holding-device-in-milling-machine milling-machine1 vise1>
  33. <remove-burrs part6 brush1>
  34. <clean part6>
  35. <put-on-machine-table milling-machine1 part6>
  36. <hold-with-vise milling-machine1 vise1 part6 side1-side4>
  37. <face-mill milling-machine1 part6 plain-mill1 vise1 side2 width 1.25>
  38. <release-from-holding-device milling-machine1 vise1 part6 side1-side4>
  39. <remove-burrs part6 brush1>
  40. <clean part6>
  41. <hold-with-vise milling-machine1 vise1 part6 side2-side5>
  42. <side-mill milling-machine1 part6 plain-mill1 vise1 side1 side6 length 4.25>
  43. <face-mill milling-machine1 part6 plain-mill1 vise1 side1 height 1>

compute-cost = 75
|#

#| without eff-rules.lisp
Solution:
  1. <put-tool-on-milling-machine milling-machine1 plain-mill1>
  2. <put-holding-device-in-milling-machine milling-machine1 vise1>
  3. <clean part6>
  4. <put-on-machine-table milling-machine1 part6>
  5. <hold-with-vise milling-machine1 vise1 part6 side2-side5>
  6. <face-mill milling-machine1 part6 plain-mill1 vise1 side3 length 4.25>
  7. <release-from-holding-device milling-machine1 vise1 part6 side2-side5>
  8. <remove-burrs part6 brush1>
  9. <clean part6>
  10. <hold-with-vise milling-machine1 vise1 part6 side3-side6>
  11. <face-mill milling-machine1 part6 plain-mill1 vise1 side2 width 1.25>
  12. <release-from-holding-device milling-machine1 vise1 part6 side3-side6>
  13. <remove-burrs part6 brush1>
  14. <clean part6>
  15. <hold-with-vise milling-machine1 vise1 part6 side3-side6>
  16. <face-mill milling-machine1 part6 plain-mill1 vise1 side1 height 1>
  17. <add-soluble-oil drill1 soluble-oil>
  18. <put-in-drill-spindle drill1 spot-drill1>
  19. <release-from-holding-device milling-machine1 vise1 part6 side3-side6>
  20. <remove-holding-device-from-machine milling-machine1 vise1>
  21. <put-holding-device-in-drill drill1 vise1>
  22. <remove-burrs part6 brush1>
  23. <clean part6>
  24. <put-on-machine-table drill1 part6>
  25. <hold-with-vise drill1 vise1 part6 side2-side5>
  26. <drill-with-spot-drill drill1 spot-drill1 vise1 part6 hole1 side1>
  27. <remove-tool-from-machine drill1 spot-drill1>
  28. <put-in-drill-spindle drill1 high-helix-drill1>
  29. <drill-with-high-helix-drill drill1 high-helix-drill1 vise1 part6 hole1 side1 1/4 1/32>
  30. <remove-tool-from-machine drill1 high-helix-drill1>
  31. <put-in-drill-spindle drill1 counterbore1>
  32. <release-from-holding-device drill1 vise1 part6 side2-side5>
  33. <remove-burrs part6 brush1>
  34. <clean part6>
  35. <hold-with-vise drill1 vise1 part6 side2-side5>
  36. <counterbore drill1 counterbore1 vise1 part6 hole1>
  37. <remove-tool-from-machine drill1 counterbore1>
  38. <put-in-drill-spindle drill1 spot-drill1>
  39. <drill-with-spot-drill drill1 spot-drill1 vise1 part6 hole2 side1>
  40. <remove-tool-from-machine drill1 spot-drill1>
  41. <put-in-drill-spindle drill1 twist-drill13>
  42. <drill-with-twist-drill drill1 twist-drill13 vise1 part6 hole2 side1 1 1/4>
  43. <remove-tool-from-machine drill1 twist-drill13>
  44. <put-in-drill-spindle drill1 tap14>
  45. <release-from-holding-device drill1 vise1 part6 side2-side5>
  46. <remove-burrs part6 brush1>
  47. <clean part6>
  48. <hold-with-vise drill1 vise1 part6 side2-side5>
  49. <tap drill1 tap14 vise1 part6 hole2>

|#