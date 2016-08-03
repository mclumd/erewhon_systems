;;adapted from Hayes' thesis

(setf (current-problem)
      (create-problem
       (name testpart3)
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
	 (size-of part51 HEIGHT 3)))
       (goal
	((<part> PART))
	(and 
	 (material-of <part> BRASS)
	 (size-of <part> LENGTH 3.25)
	 (size-of <part> WIDTH .5)
	 (size-of <part> HEIGHT 2.25)
	 
	 (is-tapped <part> hole1 side1 1 1/8 .5 .25)
	 (is-tapped <part> hole2 side1 1 1/8 2.25 .25)
	 (is-tapped <part> hole3 side6 3 1/8 .25 1.12)
	 
	 (has-hole <part> hole4 side4 1 1/4  2.25 .25)
	 (is-counterbored <part> hole4 side4 1 1/4  2.25 .25 3/8)))))

(setf (getf (p4::problem-space-plist *current-problem-space*)
	    :depth-bound) 1000)

#| with eff-rules.lisp
Solution:
  1. <put-in-drill-spindle drill1 spot-drill1>
  2. <put-holding-device-in-drill drill1 vise1>
  3. <clean part51>
  4. <put-on-machine-table drill1 part51>
  5. <hold-with-vise drill1 vise1 part51 side2-side5>
  6. <drill-with-spot-drill drill1 spot-drill1 vise1 part51 hole1 side1>
  7. <drill-with-spot-drill drill1 spot-drill1 vise1 part51 hole2 side1>
  8. <remove-tool-from-machine drill1 spot-drill1>
  9. <put-in-drill-spindle drill1 twist-drill5>
  10. <drill-with-twist-drill drill1 twist-drill5 vise1 part51 hole1 side1 1 1/8>
  11. <drill-with-twist-drill drill1 twist-drill5 vise1 part51 hole2 side1 1 1/8>
  12. <release-from-holding-device drill1 vise1 part51 side2-side5>
  13. <remove-burrs part51 brush1>
  14. <clean part51>
  15. <hold-with-vise drill1 vise1 part51 side1-side4>
  16. <remove-tool-from-machine drill1 twist-drill5>
  17. <put-in-drill-spindle drill1 spot-drill1>
  18. <drill-with-spot-drill drill1 spot-drill1 vise1 part51 hole3 side6>
  19. <remove-tool-from-machine drill1 spot-drill1>
  20. <put-in-drill-spindle drill1 twist-drill5>
  21. <drill-with-twist-drill drill1 twist-drill5 vise1 part51 hole3 side6 3 1/8>
  22. <release-from-holding-device drill1 vise1 part51 side1-side4>
  23. <remove-burrs part51 brush1>
  24. <remove-tool-from-machine drill1 twist-drill5>
  25. <put-in-drill-spindle drill1 spot-drill1>
  26. <clean part51>
  27. <hold-with-vise drill1 vise1 part51 side2-side5>
  28. <drill-with-spot-drill drill1 spot-drill1 vise1 part51 hole4 side4>
  29. <remove-tool-from-machine drill1 spot-drill1>
  30. <put-in-drill-spindle drill1 twist-drill13>
  31. <drill-with-twist-drill drill1 twist-drill13 vise1 part51 hole4 side4 1 1/4>
  32. <remove-tool-from-machine drill1 twist-drill13>
  33. <put-in-drill-spindle drill1 counterbore4>
  34. <release-from-holding-device drill1 vise1 part51 side2-side5>
  35. <remove-burrs part51 brush1>
  36. <clean part51>
  37. <hold-with-vise drill1 vise1 part51 side2-side5>
  38. <counterbore drill1 counterbore4 vise1 part51 hole4>
  39. <remove-tool-from-machine drill1 counterbore4>
  40. <put-in-drill-spindle drill1 tap6>
  41. <release-from-holding-device drill1 vise1 part51 side2-side5>
  42. <remove-burrs part51 brush1>
  43. <clean part51>
  44. <hold-with-vise drill1 vise1 part51 side1-side4>
  45. <tap drill1 tap6 vise1 part51 hole3>
  46. <release-from-holding-device drill1 vise1 part51 side1-side4>
  47. <remove-burrs part51 brush1>
  48. <clean part51>
  49. <hold-with-vise drill1 vise1 part51 side2-side5>
  50. <tap drill1 tap6 vise1 part51 hole2>
  51. <release-from-holding-device drill1 vise1 part51 side2-side5>
  52. <remove-burrs part51 brush1>
  53. <clean part51>
  54. <hold-with-vise drill1 vise1 part51 side2-side5>
  55. <tap drill1 tap6 vise1 part51 hole1>
  56. <put-tool-on-milling-machine milling-machine1 plain-mill1>
  57. <release-from-holding-device drill1 vise1 part51 side2-side5>
  58. <remove-holding-device-from-machine drill1 vise1>
  59. <put-holding-device-in-milling-machine milling-machine1 vise1>
  60. <remove-burrs part51 brush1>
  61. <clean part51>
  62. <put-on-machine-table milling-machine1 part51>
  63. <hold-with-vise milling-machine1 vise1 part51 side1-side4>
  64. <face-mill milling-machine1 part51 plain-mill1 vise1 side2 width 0.5>
  65. <release-from-holding-device milling-machine1 vise1 part51 side1-side4>
  66. <remove-burrs part51 brush1>
  67. <clean part51>
  68. <hold-with-vise milling-machine1 vise1 part51 side2-side5>
  69. <side-mill milling-machine1 part51 plain-mill1 vise1 side1 side6 length 3.25>
  70. <face-mill milling-machine1 part51 plain-mill1 vise1 side1 height 2.25>

