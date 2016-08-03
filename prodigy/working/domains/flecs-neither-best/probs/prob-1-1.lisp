
(setf (current-problem)
      (create-problem (name test)
		      (objects
		       (wall1 wall2 object)
		       (white yellow light-blue green 
			      red dark-blue purple brown black color)
		       (roller1 roller2 roller))
		      (state
		       (and (needs-painting wall1) (needs-painting wall2) 
			    (clean roller1) (clean roller2)))
		      (goal (and (painted wall2 red) 
				 (painted wall1 green)))))



