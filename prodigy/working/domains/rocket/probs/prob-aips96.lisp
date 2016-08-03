;; This is the standard problem. We need to transport four vital pieces
;; of cargo from London to Pittsburgh.

(setf (current-problem)
      (create-problem
       (name aips96)
       (objects
	(London Pittsburgh Place)
	(Kippers JaguarVI The_Times Cargo)
	(rocket Rocket))
       (state
	(and (at rocket London)
	     (at Kippers London)
	     (at JaguarVI London)
	     (at The_Times London)))
       (igoal
	(and (at Kippers Pittsburgh)
	     (at JaguarVI Pittsburgh)))))



(setf *xmargin* 30
      *ymargin* 10
      *width*  120
      *height* 70)