compute-cost = 124


|#


#|without eff-rules.lisp
Solution:
  1. <put-tool-on-milling-machine milling-machine1 plain-mill1>
  2. <put-holding-device-in-milling-machine milling-machine1 vise1>
  3. <clean part51>
  4. <put-on-machine-table milling-machine1 part51>
  5. <hold-with-vise milling-machine1 vise1 part51 side2-side5>
  6. <face-mill milling-machine1 part51 plain-mill1 vise1 side3 length 3.25>
  7. <release-from-holding-device milling-machine1 vise1 part51 side2-side5>
  8. <remove-burrs part51 brush1>
  9. <clean part51>
  10. <hold-with-vise milling-machine1 vise1 part51 side3-side6>
  11. <face-mill milling-machine1 part51 plain-mill1 vise1 side2 width 0.5>
  12. <release-from-holding-device milling-machine1 vise1 part51 side3-side6>
  13. <remove-burrs part51 brush1>
  14. <clean part51>
  15. <hold-with-vise milling-machine1 vise1 part51 side3-side6>
  16. <face-mill milling-machine1 part51 plain-mill1 vise1 side1 height 2.25>
  17. <put-in-drill-spindle drill1 spot-drill1>
  18. <release-from-holding-device milling-machine1 vise1 part51 side3-side6>
  19. <remove-holding-device-from-machine milling-machine1 vise1>
  20. <put-holding-device-in-drill drill1 vise1>
  21. <remove-burrs part51 brush1>
  22. <clean part51>
  23. <put-on-machine-table drill1 part51>
  24. <hold-with-vise drill1 vise1 part51 side2-side5>
  25. <drill-with-spot-drill drill1 spot-drill1 vise1 part51 hole1 side1>
  26. <remove-tool-from-machine drill1 spot-drill1>
  27. <put-in-drill-spindle drill1 twist-drill5>
  28. <release-from-holding-device drill1 vise1 part51 side2-side5>
  29. <remove-burrs part51 brush1>
  30. <clean part51>
  31. <hold-with-vise drill1 vise1 part51 side3-side6>
  32. <drill-with-twist-drill drill1 twist-drill5 vise1 part51 hole1 side1 1 1/8>
  33. <remove-tool-from-machine drill1 twist-drill5>
  34. <put-in-drill-spindle drill1 tap6>
  35. <release-from-holding-device drill1 vise1 part51 side3-side6>
  36. <remove-burrs part51 brush1>
  37. <clean part51>
  38. <hold-with-vise drill1 vise1 part51 side2-side5>
  39. <tap drill1 tap6 vise1 part51 hole1>
  40. <remove-tool-from-machine drill1 tap6>
  41. <put-in-drill-spindle drill1 spot-drill1>
  42. <drill-with-spot-drill drill1 spot-drill1 vise1 part51 hole2 side1>
  43. <remove-tool-from-machine drill1 spot-drill1>
  44. <put-in-drill-spindle drill1 twist-drill5>
  45. <drill-with-twist-drill drill1 twist-drill5 vise1 part51 hole2 side1 1 1/8>
  46. <remove-tool-from-machine drill1 twist-drill5>
  47. <put-in-drill-spindle drill1 tap6>
  48. <release-from-holding-device drill1 vise1 part51 side2-side5>
  49. <remove-burrs part51 brush1>
  50. <clean part51>
  51. <hold-with-vise drill1 vise1 part51 side2-side5>
  52. <tap drill1 tap6 vise1 part51 hole2>
  53. <remove-tool-from-machine drill1 tap6>
  54. <put-in-drill-spindle drill1 spot-drill1>
  55. <release-from-holding-device drill1 vise1 part51 side2-side5>
  56. <remove-burrs part51 brush1>
  57. <clean part51>
  58. <hold-with-vise drill1 vise1 part51 side1-side4>
  59. <drill-with-spot-drill drill1 spot-drill1 vise1 part51 hole3 side6>
  60. <remove-tool-from-machine drill1 spot-drill1>
  61. <put-in-drill-spindle drill1 twist-drill5>
  62. <release-from-holding-device drill1 vise1 part51 side1-side4>
  63. <remove-burrs part51 brush1>
  64. <clean part51>
  65. <hold-with-vise drill1 vise1 part51 side2-side5>
  66. <drill-with-twist-drill drill1 twist-drill5 vise1 part51 hole3 side6 3 1/8>
  67. <remove-tool-from-machine drill1 twist-drill5>
  68. <put-in-drill-spindle drill1 tap6>
  69. <release-from-holding-device drill1 vise1 part51 side2-side5>
  70. <remove-burrs part51 brush1>
  71. <clean part51>
  72. <hold-with-vise drill1 vise1 part51 side1-side4>
  73. <tap drill1 tap6 vise1 part51 hole3>
  74. <remove-tool-from-machine drill1 tap6>
  75. <put-in-drill-spindle drill1 spot-drill1>
  76. <release-from-holding-device drill1 vise1 part51 side1-side4>
  77. <remove-burrs part51 brush1>
  78. <clean part51>
  79. <hold-with-vise drill1 vise1 part51 side2-side5>
  80. <drill-with-spot-drill drill1 spot-drill1 vise1 part51 hole4 side4>
  81. <remove-tool-from-machine drill1 spot-drill1>
  82. <put-in-drill-spindle drill1 twist-drill13>
  83. <release-from-holding-device drill1 vise1 part51 side2-side5>
  84. <remove-burrs part51 brush1>
  85. <clean part51>
  86. <hold-with-vise drill1 vise1 part51 side3-side6>
  87. <drill-with-twist-drill drill1 twist-drill13 vise1 part51 hole4 side4 1 1/4>
  88. <remove-tool-from-machine drill1 twist-drill13>
  89. <put-in-drill-spindle drill1 counterbore4>
  90. <release-from-holding-device drill1 vise1 part51 side3-side6>
  91. <remove-burrs part51 brush1>
  92. <clean part51>
  93. <hold-with-vise drill1 vise1 part51 side3-side6>
  94. <counterbore drill1 counterbore4 vise1 part51 hole4>

compute-cost = 164
|#