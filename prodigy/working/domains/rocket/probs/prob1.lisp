;; This is the standard problem. We need to transport two vital pieces
;; of cargo from London to Pittsburgh.

(setf (current-problem)
      (create-problem
       (name breakfast)
       (objects
	(London Pittsburgh Place)
	(Newcastle-Brown-Ale Kippers Cargo)
	(Rocket Rocket))
       (state
	(and (at rocket London)
	     (at Newcastle-Brown-Ale London)
	     (at Kippers London)))
       (igoal
	(and (at Newcastle-Brown-Ale Pittsburgh)
	     (at Kippers Pittsburgh)))))
  
