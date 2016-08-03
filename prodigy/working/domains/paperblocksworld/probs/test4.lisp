;;; Test for the armempty inference rule, for exists

(setf (current-problem)
      (create-problem
       (name infer-arm-empty)
       (objects
	(objects-are block1 block2 block3 Object))
       (state (and (on-table block1)
		   (on-table block3)
		   (on block2 block1)
		   (clear block2)
		   (clear block3)
		   (arm-empty)))
       (igoal (holding block1))))
