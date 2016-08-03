(setf (current-problem)
     (create-problem
       (name trn4-0) 
       (objects
        (drill0 drill)
        (mm0 milling-machine)

        (spot-drill0 spot-drill)
        (twist-drill0 twist-drill)
        (tap0 tap)
        (counterbore0 counterbore)
        (countersink0 countersink)
        (reamer0 reamer)
        (plain-mill0 plain-mill)

        (vise0 vise)

        (brush1 brush)
        (soluble-oil soluble-oil)
        (mineral-oil mineral-oil)
        (part0 part)
        (hole0 hole))

       (state
        (and
          (always-true)
          (diameter-of-drill-bit twist-drill0 1/6)
          (size-of-drill-bit counterbore0 1/4)
          (holding-tool drill0 counterbore0)
          (angle-of-drill-bit countersink0 82)
          (diameter-of-drill-bit tap0 1/8)
          (diameter-of-drill-bit reamer0 9/64)
          (holding-tool mm0 plain-mill0)
          (material-of part0 aluminum)
          (size-of part0 length 5)
          (size-of part0 width 3)
          (size-of part0 height 3)))

       (goal 
        (and
          (size-of part0 length 0.5)
          (size-of part0 height 2)))))

#|without rules
Solution:
  1. <put-holding-device-in-milling-machine mm0 vise0>
  2. <clean part0>
  3. <put-on-machine-table mm0 part0>
  4. <hold-with-vise mm0 vise0 part0 side1 side3-side6>
  5. <face-mill mm0 part0 plain-mill0 vise0 side1 side3-side6 height 3 2>
  6. <release-from-holding-device mm0 vise0 part0 side1 side3-side6>
  7. <remove-burrs part0 brush1>
  8. <clean part0>
  9. <hold-with-vise mm0 vise0 part0 side3 side2-side5>
  10. <face-mill mm0 part0 plain-mill0 vise0 side3 side2-side5 length 5 0.5>

compute-cost = 60
#<PRODIGY result: T, 7.784 secs, 65 nodes, 1 sol>

;;with learned rules
Solution:
  1. <put-holding-device-in-milling-machine mm0 vise0>
  2. <clean part0>
  3. <put-on-machine-table mm0 part0>
  4. <hold-with-vise mm0 vise0 part0 side3 side2-side5>
  5. <side-mill mm0 part0 plain-mill0 vise0 side3 side2-side5 side4 height 3 2>
  6. <face-mill mm0 part0 plain-mill0 vise0 side3 side2-side5 length 5 0.5>

compute-cost = 32
#<PRODIGY result: T, 5.866 secs, 46 nodes, 1 sol>

|#

;;; ************************************************************

   (setf (current-problem)
     (create-problem
       (name trn6a-new3-3)
       (objects
        (drill0 drill)
        (mm0 milling-machine)

        (spot-drill0 spot-drill)
        (twist-drill0 twist-drill)
        (tap0 tap)
        (counterbore0 counterbore)
        (countersink0 countersink)
        (reamer0 reamer)
        (plain-mill0 plain-mill)

        (vise0 vise)

        (brush1 brush)
        (soluble-oil soluble-oil)
        (mineral-oil mineral-oil)
        (part0 part)
        (hole0 hole))

       (state
        (and
          (always-true)
          (holding-tool drill0 spot-drill0)
          (diameter-of-drill-bit twist-drill0 1/6)
          (holding-tool mm0 twist-drill0)
          (size-of-drill-bit counterbore0 1/2)
          (angle-of-drill-bit countersink0 82)
          (diameter-of-drill-bit tap0 9/64)
          (diameter-of-drill-bit reamer0 1/8)
          (has-device mm0 vise0)
          (material-of part0 aluminum)
          (size-of part0 length 5)
          (size-of part0 width 3)
          (size-of part0 height 3)
          (holding mm0 vise0 part0 side1 side2-side5)))

       (goal 
        (and
          (size-of part0 length 4)
          (size-of part0 height 0.5)
          (has-hole part0 hole0 side1 0.3 1/6 2.42 0.25)))))
#|
;;without rules

Solution:
  1. <release-from-holding-device mm0 vise0 part0 side1 side2-side5>
  2. <remove-holding-device-from-machine mm0 vise0>
  3. <put-holding-device-in-drill drill0 vise0>
  4. <clean part0>
  5. <put-on-machine-table drill0 part0>
  6. <hold-with-vise drill0 vise0 part0 side1 side2-side5>
  7. <drill-with-spot-drill drill0 spot-drill0 vise0 part0 hole0 side1 side2-side5 2.42 0.25>
  8. <remove-tool-from-machine drill0 spot-drill0>
  9. <remove-tool-from-machine mm0 twist-drill0>
  10. <put-in-drill-spindle drill0 twist-drill0>
  11. <release-from-holding-device drill0 vise0 part0 side1 side2-side5>
  12. <remove-burrs part0 brush1>
  13. <clean part0>
  14. <hold-with-vise drill0 vise0 part0 side1 side3-side6>
  15. <drill-with-twist-drill drill0 twist-drill0 vise0 part0 hole0 side1 side3-side6 0.3 1/6 1/6 2.42 0.25>
  16. <put-tool-on-milling-machine mm0 plain-mill0>
  17. <release-from-holding-device drill0 vise0 part0 side1 side3-side6>
  18. <remove-holding-device-from-machine drill0 vise0>
  19. <put-holding-device-in-milling-machine mm0 vise0>
  20. <remove-burrs part0 brush1>
  21. <clean part0>
  22. <put-on-machine-table mm0 part0>
  23. <hold-with-vise mm0 vise0 part0 side1 side2-side5>
  24. <face-mill mm0 part0 plain-mill0 vise0 side1 side2-side5 height 3 0.5>
  25. <release-from-holding-device mm0 vise0 part0 side1 side2-side5>
  26. <remove-burrs part0 brush1>
  27. <clean part0>
  28. <hold-with-vise mm0 vise0 part0 side3 side2-side5>
  29. <face-mill mm0 part0 plain-mill0 vise0 side3 side2-side5 length 5 4>

compute-cost = 162
#<PRODIGY result: T, 28.083 secs, 171 nodes, 1 sol>

;;with learned rules
Solution:
  1. <remove-tool-from-machine mm0 twist-drill0>
  2. <remove-tool-from-machine drill0 spot-drill0>
  3. <put-tool-on-milling-machine mm0 spot-drill0>
  4. <drill-with-spot-drill-in-milling-machine mm0 spot-drill0 vise0 part0 hole0 side1 side2-side5 2.42 0.25>
  5. <remove-tool-from-machine mm0 spot-drill0>
  6. <put-tool-on-milling-machine mm0 twist-drill0>
  7. <drill-with-twist-drill-in-milling-machine mm0 twist-drill0 vise0 part0 hole0 side1 side2-side5 0.3 1/6 1/6 2.42 0.25>
  8. <remove-tool-from-machine mm0 twist-drill0>
  9. <put-tool-on-milling-machine mm0 plain-mill0>
  10. <face-mill mm0 part0 plain-mill0 vise0 side1 side2-side5 height 3 0.5>
  11. <side-mill mm0 part0 plain-mill0 vise0 side1 side2-side5 side6 length 5 4>

compute-cost = 11
#<PRODIGY result: T, 7.4 secs, 69 nodes, 1 sol>
|#









