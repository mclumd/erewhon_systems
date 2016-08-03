
(setf result '(
   (time 0.25)
   (nodes 36)
   (exhaustedp nil)
   (solutionp t)
   (solution-length 8)
   (solution ((a1-2) (a1-10) (a1-11) (a1-13) (a2-2) (a2-10) (a2-11)
              (a2-13)))))

(setf goal '((g11) (g13) (g2) (g10)))
(setf initial-state '((i7) (i6) (i2) (i9) (i1) (i13) (i12) (i4) (i10)
                      (i8) (i15) (i3) (i5) (i11) (i14)))

(setf case-objects '(nil))
(setf insts-to-vars '(
   
))

(setf footprint-by-goal '(
   ((g10) (i10))
   ((g2) (i2))
   ((g13) (i13))
   ((g11) (i11))))
