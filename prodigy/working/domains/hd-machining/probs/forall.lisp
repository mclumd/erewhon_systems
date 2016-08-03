;;from  tst-drillhole-2

(setf (current-problem)
     (create-problem
       (name forall)
       (objects
        (drill0 drill1 drill)
        (mm0 mm1 milling-machine)

        (spot-drill0 spot-drill)
        (twist-drill0 twist-drill)
        (tap0 tap)
        (counterbore)
        (countersink)
        (reamer0 reamer)
        (plain-mill0 plain-mill)

        (vise0 vise1 vise)

        (brush1 brush)
        (soluble-oil soluble-oil)
        (mineral-oil mineral-oil)
        (part0 part)
        (hole0 hole))

       (state
        (and
          (always-true)
          (diameter-of-drill-bit twist-drill0 1/6)
          (diameter-of-drill-bit tap0 1/4)
          (diameter-of-drill-bit reamer0 1/8)
          (material-of part0 aluminum)
          (size-of part0 length 5)
          (size-of part0 width 3)
          (size-of part0 height 3)
          (on-table drill0 part0)))

       (goal (is-clean part0))))