
(setf (current-problem)
      (create-problem (name test4)
		      (objects
		       (g1 g2 g3 g4 goal))
		      (state
		       (and (i1) (i2) (i3) (i4)))
		      (goal (and (done g1) (done g3) (done g2) (done g4)))))
