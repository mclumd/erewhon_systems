;; This is the standard problem. We need to transport two vital pieces
;; of cargo from London to Pittsburgh.

(setf (current-problem)
      (create-problem
       (name breakfast)
       (objects
	(London Pittsburgh Place)
	(Newcastle-Brown-Ale Kippers JaguarVI Cargo)
	(Rocket Rocket))
       (state
	(and (at rocket London)
	     (at Newcastle-Brown-Ale London)
	     (at Kippers London)
	     (at JaguarVI London)))
       (igoal
	(and (at Newcastle-Brown-Ale Pittsburgh)
	     (at Kippers Pittsburgh)
	     (at JaguarVI Pittsburgh)))))
