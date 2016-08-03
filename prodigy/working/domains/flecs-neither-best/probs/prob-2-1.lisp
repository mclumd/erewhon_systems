(setf (current-problem)
      (create-problem (name test)
		      (objects
		       (wall2 wall3 wall5 object)
		       (white yellow light-blue green 
			      red dark-blue purple brown black color)
		       (roller1 roller2 roller))
		      (state
		       (and (needs-painting wall2) (needs-painting wall3) 
			    (needs-painting wall5) 
			    (clean roller1) (clean roller2)))
		      (goal (and (painted wall2 red) (painted wall3 red) 
				 (painted wall5 green)))))

