(setf (current-problem)
      (create-problem
       (name p5)
       (objects
	(a b c d e
	 Path))
       (state
	(and (not1 b a)
	     (not1 c b)
	     (not1 d c)
	     (not1 e d)
	     (tr-num 0)
	     ))
       (igoal (and (mapped) (tr-num 0)))))
