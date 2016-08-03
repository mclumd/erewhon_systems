;;from Caroline Hayes' thesis, appendix C

(setf (current-problem)
      (create-problem
       (name testpart6)
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
	(objects-are hole1 hole2 hole3 hole4 hole5 hole6 hole7 hole8
		     hole9 hole10 hole11 hole12 HOLE))
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

	 (is-tapped <part> hole2 side1 .5 1/4 1/2 2.5)
	 (is-counterbored <part> hole2 side1 .5 1/4 1/2 2.5 1/2)

	 (is-tapped <part> hole3 side1 .5 1/4 3.5 1.5)
	 (is-counterbored <part> hole3 side1 .5 1/4 3.5 1.5 1/2)

	 (is-tapped <part> hole4 side1 .5 1/4 3.5 2.5)
	 (is-counterbored <part> hole4 side1 .5 1/4 3.5 2.5 1/2)

	 (is-tapped <part> hole5 side1 .5 1/32 1.125 0.242)

	 (is-tapped <part> hole6 side1 .5 1/32 1.125 1.258)

	 (is-tapped <part> hole7 side1 .5 1/32 1.125 1.742)

	 (is-tapped <part> hole8 side1 .5 1/32 1.125 2.753) ;

	 (is-tapped <part> hole9 side1 .5 1/32 2.875 0.242)

	 (is-tapped <part> hole10 side1 .5 1/32 2.875 1.258)

	 (is-tapped <part> hole11 side1 .5 1/32 2.875 1.742)

	 (is-tapped <part> hole12 side1 .5 1/32 2.875 2.753)
	 ))))

(setf (getf (p4::problem-space-plist *current-problem-space*)
	    :depth-bound) 1000)

