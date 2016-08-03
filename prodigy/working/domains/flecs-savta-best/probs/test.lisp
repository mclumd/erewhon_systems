

(setf (current-problem)
      (create-problem (name test1)
		      (objects
		       (g1 g2 g3 g4 g5 goal))
		      (state
		       (and (i1) (i2) (i3) (i4) (i5)))
		      (goal (and (done g2) (done g3) (done g4) (done g1) (done g5)))))





