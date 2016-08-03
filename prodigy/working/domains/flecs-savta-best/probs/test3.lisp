(setf (current-problem)
      (create-problem (name test1)
		      (objects
		       (g1 g2 g3 goal))
		      (state
		       (and (i1) (i2) (i3)))
		      (goal (and (done g2) (done g3) (done g1)))))

