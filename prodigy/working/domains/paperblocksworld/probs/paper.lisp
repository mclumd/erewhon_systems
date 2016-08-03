;;; This problem is the one from the Prodigy 2.0 manual

(setf (current-problem)
      (create-problem
       (name Prod_2.0_Manual)
       (objects
	(objects-are blockA blockB blockC Object)
	;;(blocka blocka)
	;;(blockb blockb)
	;;(blockc blockc)
	)
       (state
	(and (arm-empty)
	     (clear blockC)
	     (on-table blockA)
	     (on blockC blockB)
	     (on blockB blockA)))
       (igoal
	(holding blockB))))