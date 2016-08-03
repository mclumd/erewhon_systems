(setf (current-problem)
      (create-problem
       (name p0-1)
       (objects
	(a b c 
	 p1 ; p2 p3 p4 p5
	 ;p6 p7 p8 p9 p10
	 Path))
       (state
	(and (and2 b c a)
	     (tr-num 0)
	     (free-path p1)
	     ;(free-path p2)
	     ;(free-path p3)
	     ;(free-path p4)
	     ;(free-path p5)
	     ;(free-path p6)
	     ;(free-path p7)
	     ;(free-path p8)
	     ;(free-path p9)
	     ;(free-path p10)
))
       (igoal (mapped))))

   