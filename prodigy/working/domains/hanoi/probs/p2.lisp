
(setf (current-problem)
      (create-problem
       (name p2)
       (objects
	(objects-are peg1 peg2 peg3 Peg))
       (state
	(and (on disk1 peg1)
	     (on disk2 peg1)))
       (igoal (and (on disk1 peg2)
		   (on disk2 peg2)))))