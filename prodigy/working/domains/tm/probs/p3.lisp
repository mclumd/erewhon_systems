(setf (current-problem)
      (create-problem
       (name p3)
       (objects
	(a b c d e f g
	 p1 p2 p3 p4 ;p5 p6 p7 p8 p9 p10
	 ;p11 p12 p13 p14 p15 p16 p17 p18 p19 p20
	 Path))
       (state
	(and (or2 b c a)
	     (and2 d e b)
	     (and2 f g c)
	     (tr-num 0)
	     (free-path p1)
	     (free-path p2)
	     (free-path p3)
	     (free-path p4)
	     ;(free-path p5)
	     ;(free-path p6)
	     ;(free-path p7)
	     ;(free-path p8)
	     ;(free-path p9)
	     ;(free-path p10)
	     ;(free-path p11)
	     ;(free-path p12)
	     ;(free-path p13)
	     ;(free-path p14)
	     ;(free-path p15)
	     ;(free-path p16)
	     ;(free-path p17)
	     ;(free-path p18)
	     ;(free-path p19)
	     ;(free-path p20)
	     ))
       (igoal (and (mapped) (tr-num 12)))))
   