#|
Solution:
  1. <put-in-drill-spindle drill1 spot-drill1>
  2. <put-holding-device-in-drill drill1 vise1>
  3. <clean part5>
  4. <put-on-machine-table drill1 part5>
  5. <hold-with-vise drill1 vise1 part5 side2-side5>
  6. <drill-with-spot-drill drill1 spot-drill1 vise1 part5 hole1 side1>
  7. <drill-with-spot-drill drill1 spot-drill1 vise1 part5 hole2 side1>
  8. <drill-with-spot-drill drill1 spot-drill1 vise1 part5 hole3 side1>
  9. <drill-with-spot-drill drill1 spot-drill1 vise1 part5 hole4 side1>
  10. <drill-with-spot-drill drill1 spot-drill1 vise1 part5 hole5 side1>
  11. <drill-with-spot-drill drill1 spot-drill1 vise1 part5 hole6 side1>
  12. <drill-with-spot-drill drill1 spot-drill1 vise1 part5 hole7 side1>
  13. <drill-with-spot-drill drill1 spot-drill1 vise1 part5 hole8 side1>
  14. <drill-with-spot-drill drill1 spot-drill1 vise1 part5 hole9 side1>
  15. <drill-with-spot-drill drill1 spot-drill1 vise1 part5 hole10 side1>
  16. <drill-with-spot-drill drill1 spot-drill1 vise1 part5 hole11 side1>
  17. <drill-with-spot-drill drill1 spot-drill1 vise1 part5 hole12 side1>
  18. <remove-tool-from-machine drill1 spot-drill1>
  19. <put-in-drill-spindle drill1 twist-drill13>
  20. <drill-with-twist-drill drill1 twist-drill13 vise1 part5 hole1 side1 0.5 1/4>
  21. <drill-with-twist-drill drill1 twist-drill13 vise1 part5 hole2 side1 0.5 1/4>
  22. <drill-with-twist-drill drill1 twist-drill13 vise1 part5 hole3 side1 0.5 1/4>
  23. <drill-with-twist-drill drill1 twist-drill13 vise1 part5 hole4 side1 0.5 1/4>
  24. <add-soluble-oil drill1 soluble-oil>
  25. <remove-tool-from-machine drill1 twist-drill13>
  26. <put-in-drill-spindle drill1 high-helix-drill1>
  27. <drill-with-high-helix-drill drill1 high-helix-drill1 vise1 part5 hole5 side1 0.5 1/32>
  28. <drill-with-high-helix-drill drill1 high-helix-drill1 vise1 part5 hole6 side1 0.5 1/32>
  29. <drill-with-high-helix-drill drill1 high-helix-drill1 vise1 part5 hole7 side1 0.5 1/32>
  30. <drill-with-high-helix-drill drill1 high-helix-drill1 vise1 part5 hole8 side1 0.5 1/32>
  31. <drill-with-high-helix-drill drill1 high-helix-drill1 vise1 part5 hole9 side1 0.5 1/32>
  32. <drill-with-high-helix-drill drill1 high-helix-drill1 vise1 part5 hole10 side1 0.5 1/32>
  33. <drill-with-high-helix-drill drill1 high-helix-drill1 vise1 part5 hole11 side1 0.5 1/32>
  34. <drill-with-high-helix-drill drill1 high-helix-drill1 vise1 part5 hole12 side1 0.5 1/32>
  35. <remove-tool-from-machine drill1 high-helix-drill1>
  36. <put-in-drill-spindle drill1 tap1>
  37. <release-from-holding-device drill1 vise1 part5 side2-side5>
  38. <remove-burrs part5 brush1>
  39. <clean part5>
  40. <hold-with-vise drill1 vise1 part5 side2-side5>
  41. <tap drill1 tap1 vise1 part5 hole12>
  42. <release-from-holding-device drill1 vise1 part5 side2-side5>
  43. <remove-burrs part5 brush1>
  44. <clean part5>
  45. <hold-with-vise drill1 vise1 part5 side2-side5>
  46. <tap drill1 tap1 vise1 part5 hole11>
  47. <release-from-holding-device drill1 vise1 part5 side2-side5>
  48. <remove-burrs part5 brush1>
  49. <clean part5>
  50. <hold-with-vise drill1 vise1 part5 side2-side5>
  51. <tap drill1 tap1 vise1 part5 hole10>
  52. <release-from-holding-device drill1 vise1 part5 side2-side5>
  53. <remove-burrs part5 brush1>
  54. <clean part5>
  55. <hold-with-vise drill1 vise1 part5 side2-side5>
  56. <tap drill1 tap1 vise1 part5 hole9>
  57. <release-from-holding-device drill1 vise1 part5 side2-side5>
  58. <remove-burrs part5 brush1>
  59. <clean part5>
  60. <hold-with-vise drill1 vise1 part5 side2-side5>
  61. <tap drill1 tap1 vise1 part5 hole8>
  62. <release-from-holding-device drill1 vise1 part5 side2-side5>
  63. <remove-burrs part5 brush1>
  64. <clean part5>
  65. <hold-with-vise drill1 vise1 part5 side2-side5>
  66. <tap drill1 tap1 vise1 part5 hole7>
  67. <release-from-holding-device drill1 vise1 part5 side2-side5>
  68. <remove-burrs part5 brush1>
  69. <clean part5>
  70. <hold-with-vise drill1 vise1 part5 side2-side5>
  71. <tap drill1 tap1 vise1 part5 hole6>
  72. <release-from-holding-device drill1 vise1 part5 side2-side5>
  73. <remove-burrs part5 brush1>
  74. <clean part5>
  75. <hold-with-vise drill1 vise1 part5 side2-side5>
  76. <tap drill1 tap1 vise1 part5 hole5>
  77. <remove-tool-from-machine drill1 tap1>
  78. <put-in-drill-spindle drill1 counterbore2>
  79. <release-from-holding-device drill1 vise1 part5 side2-side5>
  80. <remove-burrs part5 brush1>
  81. <clean part5>
  82. <hold-with-vise drill1 vise1 part5 side2-side5>
  83. <counterbore drill1 counterbore2 vise1 part5 hole4>
  84. <release-from-holding-device drill1 vise1 part5 side2-side5>
  85. <remove-burrs part5 brush1>
  86. <clean part5>
  87. <hold-with-vise drill1 vise1 part5 side2-side5>
  88. <counterbore drill1 counterbore2 vise1 part5 hole3>
  89. <release-from-holding-device drill1 vise1 part5 side2-side5>
  90. <remove-burrs part5 brush1>
  91. <clean part5>
  92. <hold-with-vise drill1 vise1 part5 side2-side5>
  93. <counterbore drill1 counterbore2 vise1 part5 hole2>
  94. <release-from-holding-device drill1 vise1 part5 side2-side5>
  95. <remove-burrs part5 brush1>
  96. <clean part5>
  97. <hold-with-vise drill1 vise1 part5 side2-side5>
  98. <counterbore drill1 counterbore2 vise1 part5 hole1>
  99. <remove-tool-from-machine drill1 counterbore2>
  100. <put-in-drill-spindle drill1 tap14>
  101. <release-from-holding-device drill1 vise1 part5 side2-side5>
  102. <remove-burrs part5 brush1>
  103. <clean part5>
  104. <hold-with-vise drill1 vise1 part5 side2-side5>
  105. <tap drill1 tap14 vise1 part5 hole4>
  106. <release-from-holding-device drill1 vise1 part5 side2-side5>
  107. <remove-burrs part5 brush1>
  108. <clean part5>
  109. <hold-with-vise drill1 vise1 part5 side2-side5>
  110. <tap drill1 tap14 vise1 part5 hole3>
  111. <release-from-holding-device drill1 vise1 part5 side2-side5>
  112. <remove-burrs part5 brush1>
  113. <clean part5>
  114. <hold-with-vise drill1 vise1 part5 side2-side5>
  115. <tap drill1 tap14 vise1 part5 hole2>
  116. <release-from-holding-device drill1 vise1 part5 side2-side5>
  117. <remove-burrs part5 brush1>
  118. <clean part5>
  119. <hold-with-vise drill1 vise1 part5 side2-side5>
  120. <tap drill1 tap14 vise1 part5 hole1>
  121. <put-tool-on-milling-machine milling-machine1 plain-mill1>
  122. <release-from-holding-device drill1 vise1 part5 side2-side5>
  123. <remove-holding-device-from-machine drill1 vise1>
  124. <put-holding-device-in-milling-machine milling-machine1 vise1>
  125. <remove-burrs part5 brush1>
  126. <clean part5>
  127. <put-on-machine-table milling-machine1 part5>
  128. <hold-with-vise milling-machine1 vise1 part5 side2-side5>
  129. <face-mill milling-machine1 part5 plain-mill1 vise1 side3 length 4>
  130. <release-from-holding-device milling-machine1 vise1 part5 side2-side5>
  131. <remove-burrs part5 brush1>
  132. <clean part5>
  133. <hold-with-vise milling-machine1 vise1 part5 side3-side6>
  134. <face-mill milling-machine1 part5 plain-mill1 vise1 side1 height 0.5>
  n683 <FACE-MILL MILLING-MACHINE1 PART5 END-MILL1 VISE1 SIDE6 LENGTH 4>

|#