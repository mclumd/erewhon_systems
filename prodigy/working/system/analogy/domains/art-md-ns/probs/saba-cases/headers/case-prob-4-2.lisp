
(setf result '(
   (time 0.25)
   (nodes 36)
   (exhaustedp nil)
   (solutionp t)
   (solution-length 8)
   (solution ((a1-3) (a1-8) (a1-9) (a1-15) (a2-3) (a2-8) (a2-9) (a2-15)))))

(setf goal '((g3) (g8) (g15) (g9)))
(setf initial-state '((i7) (i15) (i6) (i5) (i12) (i9) (i4) (i11) (i14)
                      (i2) (i8) (i1) (i13) (i10) (i3)))

(setf case-objects '(nil))
(setf insts-to-vars '(
   
))

(setf footprint-by-goal '(
   ((g9) (i9))
   ((g15) (i15))
   ((g8) (i8))
   ((g3) (i3))))
