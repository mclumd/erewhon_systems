
(setf result '(
   (time 0.25)
   (nodes 36)
   (exhaustedp nil)
   (solutionp t)
   (solution-length 8)
   (solution ((a1-4) (a1-7) (a1-8) (a1-11) (a2-4) (a2-7) (a2-8) (a2-11)))))

(setf goal '((g7) (g8) (g4) (g11)))
(setf initial-state '((i15) (i7) (i10) (i13) (i8) (i5) (i9) (i4) (i2)
                      (i12) (i3) (i14) (i1) (i11) (i6)))

(setf case-objects '(nil))
(setf insts-to-vars '(
   
))

(setf footprint-by-goal '(
   ((g11) (i11))
   ((g4) (i4))
   ((g8) (i8))
   ((g7) (i7))))
