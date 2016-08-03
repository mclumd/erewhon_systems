;;; Designed to test the partial order generator.  Does not seem to
;;; work. However, the many-cities problem of the standard logistics domain
;;; does. 

(setf (current-problem)
      (create-problem
       (name mcox1)
       (objects
	(blockA blockB blockC blockD object))
       (state
	(and (on-table blockA)
	     (on-table blockB)
	     (on-table blockC)
	     (on-table blockD)
	     (clear blockA)
	     (clear blockB)
	     (clear blockC)
	     (clear blockD)
	     (arm-empty)))

       (igoal
	(and (on blocka blockb)
	     (on blockc blockd)))))