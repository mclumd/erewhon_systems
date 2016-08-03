;; This is the standard problem. We need to transport four vital pieces
;; of cargo from London to Pittsburgh.

(setf (current-problem)
      (create-problem
       (name breakfast)
       (objects
	(London Pittsburgh Place)
	(Newcastle-Brown-Ale Kippers JaguarVI The_Times Cargo)
	(Rocket Rocket))
       (state
	(and (at rocket London)
	     (at Newcastle-Brown-Ale London)
	     (at Kippers London)
	     (at JaguarVI London)
	     (at The_Times London)))
       (igoal
	(and (at Newcastle-Brown-Ale Pittsburgh)
	     (at Kippers Pittsburgh)
	     (at JaguarVI Pittsburgh)
	     (at The_Times Pittsburgh)))))
