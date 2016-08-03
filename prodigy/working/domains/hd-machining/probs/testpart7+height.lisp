;;from Caroline Hayes' thesis, appendix C
;;modified height goal so both side-mill and face-mill can be used for
;;it
(setf (current-problem)
      (create-problem
       (name testpart7+height)
       (objects
	(object-is milling-machine1 MILLING-MACHINE)
	(object-is drill1 DRILL)

	(object-is spot-drill1 SPOT-DRILL)
	(object-is twist-drill6 TWIST-DRILL)
	(object-is plain-mill1 PLAIN-MILL)
	(object-is end-mill1 END-MILL)

	(object-is vise1 VISE)

	(object-is brush1 BRUSH)
	(object-is soluble-oil SOLUBLE-OIL)
	(object-is mineral-oil MINERAL-OIL)

        (object-is part5 PART)
	(objects-are hole1 hole2 HOLE))
       (state
	(and
	 (always-true)
	 (diameter-of-drill-bit twist-drill6 9/64)
	 (material-of part5 ALUMINUM)
	 (size-of part5 LENGTH 5)
	 (size-of part5 WIDTH 3)
	 (size-of part5 HEIGHT 3)))
       (goal
	((<part> PART))
	(and
	 (size-of <part> LENGTH 4)
	 (size-of <part> WIDTH 2)
	 (size-of <part> HEIGHT 2)

	 (has-hole <part> hole1 side1 0.3 9/64 1.375 0.25)
	 (has-hole <part> hole2 side1 0.3 9/64 2.42 0.25)
	 ))))

#|Solution:
  1. <put-tool-on-milling-machine milling-machine1 spot-drill1>
  2. <put-holding-device-in-milling-machine milling-machine1 vise1>
  3. <clean part5>
  4. <put-on-machine-table milling-machine1 part5>
  5. <hold-with-vise milling-machine1 vise1 part5 side3-side6>
  6. <drill-with-spot-drill-in-milling-machine milling-machine1 spot-drill1 vise1 part5 hole2 side1>
  7. <drill-with-spot-drill-in-milling-machine milling-machine1 spot-drill1 vise1 part5 hole1 side1>
  8. <remove-tool-from-machine milling-machine1 spot-drill1>
  9. <put-tool-on-milling-machine milling-machine1 twist-drill6>
  10. <drill-with-twist-drill-in-milling-machine milling-machine1 twist-drill6 vise1 part5 hole2 side1 0.3 9/64>
  11. <drill-with-twist-drill-in-milling-machine milling-machine1 twist-drill6 vise1 part5 hole1 side1 0.3 9/64>
  12. <remove-tool-from-machine milling-machine1 twist-drill6>
  13. <put-tool-on-milling-machine milling-machine1 plain-mill1>
  14. <side-mill milling-machine1 part5 plain-mill1 vise1 side1 side5 width 2>
  15. <face-mill milling-machine1 part5 plain-mill1 vise1 side1 height 2>
  16. <release-from-holding-device milling-machine1 vise1 part5 side3-side6>
  17. <remove-burrs part5 brush1>
  18. <clean part5>
  19. <hold-with-vise milling-machine1 vise1 part5 side2-side5>
  20. <face-mill milling-machine1 part5 plain-mill1 vise1 side3 length 4>

|#

#|with only sc-rules.lisp
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
  11. <face-mill milling-machine1 part5 plain-mill1 vise1 side2 width 2>
  12. <release-from-holding-device milling-machine1 vise1 part5 side3-side6>
  13. <remove-burrs part5 brush1>
  14. <clean part5>
  15. <hold-with-vise milling-machine1 vise1 part5 side3-side6>
  16. <face-mill milling-machine1 part5 plain-mill1 vise1 side1 height 2>
  17. <put-in-drill-spindle drill1 spot-drill1>
  18. <release-from-holding-device milling-machine1 vise1 part5 side3-side6>
  19. <remove-holding-device-from-machine milling-machine1 vise1>
  20. <put-holding-device-in-drill drill1 vise1>
  21. <remove-burrs part5 brush1>
  22. <clean part5>
  23. <put-on-machine-table drill1 part5>
  24. <hold-with-vise drill1 vise1 part5 side2-side5>
  25. <drill-with-spot-drill drill1 spot-drill1 vise1 part5 hole1 side1>
  26. <remove-tool-from-machine drill1 spot-drill1>
  27. <put-in-drill-spindle drill1 twist-drill6>
  28. <release-from-holding-device drill1 vise1 part5 side2-side5>
  29. <remove-burrs part5 brush1>
  30. <clean part5>
  31. <hold-with-vise drill1 vise1 part5 side3-side6>
  32. <drill-with-twist-drill drill1 twist-drill6 vise1 part5 hole1 side1 0.3 9/64>
  33. <remove-tool-from-machine drill1 twist-drill6>
  34. <put-in-drill-spindle drill1 spot-drill1>
  35. <drill-with-spot-drill drill1 spot-drill1 vise1 part5 hole2 side1>
  36. <remove-tool-from-machine drill1 spot-drill1>
  37. <put-in-drill-spindle drill1 twist-drill6>
  38. <drill-with-twist-drill drill1 twist-drill6 vise1 part5 hole2 side1 0.3 9/64>
|#