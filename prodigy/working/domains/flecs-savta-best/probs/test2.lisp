(setf (current-problem)
      (create-problem (name test1)
		      (objects
		       (g1 g2 goal))
		      (state
		       (and (i1) (i2)))
		      (goal (and (done g2) (done g1)))))

