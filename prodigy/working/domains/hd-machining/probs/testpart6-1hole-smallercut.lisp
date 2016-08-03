;;from Caroline Hayes' thesis, appendix C

(setf (current-problem)
      (create-problem
       (name testpart6-1hole-smallercut)
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

        (objects-are ;part5
	              part55 PART)
	(object-is hole1 HOLE))
       (state
	(and
	 (always-true)
	 (diameter-of-drill-bit twist-drill13 1/4)
	 (diameter-of-drill-bit tap14 1/4)
	 (size-of-drill-bit counterbore2 1/2)
	 (diameter-of-drill-bit high-helix-drill1 1/32)
	 (diameter-of-drill-bit tap1 1/32)
;	 (material-of part5 ALUMINUM)
;	 (size-of part5 LENGTH 5)
;	 (size-of part5 WIDTH 3)
;        (size-of part5 HEIGHT 3)
;         (material-of part55 ALUMINUM)
;         (size-of part55 LENGTH 5)
;         (size-of part55 WIDTH 4)
;         (size-of part55 HEIGHT 2)
	 (material-of part55 ALUMINUM)
	 (size-of part55 LENGTH 5)
	 (size-of part55 WIDTH 3)
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
	 ))))


#| with eff-rules.lisp
Solution:
  1. <put-in-drill-spindle drill1 spot-drill1>
  2. <put-holding-device-in-drill drill1 vise1>
  3. <clean part55>
  4. <put-on-machine-table drill1 part55>
  5. <hold-with-vise drill1 vise1 part55 side2-side5>
  6. <drill-with-spot-drill drill1 spot-drill1 vise1 part55 hole1 side1>
  7. <remove-tool-from-machine drill1 spot-drill1>
  8. <put-in-drill-spindle drill1 twist-drill13>
  9. <drill-with-twist-drill drill1 twist-drill13 vise1 part55 hole1 side1 0.5 1/4>
  10. <remove-tool-from-machine drill1 twist-drill13>
  11. <put-in-drill-spindle drill1 counterbore2>
  12. <release-from-holding-device drill1 vise1 part55 side2-side5>
  13. <remove-burrs part55 brush1>
  14. <clean part55>
  15. <hold-with-vise drill1 vise1 part55 side2-side5>
  16. <counterbore drill1 counterbore2 vise1 part55 hole1>
  17. <remove-tool-from-machine drill1 counterbore2>
  18. <put-in-drill-spindle drill1 tap14>
  19. <release-from-holding-device drill1 vise1 part55 side2-side5>
  20. <remove-burrs part55 brush1>
  21. <clean part55>
  22. <hold-with-vise drill1 vise1 part55 side2-side5>
  23. <tap drill1 tap14 vise1 part55 hole1>
  24. <put-tool-on-milling-machine milling-machine1 plain-mill1>
  25. <release-from-holding-device drill1 vise1 part55 side2-side5>
  26. <remove-holding-device-from-machine drill1 vise1>
  27. <put-holding-device-in-milling-machine milling-machine1 vise1>
  28. <remove-burrs part55 brush1>
  29. <clean part55>
  30. <put-on-machine-table milling-machine1 part55>
  31. <hold-with-vise milling-machine1 vise1 part55 side2-side5>
  32. <side-mill milling-machine1 part55 plain-mill1 vise1 side1 side6 length 4>
  33. <face-mill milling-machine1 part55 plain-mill1 vise1 side1 height 0.5>

|#